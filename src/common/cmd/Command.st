USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS INTERNAL ABSTRACT Command IMPLEMENTS ICommand
        VAR PROTECTED
            // _busy : BOOL;
            _done : BOOL;
            _aborted : BOOL;
            _error : BOOL;
            _errorID : WORD;
        END_VAR

        {inline}
        METHOD PUBLIC Busy : BOOL
            this.ExecuteIfBusy();
            Busy := this.IsBusy();
        END_METHOD

        {inline}
        METHOD PUBLIC Done : BOOL
            this.ExecuteIfBusy();
            Done := _done;
        END_METHOD

        {inline}
        METHOD PUBLIC Aborted : BOOL
            this.ExecuteIfBusy();
            Aborted := _aborted;
        END_METHOD

        {inline}
        METHOD PUBLIC ErrorID : WORD
            this.ExecuteIfBusy();
            ErrorID := _errorID;
        END_METHOD

        {inline}
        METHOD PUBLIC Error : BOOL
            this.ExecuteIfBusy();
            Error := _error;
        END_METHOD

        {inline}
        METHOD PROTECTED ABSTRACT Execute END_METHOD

        {inline}
        METHOD PROTECTED InitState
            _done := FALSE;
            _aborted := FALSE;
            _error := FALSE;
            _errorID := WORD#0;
        END_METHOD

        {inline}
        METHOD ExecuteIfBusy
            IF this.IsBusy() THEN
                this.Execute();
            END_IF;
        END_METHOD

        {inline}
        METHOD IsBusy : BOOL
            IsBusy := NOT (_done OR _error OR _aborted);
        END_METHOD
    END_CLASS
END_NAMESPACE
