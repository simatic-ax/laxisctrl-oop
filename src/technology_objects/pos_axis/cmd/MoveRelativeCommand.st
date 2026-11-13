USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS INTERNAL MoveRelativeCommand EXTENDS ExecuteCommand implements IMoveCommand
        VAR
            _moveRelative : MC_MoveRelative;
            _axisRef : REF_TO TO_PositioningAxis;
            _active : BOOL;
        END_VAR

        METHOD INTERNAL Start : IMoveCommand
            VAR_INPUT
                axisRef : REF_TO TO_PositioningAxis;
                distance : LREAL;
                velocity : LREAL;
                acceleration : LREAL;
                deceleration : LREAL;
                jerk : LREAL;
                bufferMode: MoveBufferMode;
            END_VAR

            _axisRef := axisRef;
            _moveRelative.Distance := distance;
            _moveRelative.Velocity := velocity;
            _moveRelative.Acceleration := acceleration;
            _moveRelative.Deceleration := deceleration;
            _moveRelative.Jerk := jerk;
            _moveRelative.BufferMode := bufferMode;

            this.ExecuteWithRisingEdge();
            Start := THIS;
        END_METHOD

        {inline}
        METHOD PROTECTED OVERRIDE SetExecute
            VAR_INPUT
                execute : BOOL;
            END_VAR

            _moveRelative.Execute := execute;
        END_METHOD

        METHOD OVERRIDE Execute
            _moveRelative(
                Axis := _axisRef^,
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