USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS INTERNAL InterpolateCamCommand EXTENDS ExecuteCommand
        VAR
            _interpolateCam : MC_InterpolateCam;
            _camRef : REF_TO TO_CamBase;
        END_VAR

        {inline}
        METHOD INTERNAL Start : ICommand
            VAR_INPUT
                camRef : REF_TO TO_CamBase;
            END_VAR

            _camRef := camRef;

            this.ExecuteWithRisingEdge();
            Start := THIS;
        END_METHOD

        {inline}
        METHOD PROTECTED OVERRIDE SetExecute
            VAR_INPUT
                execute : BOOL;
            END_VAR

            _interpolateCam.Execute := execute;
        END_METHOD

        {inline}
        METHOD OVERRIDE Execute
            _interpolateCam(
                Cam := _camRef^,
                Done => _done,
                Error => _error,
                ErrorID => _errorID
            );
        END_METHOD
    END_CLASS
END_NAMESPACE
