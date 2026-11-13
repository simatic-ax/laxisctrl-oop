USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS INTERNAL FINAL ResetCommand EXTENDS ExecuteCommand IMPLEMENTS ICommand
        VAR
            _reset : MC_Reset;
            _objectRef : REF_TO TO_Object;
        END_VAR

        {inline}
        METHOD INTERNAL Start : ICommand
            VAR_INPUT
                objectRef : REF_TO TO_Object;
                restart : BOOL;
            END_VAR

            _objectRef := objectRef;
            _reset.Restart := restart;

            this.ExecuteWithRisingEdge();
            Start := THIS;
        END_METHOD

        {inline}
        METHOD PROTECTED OVERRIDE SetExecute
            VAR_INPUT
                execute: BOOL;
            END_VAR

            _reset.Execute := execute;
        END_METHOD

        METHOD PROTECTED OVERRIDE Execute
            _reset(
                Axis := _objectRef^,
                Done => _done,
                CommandAborted => _aborted,
                ErrorID => _errorID,
                Error => _error
            );
        END_METHOD
    END_CLASS
END_NAMESPACE
