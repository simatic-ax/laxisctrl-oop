USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS INTERNAL FINAL HomeCommand EXTENDS ExecuteCommand IMPLEMENTS IHomeCommand
        VAR
            _home : MC_HOME;
            _axisRef : REF_TO TO_Axis;
            _referenceMarkPosition : LREAL;
        END_VAR

        {inline}
        METHOD INTERNAL Start : IHomeCommand
            VAR_INPUT
                axisRef : REF_TO TO_Axis;
                position : LREAL;
                mode : INT;
            END_VAR

            _axisRef := axisRef;
            _home.Position := position;
            _home.Mode := mode;

            this.ExecuteWithRisingEdge();
            Start := THIS;
        END_METHOD

        {inline}
        METHOD PROTECTED OVERRIDE SetExecute
            VAR_INPUT
                execute : BOOL;
            END_VAR

            _home.Execute := execute;
        END_METHOD

        {inline}
        METHOD OVERRIDE Execute
            _home(
                axis := _axisRef^,
                ReferenceMarkPosition => _referenceMarkPosition,
                Done => _done,
                CommandAborted => _aborted,
                Error => _error,
                ErrorID => _errorID
            );
        END_METHOD

        METHOD PUBLIC ReferenceMarkPosition : LREAL
            this.ExecuteIfBusy();
            ReferenceMarkPosition := _referenceMarkPosition;
        END_METHOD
    END_CLASS
END_NAMESPACE