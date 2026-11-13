USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS INTERNAL FINAL MoveSuperimposedCommand EXTENDS ExecuteCommand
        VAR
            _moveSuperimposed : MC_MoveSuperimposed;
            _axisRef : REF_TO TO_PositioningAxis;
        END_VAR

        METHOD INTERNAL Start : ICommand
            VAR_INPUT
                axisRef : REF_TO TO_PositioningAxis;
                distance : LREAL;
                velocityDiff : LREAL;
                acceleration : LREAL;
                deceleration : LREAL;
                jerk : LREAL;
            END_VAR
            
            _axisRef := axisRef;
            _moveSuperimposed.Distance := distance;
            _moveSuperimposed.VelocityDiff := velocityDiff;
            _moveSuperimposed.Acceleration := acceleration;
            _moveSuperimposed.Deceleration := deceleration;
            _moveSuperimposed.Jerk := jerk;

            this.ExecuteWithRisingEdge();
            Start := THIS;
        END_METHOD

        {inline}
        METHOD PROTECTED OVERRIDE SetExecute
            VAR_INPUT
                execute : BOOL;
            END_VAR

            _moveSuperimposed.Execute := execute;
        END_METHOD

        METHOD OVERRIDE Execute
            _moveSuperimposed(
                Axis := _axisRef^,
                Done => _done,
                CommandAborted => _aborted,
                Error => _error,
                ErrorID => _errorID
            );
        END_METHOD
    END_CLASS
END_NAMESPACE
