USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    TYPE INTERNAL
        MoveModeOnFixedStop : INT (
            StopAtPosition := INT#20,
            MoveOutOfClamping := INT#21,
            MoveToTargetPosition := INT#22
        ) := StopAtPosition;

        EncoderType : INT (
            Incremental := INT#0,
            Absolute := INT#1
        ) := Incremental;

        ExecState : USINT (
            Idle := USINT#0,
            Initialize := USINT#1,
            RequestVelocity := USINT#11,
            AwaitVelocity := USINT#12,
            RequestHome := USINT#21,
            AwaitHome := USINT#22,
            RequestMove := USINT#31,
            AwaitMove := USINT#32,
            AwaitOutOfClamping := USINT#33,
            AwaitInClamping := USINT#34,
            AwaitHomeIdle := USINT#35,
            StartClampingDetection := USINT#41,
            StopClampingDetection := USINT#42,
            ResetClampingDetection := USINT#43,
            AwaitClamping := USINT#44,
            Aborted := USINT#99,
            Error := USINT#255
        ) := Idle;
    END_TYPE

    CLASS INTERNAL HomeOnFixedStopCommand EXTENDS Command IMPLEMENTS IHomeCommand
        VAR
            // commands 
            _moveVelocity : MoveVelocityCommand;
            _moveVelCmd : ICommand;

            _homing : HomeCommand;
            _homingCmd : IHomeCommand;

            _moveAbsolute : MoveAbsoluteCommand;
            _moveAbsCmd: ICommand;

            // Values
            _moveDirection : INT;
            _homingMode : INT;
            _moveTargetPosition : LREAL;
            _homingPosition : LREAL;
            _basicVelocity : LREAL;
            _basicAcceleration : LREAL;
            _basicDeceleration : LREAL;
            _basicJerk : LREAL;
            _torqueLimit : LREAL;
            _moveOnFixedStopMode : MoveModeOnFixedStop;
            _referenceMarkPosition : LREAL;

            // States
            _homeState : ExecState;
            _detectState : ExecState;

            // The axis
            _posAxisItf : IPosAxis; // as interface
            _posAxisRef : REF_TO TO_PositioningAxis; // as reference to TO

            _errorHandler : HomeFixedStopErrorHandler;
        END_VAR

        VAR CONSTANT
            ERR_MODULO_NOT_ALLOWED : WORD := WORD#16#8208;   // Extended homing moveMode (homing on fixed stop process) is not allowed with modulo axis
            ERR_INVALID_TORQUE_LIMIT : WORD := WORD#16#8209;   // Configured torque limit value for extended homing moveMode (homing on fixed stop process) = 0
            ERR_INVALID_VELOCITY : WORD := WORD#16#820A;   // Configured velocity (in technology object) for active homing = 0
            ERR_INVALID_TARGET_POSITION : WORD := WORD#16#820C;   // Invalid target position configured for extended homing moveMode

            DISTANCE_SCALING : LREAL := 1.05;   // Scaling factor for moving out of clamping. 1.0 = positioning window
        END_VAR

        {inline}
        METHOD INTERNAL Start : IHomeCommand
            VAR_INPUT
                posAxis : IPosAxis;
                homingPos : LREAL;
                encoderType : EncoderType;
                moveMode :  MoveModeOnFixedStop;
                torqueLmt : LREAL; // Value of the torque/force (default: 0.0)
                targetPos : LREAL; // Target position when 'moveMode' = 'MoveToTargetPosition'
            END_VAR

            VAR
                _initFxdStpStatus: WORD;
            END_VAR

            // initialize state of this command - important for restarting a command
            this.InitState();

            _posAxisItf := posAxis;
            _posAxisRef := posAxis.GetPositioningAxisRef();

            // check given input
            _initFxdStpStatus := this.InitializeFixedStop (posAxis, homingPos, encoderType, moveMode, torqueLmt, targetPos);

            // Set first status
            _homeState := this.CheckError(errorWord := _initFxdStpStatus, curState := ExecState#Initialize, nextState := ExecState#RequestVelocity);
            _detectState := this.CheckError(errorWord := _initFxdStpStatus, curState := ExecState#Initialize, nextState := ExecState#StartClampingDetection);

            this.Execute();

            Start := THIS;
        END_METHOD

        // Returns Error while initialization
        METHOD PRIVATE InitializeFixedStop : WORD
            VAR_INPUT
                posAxis : IPosAxis;
                homingPos : LREAL;
                encoderType : EncoderType;
                moveMode :  MoveModeOnFixedStop;
                torqueLmt : LREAL; // Value of the torque/force
                targetPos : LREAL; // Target position when 'moveMode' = 'MoveToTargetPosition'
            END_VAR

            VAR
                _index : INT;
            END_VAR

            InitializeFixedStop := WORD#16#0000;

            // Read operative sensor
            _index := TO_INT(_posAxisRef^.OperativeSensor);
            IF (_index < 1) THEN
                _index := 1;
            END_IF;

            IF (_posAxisRef^.Sensor[_index].ActiveHoming.Direction = 0) THEN
                // Positive direction
                _moveDirection := DirectionModulo#POSITIVE;
            ELSE
                // Negative direction
                _moveDirection := DirectionModulo#NEGATIVE;
            END_IF;

            // Check if homing on fixed stop is allowed
            IF (_posAxisRef^.Modulo.Enable = TRUE) THEN
                // Modulo enabled - Errorhandling
                InitializeFixedStop := ERR_MODULO_NOT_ALLOWED;
                RETURN;
            ELSIF (torqueLmt = 0.0) THEN // Torqueliming 0 in configuration
                // Errorhandling -  Torquevalue 0 configured
                InitializeFixedStop := ERR_INVALID_TORQUE_LIMIT;
                RETURN;
            ELSIF (_posAxisRef^.Homing.ReferencingVelocity = 0.0) THEN
                // Errorhandling -  Velocity 0 configured
                InitializeFixedStop := ERR_INVALID_VELOCITY;
                RETURN;
            ELSIF (moveMode = MoveModeOnFixedStop#MoveToTargetPosition)
                AND ((targetPos > homingPos) AND (_moveDirection = DirectionModulo#POSITIVE) OR
                    (targetPos < homingPos) AND (_moveDirection = DirectionModulo#NEGATIVE))
            THEN
                // Errorhandling -  invalid target
                InitializeFixedStop := ERR_INVALID_TARGET_POSITION;
                RETURN;
            ELSE
                _homingPosition := homingPos;
                _torqueLimit := torqueLmt;
                _moveOnFixedStopMode := moveMode;
                _moveTargetPosition := targetPos;
                _basicVelocity := _posAxisRef^.Homing.ReferencingVelocity;
                _basicAcceleration := _posAxisRef^.DynamicDefaults.Acceleration;
                _basicDeceleration := _posAxisRef^.DynamicDefaults.Deceleration;
                _basicJerk := _posAxisRef^.DynamicDefaults.Jerk;

                // Determine the encoder type
                IF (encoderType = EncoderType#Incremental) THEN
                    _homingMode := HomingModeDirect#ACTUAL_POSITION_ABSOLUTE; // Direct homing (absolute)
                ELSE
                    _homingMode := HomingModeAbsEncoder#ADJUSTMENT_SENSOR_ABSOLUTE; // Absolut encoder adjustment
                END_IF;
            END_IF;
        END_METHOD

        {inline}
        METHOD OVERRIDE Execute
            VAR
                _callStatus : WORD;
                _asSpeedAxisRef : REF_TO TO_SpeedAxis;
                _asAxisRef : REF_TO TO_Axis;

                _goAhead: BOOL;
            END_VAR

            _asSpeedAxisRef := REF(_posAxisRef^);
            _asAxisRef := REF(_posAxisRef^);

            REPEAT
                CASE _homeState OF
                    ExecState#RequestVelocity:
                        _moveVelCmd := _moveVelocity.Start(
                            axisRef := _asSpeedAxisRef,
                            velocity := _basicVelocity,
                            acceleration := _basicAcceleration,
                            deceleration := _basicDeceleration,
                            jerk := _basicJerk,
                            positionControlled := TRUE,
                            direction := _moveDirection
                        );
                        _homeState := ExecState#AwaitVelocity;
                        _goAhead := TRUE;

                    ExecState#AwaitVelocity:
                        _homeState := THIS.AwaitCommand(
                            cmd := _moveVelCmd,
                            curState := _homeState,
                            nextState := ExecState#AwaitInClamping,
                            stateChanged => _goAhead
                        );

                    ExecState#AwaitInClamping:
                        IF this.GetPosAxisStatus().inClamping THEN
                            _homeState := ExecState#RequestHome;
                        END_IF;
                        _goAhead := _homeState <> ExecState#AwaitInClamping;

                    ExecState#RequestHome:
                        _homingCmd := _homing.Start(axisRef := _asAxisRef, position := _homingPosition, mode := _homingMode);
                        _homeState := ExecState#AwaitHome;
                        _goAhead := TRUE;

                    ExecState#AwaitHome:
                        _referenceMarkPosition := _homingCmd.ReferenceMarkPosition();
                        _homeState := THIS.AwaitCommand(
                            cmd := _homingCmd,
                            curState := _homeState,
                            nextState := ExecState#RequestMove,
                            stateChanged => _goAhead
                        );

                    ExecState#RequestMove:
                        _moveAbsCmd := _moveAbsolute.Start(
                            axisRef := _posAxisRef,
                            position := this.GetHomingPositionOnFixedStopMode(),
                            velocity := this.ABS(_basicVelocity),
                            acceleration := _basicAcceleration,
                            deceleration := _basicDeceleration,
                            jerk := _basicJerk,
                            direction := DirectionModulo#SHORTEST_DISTANCE
                        );
                        _homeState := ExecState#AwaitMove;
                        _goAhead := TRUE;

                    ExecState#AwaitMove:
                        _homeState := THIS.AwaitCommand(
                            cmd := _moveAbsCmd,
                            curState := _homeState,
                            nextState := ExecState#AwaitOutOfClamping,
                            stateChanged => _goAhead
                        );

                    ExecState#AwaitOutOfClamping:
                        IF _moveOnFixedStopMode = MoveModeOnFixedStop#MoveOutOfClamping OR
                            _moveOnFixedStopMode = MoveModeOnFixedStop#MoveToTargetPosition
                        THEN
                            IF this.GetPosAxisStatus().inClamping THEN
                                _homeState := ExecState#RequestMove;
                            ELSE
                                _homeState := ExecState#Idle;
                            END_IF;
                        ELSE
                            _homeState := ExecState#Idle;
                        END_IF;
                        _goAhead :=  _homeState <> ExecState#AwaitOutOfClamping;

                    ExecState#Error:
                        _errorHandler.HandleError(hasError=>_error, errorID=>_errorID);
                        _aborted := FALSE;
                        _done := FALSE;
                        _goAhead := FALSE;

                    ExecState#Aborted:
                        _aborted := TRUE;
                        _done := FALSE;
                        _error := FALSE;
                        _errorID := WORD#16#0;
                        _goAhead := FALSE;

                    ExecState#Idle:
                        _goAhead := FALSE;

                END_CASE;
            UNTIL (_goAhead = FALSE) END_REPEAT;

            REPEAT
                CASE _detectState OF
                    ExecState#StartClampingDetection:
                        _callStatus := this.EnableFixedStopDetection(limit := _torqueLimit);
                        _detectState := this.CheckError(errorWord := _callStatus, curState:=_detectState, nextState:=ExecState#AwaitHomeIdle);
                        _goAhead := TRUE;

                    ExecState#AwaitHomeIdle:
                        IF _homeState = ExecState#Idle THEN
                            _detectState := ExecState#StopClampingDetection;
                        END_IF;
                        _goAhead := _detectState <> ExecState#AwaitHomeIdle;

                    ExecState#StopClampingDetection:
                        this.DisableFixedStopDetection();
                        _detectState := ExecState#Idle;
                        _goAhead := TRUE;

                    ExecState#Error:
                        _errorHandler.HandleError(hasError=>_error, errorID=>_errorID);
                        _aborted := FALSE;
                        _done := FALSE;
                        _goAhead := FALSE;

                    ExecState#Idle:
                        _aborted := FALSE;
                        IF _homeState = ExecState#Idle THEN
                            _done := TRUE;
                            _error := FALSE;
                            _errorID := WORD#16#0;
                        END_IF;
                        _goAhead := FALSE;

                END_CASE;
            UNTIL (_goAhead = FALSE) END_REPEAT;
        END_METHOD

        METHOD PUBLIC ReferenceMarkPosition : LREAL
            this.ExecuteIfBusy();
            ReferenceMarkPosition := _referenceMarkPosition;
        END_METHOD

        METHOD PRIVATE GetPosAxisStatus : AxisStatus
            GetPosAxisStatus := GetAxisStatus(_posAxisRef^.StatusWord, _posAxisRef^.StatusWord2);
        END_METHOD

        METHOD PRIVATE GetHomingPositionOnFixedStopMode : LREAL
            CASE _moveOnFixedStopMode OF
                MoveModeOnFixedStop#StopAtPosition:
                    GetHomingPositionOnFixedStopMode := _homingPosition;

                MoveModeOnFixedStop#MoveOutOfClamping:
                    CASE _moveDirection OF
                        DirectionModulo#POSITIVE:
                            _homingPosition := _homingPosition - (DISTANCE_SCALING * _posAxisRef^.Clamping.PositionTolerance);
                        DirectionModulo#NEGATIVE:
                            _homingPosition := _homingPosition + (DISTANCE_SCALING * _posAxisRef^.Clamping.PositionTolerance);
                    END_CASE;

                    GetHomingPositionOnFixedStopMode := _homingPosition;

                MoveModeOnFixedStop#MoveToTargetPosition:
                    GetHomingPositionOnFixedStopMode := _moveTargetPosition;

            END_CASE;
        END_METHOD

        METHOD PUBLIC EnableFixedStopDetection : Word
            VAR_INPUT
                limit : LREAL := -1.0;
            END_VAR

            // here we need to use the interface method of the PosAxis
            // in order to use the same natvie MC_TorqueLimiting instance
            // which is necessary when the user has already set a general torque limit
            // using another instance of MC_TorqueLimiting in this implementation will generate an error
            EnableFixedStopDetection := _posAxisItf.SetTorqueLimit(
                mode  := TorqueLimitingMode#FIXED_STOP_DETECTION,
                limit := limit
            );
        END_METHOD

        METHOD PUBLIC DisableFixedStopDetection
            _posAxisItf.ResetTorqueLimit();
        END_METHOD

        METHOD PRIVATE AwaitCommand : ExecState
            VAR_INPUT
                cmd : ICommand;
                curState : ExecState;
                nextState : ExecState;
            END_VAR

            VAR_OUTPUT
                stateChanged : BOOL;
            END_VAR

            // cmd could be null due to separate state machines per axis
            IF cmd = NULL THEN
                AwaitCommand := curState;
                Return;
            END_IF;

            IF cmd.Done() THEN
                AwaitCommand := nextState;
            ELSIF cmd.Error() THEN
                AwaitCommand := this.CheckError(cmd.ErrorID(), curState, nextState);
            ELSIF cmd.Aborted() THEN
                AwaitCommand := ExecState#Aborted;
            ELSE
                AwaitCommand := curState;
            END_IF;

            stateChanged := AwaitCommand <> curState;
        END_METHOD

        METHOD PRIVATE CheckError : ExecState
            VAR_INPUT
                errorWord : WORD;
                curState : ExecState;
                nextState : ExecState;
            END_VAR

            IF (errorWord <> WORD#0) THEN
                _errorHandler.SetExecState(curState);
                _errorHandler.SetErrorID(errorWord);
                CheckError := ExecState#Error;
            ELSE
                CheckError := nextState; // wait at current state
            END_IF;
        END_METHOD

        METHOD PRIVATE ABS : LREAL
            VAR_INPUT
                x : LREAL;
            END_VAR

            IF x < 0.0 THEN
                ABS := -1.0 * x;
            ELSE
                ABS := x;
            END_IF;
        END_METHOD
    END_CLASS

    CLASS FINAL HomeFixedStopErrorHandler
        VAR PRIVATE
            _errorID : WORD;
            _execState : ExecState;
        END_VAR

        METHOD PUBLIC SetExecState
            VAR_INPUT
                state: ExecState;
            END_VAR
            
            _execState := state;
        END_METHOD

        METHOD PUBLIC SetErrorID
            VAR_INPUT
                errorID : WORD;
            END_VAR
            
            _errorID := errorID;
        END_METHOD

        METHOD PUBLIC HandleError
            VAR_OUTPUT
                hasError : BOOL;
                errorID : WORD;
            END_VAR

            hasError := errorID <> WORD#0;
            errorID := errorID;
        END_METHOD

        // Getter methods for readonly access to class members
        METHOD PUBLIC GetExecState : ExecState
            GetExecState := _execState;
        END_METHOD
    END_CLASS
END_NAMESPACE
