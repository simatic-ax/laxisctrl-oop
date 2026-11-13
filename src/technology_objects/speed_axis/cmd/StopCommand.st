USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS INTERNAL FINAL StopCommand EXTENDS Command
        VAR
            _stop : MC_Stop;
            _axisRef : REF_TO TO_SpeedAxis;
        END_VAR

        METHOD INTERNAL Start : ICommand
            VAR_INPUT
                axisRef : REF_TO TO_SpeedAxis;
                mode : StopMode;
                deceleration : LREAL;
                jerk : LREAL;
                abortAcceleration : BOOL;
            END_VAR

            _axisRef := axisRef;
            _stop.Mode := mode;
            _stop.Deceleration := deceleration;
            _stop.Jerk := jerk;
            _stop.AbortAcceleration := abortAcceleration;
            _stop.Execute := TRUE;
            
            THIS.Execute();
            Start := THIS;
        END_METHOD

        METHOD PUBLIC Cancel
            _stop.Execute := FALSE;
            THIS.Execute();
        END_METHOD

        METHOD OVERRIDE Execute
            VAR_TEMP
                tempDone : BOOL;
                tempBusy : BOOL;
            END_VAR

            _stop(
                Axis := _axisRef^,
                Done => tempDone,
                Busy => tempBusy,
                CommandAborted => _aborted,
                Error => _error,
                ErrorID => _errorID
            );

            _done := tempDone = _stop.Execute;
        END_METHOD
    END_CLASS
END_NAMESPACE
