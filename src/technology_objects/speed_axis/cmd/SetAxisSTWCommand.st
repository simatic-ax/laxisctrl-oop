USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS INTERNAL FINAL SetAxisSTWCommand EXTENDS ExecuteCommand
        VAR
            _setAxisSTW : MC_SetAxisSTW;
            _axisRef : REF_TO TO_SpeedAxis;
        END_VAR

        {inline}
        METHOD PROTECTED OVERRIDE SetExecute
            VAR_INPUT
                execute : BOOL;
            END_VAR

            _setAxisSTW.Execute := execute;
        END_METHOD

        {inline}
        METHOD INTERNAL Start : ICommand
            VAR_INPUT
                axisRef : REF_TO TO_SpeedAxis;
                stw1 : WORD; // control word 1
                stw1BitMask : WORD; // bit mask
            END_VAR

            // get reference to technology object
            _axisRef := axisRef;

            // set parameters
            _setAxisSTW.STW1 := stw1;
            _setAxisSTW.STW1BitMask := stw1BitMask;

            THIS.ExecuteWithRisingEdge();

            // return the command
            Start := THIS;
        END_METHOD

        METHOD PROTECTED OVERRIDE Execute
            _setAxisSTW(
                Axis := this._axisRef^,
                Done => _done,
                CommandAborted => _aborted,
                ErrorID => _errorID,
                Error => _error
            );
        END_METHOD
    END_CLASS
END_NAMESPACE