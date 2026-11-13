USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS INTERNAL HaltCommand EXTENDS ExecuteCommand
        VAR
            _halt : MC_Halt;
            _axisRef : REF_TO TO_SpeedAxis;
        END_VAR

        METHOD INTERNAL Start : ICommand
            VAR_INPUT
                axisRef : REF_TO TO_SpeedAxis;
                deceleration : LREAL;
                jerk : LREAL;
                abortAcceleration : BOOL;
                mode : HaltMode;
            END_VAR

            _axisRef := axisRef;
            _halt.Deceleration := deceleration;
            _halt.Jerk := jerk;
            _halt.AbortAcceleration := abortAcceleration;
            _halt.Mode := mode;

            this.ExecuteWithRisingEdge();
            Start := THIS;
        END_METHOD

        {inline}
        METHOD PROTECTED OVERRIDE SetExecute
            VAR_INPUT
                execute : BOOL;
            END_VAR

            _halt.Execute := execute;
        END_METHOD

        METHOD OVERRIDE Execute
            _halt(
                Axis := _axisRef^,
                Done => _done,
                CommandAborted => _aborted,
                Error => _error,
                ErrorID => _errorID
            );
        END_METHOD
    END_CLASS
END_NAMESPACE
