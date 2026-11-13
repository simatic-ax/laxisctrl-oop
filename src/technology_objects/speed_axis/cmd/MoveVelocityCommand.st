USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS INTERNAL FINAL MoveVelocityCommand EXTENDS ExecuteCommand
        VAR
            _moveVelocity : MC_MoveVelocity;
            _axisRef : REF_TO TO_SpeedAxis;
        END_VAR

        METHOD INTERNAL Start : ICommand
            VAR_INPUT
                axisRef : REF_TO TO_SpeedAxis;
                velocity : LREAL;
                acceleration : LREAL;
                deceleration : LREAL;
                jerk : LREAL;
                direction : Direction;
                positionControlled : BOOL;
            END_VAR

            _axisRef := axisRef;
            _moveVelocity.Velocity := velocity;
            _moveVelocity.Acceleration := acceleration;
            _moveVelocity.Deceleration := deceleration;
            _moveVelocity.Jerk := jerk;
            _moveVelocity.Direction := direction;
            _moveVelocity.PositionControlled := positionControlled;

            this.ExecuteWithRisingEdge();
            Start := THIS;
        END_METHOD

        {inline}
        METHOD PROTECTED OVERRIDE SetExecute
            VAR_INPUT
                execute : BOOL;
            END_VAR

            _moveVelocity.Execute := execute;
        END_METHOD

        METHOD OVERRIDE Execute
            VAR_TEMP
                tempBusy : BOOL;
                tempInVel : BOOL;
            END_VAR

            _moveVelocity(
                Axis := _axisRef^,
                InVelocity => tempInVel,
                Busy => tempBusy,
                CommandAborted => _aborted,
                Error => _error,
                ErrorID => _errorID
            );

            _done := tempInVel AND tempBusy;
        END_METHOD
    END_CLASS
END_NAMESPACE
