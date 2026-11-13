USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS INTERNAL FINAL HaltSuperimposedCommand EXTENDS ExecuteCommand
        VAR
            _haltSuperimposed : MC_HaltSuperimposed;
            _axisRef : REF_TO TO_PositioningAxis;
        END_VAR

        METHOD INTERNAL Start : ICommand
            VAR_INPUT
                axisRef : REF_TO TO_PositioningAxis;
                deceleration : LREAL;
                jerk : LREAL;
                abortAcceleration : BOOL;
            END_VAR

            _axisRef := axisRef;
            _haltSuperimposed.Deceleration := deceleration;
            _haltSuperimposed.Jerk := jerk;
            _haltSuperimposed.AbortAcceleration := abortAcceleration;

            this.ExecuteWithRisingEdge();
            Start := THIS;
        END_METHOD

        {inline}
        METHOD PROTECTED OVERRIDE SetExecute
            VAR_INPUT
                execute: BOOL;
            END_VAR

            _haltSuperimposed.Execute := execute;
        END_METHOD

        METHOD OVERRIDE Execute
            _haltSuperimposed(
                Axis := _axisRef^,
                Done => _done,
                CommandAborted => _aborted,
                Error => _error,
                ErrorID => _errorID
            );
        END_METHOD
    END_CLASS
END_NAMESPACE
