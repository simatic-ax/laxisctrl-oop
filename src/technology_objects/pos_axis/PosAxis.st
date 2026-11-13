USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    TYPE INTERNAL
        typeJogData : STRUCT
            forwardOld : BOOL;
            backwardOld : BOOL;
            moveCmd : ICommand;
            haltCmd : ICommand;
            invalidJogDirectionError : BOOL;
            lastJogMode : INT;
            lastIncrementCompleted : BOOL := TRUE;
            lastTargetPosition : LREAL;
            lastMoveDirectionForward : BOOL; // TRUE if JogForward, FALSE if JogBackward or first jog increment.
        END_STRUCT;
    END_TYPE

    CLASS PUBLIC PosAxis EXTENDS SpeedAxis IMPLEMENTS IPosAxis
        VAR PRIVATE
            homeCmd : HomeCommand;
            moveAbsoluteCmd : MoveAbsoluteCommand;
            moveRelativeCmd : MoveRelativeCommand;
            moveSuperimposedCmd : MoveSuperimposedCommand;
            haltSuperimposedCmd : HaltSuperimposedCommand;
            homeOnFixedStopCmd : HomeOnFixedStopCommand;
            jog : typeJogData;
        END_VAR

        VAR CONSTANT
            ERR_INVALID_JOG_MODE : WORD := WORD#16#8201;   // Invalid jog mode selected
            ERR_INVALID_JOG_DIR : WORD := WORD#16#8007;   // Invalid direction selected (JogForward and JogBackward)
        END_VAR

        VAR PROTECTED
            _positioningAxisRef : REF_TO TO_PositioningAxis;
        END_VAR

        METHOD INTERNAL Attach : BOOL
            VAR_INPUT
                axis : REF_TO TO_PositioningAxis;
            END_VAR

            _positioningAxisRef := axis;
            SUPER.Attach(axis);
            Attach := this.IsAttached();
        END_METHOD

        /// Attaches the given technology object of type TO_PositioningAxis to this specific instance.
        METHOD PUBLIC OVERRIDE Attach : BOOL
            VAR_IN_OUT
                axis : TO_PositioningAxis;
            END_VAR

            _resolvedType := TO_Type#PositioningAxis;
            Attach := this.Attach(AsPositioningAxisRef(axis));
        END_METHOD

        /// Attaches the given technology object of type TO_SynchronousAxis to this specific instance.
         METHOD PUBLIC OVERRIDE Attach : BOOL
            VAR_IN_OUT
                axis : TO_SynchronousAxis;
            END_VAR

            _resolvedType := TO_Type#SynchronousAxis;
            Attach := this.Attach(AsSynchronousAxisRef(axis));
        END_METHOD

        /// Attaches the given technology object of any type to this specific instance.
        METHOD PUBLIC OVERRIDE Attach : BOOL
            VAR_INPUT
                axisDB : DB_ANY;
            END_VAR

            _resolvedType := GetType(axisDB);
            Attach := this.Attach(AsPositioningAxisRef(axisDB));
        END_METHOD

        /// Detaches the current assigned technology object from this instance.
        METHOD PUBLIC OVERRIDE Detach : BOOL
            _positioningAxisRef := NULL;
            SUPER.Detach();
            Detach := this.IsAttached();
        END_METHOD

        /// IsAttached returns the state of the attached technology object for this instance.
        METHOD PUBLIC OVERRIDE IsAttached : BOOL
            IsAttached := (_positioningAxisRef <> NULL);
        END_METHOD

        /// With method GetPositioningAxisRef, you get the reference of the attached positioning axis.
        METHOD PUBLIC GetPositioningAxisRef : REF_TO TO_PositioningAxis
            GetPositioningAxisRef := _positioningAxisRef;
        END_METHOD

        /// Gets the reference of the attached technology object.
        METHOD PUBLIC GetAxisRef : REF_TO TO_Axis
            GetAxisRef := _axisRef;
        END_METHOD

        /// With the method PowerOn, a positioning or synchronous axis is enabled and set to position-controlled mode by default.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD PUBLIC PowerOn : ICommand
            VAR_INPUT
                /// FALSE = Enables axis non position-controlled.
                /// TRUE = Enables axis position-controlled.
                positionControlled : BOOL;
            END_VAR

            PowerOn := _powerCmd.Start(AxisRef := _axisRef, enable := TRUE, positionControlled := positionControlled, stopMode := PowerOffMode#EMERGENCY_STOP);
        END_METHOD

        /// With the method MoveVelocity, you move an axis at constant velocity/speed.
        /// You define the dynamic behavior of the motion with parameters Velocity, Acceleration, Deceleration and Jerk.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD PUBLIC OVERRIDE MoveVelocity : ICommand
            VAR_INPUT
                /// Velocity setpoint for the motion.
                /// Value 0.0 is permitted
                velocity : LREAL := LREAL#100.0;
                /// Acceleration setpoint for the motion.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Value 0.0 is not permitted
                acceleration : LREAL := LREAL#-1.0;
                /// Deceleration setpoint for the motion.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Value 0.0 is not permitted
                deceleration : LREAL := LREAL#-1.0;
                /// Jerk setpoint for the motion.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Trapezoid velocity profile is applied when = 0.0
                jerk : LREAL := LREAL#-1.0;
                /// Direction of the motion.
                direction : Direction := Direction#VELOCITY_SPECIFIED;
                /// FALSE = Move axis non position-controlled.
                /// TRUE = Move axis position-controlled.
                /// This parameter is ignored for TO_SpeedAxis.
                positionControlled : BOOL := FALSE;
            END_VAR

            MoveVelocity := _moveVelocityCmd.Start(
                axisRef := _speedAxisRef,
                velocity := velocity,
                acceleration := acceleration,
                deceleration := deceleration,
                jerk := jerk,
                positionControlled := positionControlled,
                direction := direction
            );
        END_METHOD

        /// With the method MoveJog, you move an axis at jog mode.
        /// You define the dynamic behavior of the motion with parameters Velocity, Acceleration, Deceleration and Jerk.
        METHOD PUBLIC MoveJog
            VAR_INPUT
                /// Jog in positive direction.
                /// Defaults to FALSE
                jogForward : BOOL;
                /// Jog in negative direction.
                /// Defaults to FALSE
                jogBackward : BOOL;
                /// Velocity setpoint for the motion.
                /// Absolute value is used when < 0.0
                velocity : LREAL := LREAL#100.0;
                /// Deceleration setpoint for the motion.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Value 0.0 is not permitted
                acceleration : LREAL := LREAL#-1.0;
                /// Deceleration setpoint for the motion.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Value 0.0 is not permitted                
                deceleration : LREAL := LREAL#-1.0;
                /// Jerk setpoint for the motion.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Trapezoid velocity profile is applied when = 0.0                
                jerk : LREAL := LREAL#-1.0;
                /// FALSE = Jog axis non position-controlled.
                /// TRUE = Jog axis position-controlled.
                positionControlled : BOOL := TRUE;
                /// Increment/distance for Mode: INCREMENTAL, CONTINUE_INCREMENT
                increment : LREAL := LREAL#0.0;
                /// The mode of jogging operation.
                mode : JogMode := JogMode#CONTINUOUS;
            END_VAR

            VAR_OUTPUT
                /// The Velcoity setpoint has been reached.
                inVelocity : BOOL;
                /// The job is being processed.
                busy : BOOL;
                /// The job was aborted by another job during execution.
                commandAborted : BOOL;
                /// An error occurred while processing the job. The cause of the error can be found in the ErrorID parameter.
                error : BOOL;
                /// The error ID of the operation (refer to the list of error IDs in manual from Siemens.S7.MotionControl library).
                errorID : WORD;
            END_VAR

            VAR_TEMP
                tempStartJogging : BOOL;
                tempStopJogging : BOOL;
                tempIncrementAbs : LREAL;
            END_VAR

            IF mode = JogMode#CONTINUOUS THEN
                _moveJog(
                    Axis := _speedAxisRef^,
                    JogForward := jogForward,
                    JogBackward := jogBackward,
                    Velocity := velocity,
                    Acceleration := acceleration,
                    Deceleration := deceleration,
                    Jerk := jerk,
                    PositionControlled := positionControlled,
                    InVelocity => inVelocity,
                    Busy => busy,
                    CommandAborted => commandAborted,
                    Error => error,
                    ErrorID => errorID
                );

                jog.forwardOld := jogForward;
                jog.backwardOld := jogBackward;
                jog.invalidJogDirectionError := errorID = ERR_INVALID_JOG_MODE;

                IF jog.lastJogMode <> JogMode#CONTINUOUS THEN
                    // reset internal state for incremental modes
                    jog.lastJogMode := JogMode#CONTINUOUS;
                    jog.moveCmd := NULL; // is aborted by MC_MoveJog (see override response table in the docu)
                    jog.haltCmd := NULL; // is aborted by MC_MoveJog (see override response table in the docu)
                    jog.lastIncrementCompleted := TRUE; // forget last increment
                END_IF;
                RETURN;
            END_IF;

            IF jog.lastJogMode <> mode THEN
                IF jog.lastJogMode = JogMode#CONTINUOUS THEN // Stop continuous jogging!
                    _moveJog(Axis := _speedAxisRef^, JogForward := FALSE, JogBackward := FALSE);
                END_IF;

                jog.lastJogMode := mode;
            END_IF;

            IF jogForward <> jog.forwardOld THEN
                jog.forwardOld := jogForward;
                IF jogForward THEN
                    IF jogBackward THEN
                        jog.invalidJogDirectionError := TRUE;
                    ELSE
                        tempStartJogging := TRUE;
                    END_IF;
                ELSE
                    tempStopJogging := TRUE;
                END_IF;
            END_IF;

            IF jogBackward <> jog.backwardOld THEN
                jog.backwardOld := jogBackward;
                IF jogBackward THEN
                    IF jogForward THEN
                        jog.invalidJogDirectionError := TRUE;
                    ELSE
                        tempStartJogging := TRUE;
                    END_IF;
                ELSE
                    tempStopJogging := TRUE;
                END_IF;
            END_IF;

            IF mode < JogMode#CONTINUOUS OR mode > JogMode#CONTINUE_INCREMENT THEN
                tempStartJogging := FALSE;
                tempStopJogging := TRUE;
                error := TRUE;
                errorID := ERR_INVALID_JOG_MODE;
            END_IF;

            IF jog.invalidJogDirectionError THEN
                tempStartJogging := FALSE;
                IF jog.haltCmd = NULL THEN
                    IF jog.moveCmd <> NULL THEN
                        tempStopJogging := TRUE;
                    ELSIF NOT (jogForward OR jogBackward) THEN
                        jog.invalidJogDirectionError := FALSE;
                    END_IF;
                END_IF;
            END_IF;

            IF tempStartJogging THEN
                IF (mode = JogMode#INCREMENTAL)
                    OR (jog.lastIncrementCompleted)
                    OR (jog.lastMoveDirectionForward <> jogForward) // Set new Increment if direction changed
                    OR (jog.lastTargetPosition = _positioningAxisRef^.Position)
                THEN // New increment
                    tempIncrementAbs := increment;
                    IF (jogForward AND increment < 0.0) OR (jogBackward AND increment > 0.0) THEN
                        tempIncrementAbs := 0.0 - tempIncrementAbs;
                    END_IF;
                    jog.lastTargetPosition := _positioningAxisRef^.Position + tempIncrementAbs;
                ELSE // Continue increment
                    tempIncrementAbs := jog.lastTargetPosition - _positioningAxisRef^.Position;
                END_IF;

                jog.lastIncrementCompleted := FALSE;
                jog.lastMoveDirectionForward := jogForward;
                jog.moveCmd := this.MoveRelative(
                    distance := tempIncrementAbs,
                    velocity := velocity,
                    acceleration := acceleration,
                    deceleration := deceleration,
                    jerk := jerk
                );
            END_IF;

            IF jog.moveCmd <> NULL THEN // increment jogging is active
                IF tempStopJogging THEN
                    jog.haltCmd := this.Halt(deceleration, jerk);
                END_IF;
                busy := jog.moveCmd.Busy();
                IF NOT busy THEN
                    IF jog.haltCmd = NULL THEN
                        commandAborted := jog.moveCmd.Aborted();
                        error := jog.moveCmd.Error();
                        errorID := jog.moveCmd.ErrorID();
                    END_IF;
                    jog.lastIncrementCompleted := jog.moveCmd.Done();
                    jog.moveCmd := NULL;
                END_IF;
            END_IF;

            IF jog.haltCmd <> NULL THEN
                busy := jog.haltCmd.Busy();
                IF NOT busy THEN
                    jog.haltCmd := NULL; // Stop done!
                END_IF;
            END_IF;

            IF jog.invalidJogDirectionError THEN
                inVelocity := FALSE;
                busy := FALSE;
                commandAborted := FALSE;
                error := TRUE;
                errorID := ERR_INVALID_JOG_DIR;
            END_IF;
        END_METHOD

        /// With the method SetTorqueLimit, you activate and assign parameters for force/torque limiting and fixed stop detection.
        /// The functions can be activated and deactivated by method ResetTorqueLimit, before and during a motion job.
        /// Returns the error ID of the operation (refer to the list of error IDs in manual from Siemens.S7.MotionControl library).
        METHOD PUBLIC SetTorqueLimit : Word
            VAR_INPUT
                /// Mode of the torque limiting operation.
                mode : TorqueLimitingMode := TorqueLimitingMode#TORQUE_LIMITING;
                /// With rotary motor: Additive setpoint torque 
                /// With linear motor: Additive setpoint force 
                /// Permissible values are -1.0E12 to 1.0E12
                limit : LREAL := LREAL#-1.0;
            END_VAR

            VAR_OUTPUT
                /// The drive operates at least at the threshold value (default 90%) of the torque limit/force limitation.
                inLimitation : BOOL;
                /// The drive is kept at the fixed stop position for Mode: TorqueLimitingMode#FIXED_STOP_DETECTION.
                inClamping : BOOL;
            END_VAR

            _torqueLimiting(
                Axis   := _speedAxisRef^,
                Enable := TRUE,
                Limit  := limit,
                Mode   := mode,
                InClamping   => inClamping,
                InLimitation => inLimitation,
                ErrorID => SetTorqueLimit
            );
        END_METHOD

        /// With the method HomeAbsEncoder, you home the position of a technology object with an absolute encoder on a mechanical reference mark.
        /// The actual position value in the technology object is assigned to a homing mark at the same time. This homing mark represents a known mechanical position.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD PUBLIC HomeAbsEncoder : IHomeCommand
            VAR_INPUT
                /// The specified value is used according to the selected Mode.
                position : LREAL;
                /// The mode of homing operation. 
                mode : HomingModeAbsEncoder := HomingModeAbsEncoder#ADJUSTMENT_SENSOR_ABSOLUTE;
                /// Torque limit for Mode: ACTIVE_ON_FIXED_STOP, ACTIVE_ON_FIXED_STOP_MOVE_OUT_OF_CLAMPING, ACTIVE_ON_FIXED_STOP_MOVE_TO_TARGET_POSITION
                /// Value < 0.0 is not permitted
                fixedStopTorqueLimit : LREAL := LREAL#0.0;
                /// Target position for Mode: ACTIVE_ON_FIXED_STOP_MOVE_TO_TARGET_POSITION
                fixedStopTargetPosition : LREAL := LREAL#0.0;
            END_VAR

            IF
                mode = HomingModeAbsEncoder#ACTIVE_ON_FIXED_STOP OR
                mode = HomingModeAbsEncoder#ACTIVE_ON_FIXED_STOP_MOVE_OUT_OF_CLAMPING OR
                mode = HomingModeAbsEncoder#ACTIVE_ON_FIXED_STOP_MOVE_TO_TARGET_POSITION
            THEN
                HomeAbsEncoder := homeOnFixedStopCmd.Start(posAxis := this, homingPos := position, encoderType := EncoderType#Absolute, moveMode := mode, torqueLmt := fixedStopTorqueLimit, targetPos := fixedStopTargetPosition);
            ELSE
                HomeAbsEncoder := homeCmd.Start(axisRef := _axisRef, position := position, mode := mode);
            END_IF;
        END_METHOD

        /// With the method HomeIncEncoder, you home the position of a technology object with an incremental encoder on a mechanical reference mark.
        /// The actual position value in the technology object is assigned to a homing mark at the same time. This homing mark represents a known mechanical position.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD PUBLIC HomeIncEncoder : IHomeCommand
            VAR_INPUT
                /// The specified value is used according to the selected Mode.
                position : LREAL;
                /// The mode of homing operation.
                mode : HomingModeIncEncoder := HomingModeIncEncoder#PASSIVE_WITH_POSITION_PARAMETER;
                /// Torque limit for Mode: ACTIVE_ON_FIXED_STOP, ACTIVE_ON_FIXED_STOP_MOVE_OUT_OF_CLAMPING, ACTIVE_ON_FIXED_STOP_MOVE_TO_TARGET_POSITION
                /// Value < 0.0 is not permitted
                fixedStopTorqueLimit : LREAL := LREAL#0.0;
                /// Target position for Mode: ACTIVE_ON_FIXED_STOP_MOVE_TO_TARGET_POSITION
                fixedStopTargetPosition : LREAL := LREAL#0.0;
            END_VAR

            IF
                mode = HomingModeIncEncoder#ACTIVE_ON_FIXED_STOP OR
                mode = HomingModeIncEncoder#ACTIVE_ON_FIXED_STOP_MOVE_OUT_OF_CLAMPING OR
                mode = HomingModeIncEncoder#ACTIVE_ON_FIXED_STOP_MOVE_TO_TARGET_POSITION
            THEN
                HomeIncEncoder := homeOnFixedStopCmd.Start(posAxis := this, homingPos := position, encoderType := EncoderType#Incremental, moveMode := mode, torqueLmt := fixedStopTorqueLimit, targetPos := fixedStopTargetPosition);
            ELSE
                HomeIncEncoder := homeCmd.Start(axisRef := _axisRef, position := position, mode := mode);
            END_IF;
        END_METHOD

        /// With the method HomeDirect, you home the position of a technology object on a mechanical reference mark.
        /// The actual position value in the technology object is assigned to a homing mark at the same time. This homing mark represents a known mechanical position.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD PUBLIC HomeDirect : IHomeCommand
            VAR_INPUT
                /// The specified value is used according to the selected Mode.
                position : LREAL;
                /// The mode of homing operation.
                mode : HomingModeDirect := HomingModeDirect#ACTUAL_POSITION_ABSOLUTE;
            END_VAR

            HomeDirect := homeCmd.Start(axisRef := _axisRef, position := position, mode := mode);
        END_METHOD

        /// With the method AbortPassiveHoming, you can abort an active job for passive homing.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD PUBLIC AbortPassiveHoming : ICommand
            AbortPassiveHoming := homeCmd.Start(axisRef := _axisRef, mode := INT#9);
        END_METHOD

        /// With the method MoveAbsolute, you can move an axis to an absolute position.
        /// You define the dynamic behavior of the motion with parameters Velocity, Acceleration, Deceleration and Jerk.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD PUBLIC MoveAbsolute : IMoveCommand
            VAR_INPUT
                /// Absolute target position.
                position : LREAL;
                /// Velocity setpoint for the motion.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Value 0.0 is not permitted
                velocity : LREAL := LREAL#-1.0;
                /// Acceleration setpoint for the motion.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Value 0.0 is not permitted
                acceleration : LREAL := LREAL#-1.0;
                /// Deceleration setpoint for the motion.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Value 0.0 is not permitted  
                deceleration : LREAL := LREAL#-1.0;
                /// Jerk setpoint for the motion.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Trapezoid velocity profile is applied when = 0.0                    
                jerk : LREAL := LREAL#-1.0;
                /// Direction of the motion of the axis.
                /// This parameter is only evaluated when the technology object is configured as modulo axis.
                direction : DirectionModulo := DirectionModulo#POSITIVE;
                /// Mode of motion transition.
                bufferMode: MoveBufferMode := MoveBufferMode#ABORT_MOTION;
            END_VAR

            MoveAbsolute := moveAbsoluteCmd.Start(
                axisRef := _positioningAxisRef,
                position := position,
                velocity := velocity,
                acceleration := acceleration,
                deceleration := deceleration,
                jerk := jerk,
                direction := direction,
                bufferMode:=bufferMode
            );
        END_METHOD

        /// With the method MoveRelative, you move an axis relative to its position when execution of the job began.
        /// You define the dynamic behavior of the motion with parameters Velocity, Acceleration, Deceleration and Jerk.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD PUBLIC MoveRelative : IMoveCommand
            VAR_INPUT
                /// Distance to travel (negative or positive)
                distance : LREAL;
                /// Velocity setpoint for the motion.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Value 0.0 is not permitted
                velocity : LREAL := LREAL#-1.0;
                /// Acceleration setpoint for the motion.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Value 0.0 is not permitted
                acceleration : LREAL := LREAL#-1.0;
                /// Deceleration setpoint for the motion.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Value 0.0 is not permitted  
                deceleration : LREAL := LREAL#-1.0;
                /// Jerk setpoint for the motion.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Trapezoid velocity profile is applied when = 0.0                    
                jerk : LREAL := LREAL#-1.0;
                /// Mode of motion transition.
                bufferMode: MoveBufferMode := MoveBufferMode#ABORT_MOTION;
            END_VAR

            MoveRelative := moveRelativeCmd.Start(
                axisRef := _positioningAxisRef,
                distance := distance,
                velocity := velocity,
                acceleration := acceleration,
                deceleration := deceleration,
                jerk := jerk,
                bufferMode:=bufferMode
            );
        END_METHOD

        /// With the method MoveSuperimposed, you can start a relative positioning motion which is superimposed on a running basic motion.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD PUBLIC MoveSuperimposed : ICommand
            VAR_INPUT
                /// Additional distance for the overlapping positioning operation (negative or positive)
                distance : LREAL;
                /// Maximum velocity deviation compared to the active motion
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Value 0.0 is not permitted
                velocityDiff : LREAL := LREAL#-1.0;
                /// Acceleration setpoint for the motion.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Value 0.0 is not permitted
                acceleration : LREAL := LREAL#-1.0;
                /// Deceleration setpoint for the motion.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Value 0.0 is not permitted  
                deceleration : LREAL := LREAL#-1.0;
                /// Jerk setpoint for the motion.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Trapezoid velocity profile is applied when = 0.0  
                jerk : LREAL := LREAL#-1.0;
            END_VAR

            MoveSuperimposed := moveSuperimposedCmd.Start(
                axisRef := _positioningAxisRef,
                distance := distance,
                velocityDiff := velocityDiff,
                acceleration := acceleration,
                deceleration := deceleration,
                jerk := jerk
            );
        END_METHOD

        /// With the method HaltSuperimposed, you can to decelerate a superimposed motion operation on the axis to zero velocity.
        /// This instruction has no effect on the basic motion of the axis.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD PUBLIC HaltSuperimposed : ICommand
            VAR_INPUT
                /// Deceleration setpoint for the motion.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Value 0.0 is not permitted  
                deceleration : LREAL := LREAL#-1.0;
                /// Jerk setpoint for the motion.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Trapezoid velocity profile is applied when = 0.0  
                jerk : LREAL := LREAL#-1.0;
                /// FALSE = The current acceleration at the start of the job is reduced using the configured jerk. Afterwards, the deceleration builds up.
                /// TRUE = The acceleration is set to 0.0 at the start of the job, and the deceleration immediately builds up.
                abortAcceleration : BOOL;
            END_VAR

            HaltSuperimposed := haltSuperimposedCmd.Start(
                axisRef := _positioningAxisRef,
                deceleration := deceleration,
                jerk := jerk,
                abortAcceleration := abortAcceleration
            );
        END_METHOD
    END_CLASS
END_NAMESPACE
