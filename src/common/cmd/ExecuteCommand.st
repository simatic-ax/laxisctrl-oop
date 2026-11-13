NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS INTERNAL ABSTRACT ExecuteCommand EXTENDS Command
        {inline}
        METHOD PROTECTED ABSTRACT SetExecute
            VAR_INPUT
                execute: BOOL;
            END_VAR
        END_METHOD

        {inline}
        METHOD PROTECTED ExecuteWithRisingEdge
           this.SetExecute(FALSE);
           this.Execute();
           this.SetExecute(TRUE);
           this.Execute();
        END_METHOD
    END_CLASS
END_NAMESPACE
