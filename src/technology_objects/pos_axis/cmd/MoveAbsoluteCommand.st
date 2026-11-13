USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS INTERNAL MoveAbsoluteCommand EXTENDS ExecuteCommand implements IMoveCommand
        VAR
            _moveAbsolute : MC_MoveAbsolute;
            _axisRef : REF_TO TO_PositioningAxis;
            _active : BOOL;
        END_VAR

        METHOD INTERNAL Start : IMoveCommand
            VAR_INPUT
                axisRef : REF_TO TO_PositioningAxis;
                position : LREAL;
                velocity : LREAL;
                acceleration : LREAL;
                deceleration : LREAL;
                jerk : LREAL;
                direction : INT;
                bufferMode : MoveBufferMode;
            END_VAR

            _axisRef := axisRef;
            _moveAbsolute.Position := position;
            _moveAbsolute.Velocity := velocity;
            _moveAbsolute.Acceleration := acceleration;
            _moveAbsolute.Deceleration := deceleration;
            _moveAbsolute.Jerk := jerk;
            _moveAbsolute.Direction := direction;
            _moveAbsolute.BufferMode:=bufferMode;

            this.ExecuteWithRisingEdge();
            Start := THIS;
        END_METHOD

        {inline}
        METHOD PROTECTED OVERRIDE SetExecute
            VAR_INPUT
                execute : BOOL;
            END_VAR

            _moveAbsolute.Execute := execute;
        END_METHOD

        METHOD OVERRIDE Execute
            _moveAbsolute(Axis := _axisRef^,
                Done => _done,
                Active =>_active,
                CommandAborted => _aborted,
                Error => _error,
                ErrorID => _errorID
            );
        END_METHOD

        {inline}
        METHOD PUBLIC Active : BOOL
            this.ExecuteIfBusy();
            Active := _active;
        END_METHOD
    END_CLASS
END_NAMESPACE
