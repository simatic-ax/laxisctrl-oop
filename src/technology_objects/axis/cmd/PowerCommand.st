USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS INTERNAL FINAL PowerCommand EXTENDS Command IMPLEMENTS ICommand
        VAR
            _power : MC_POWER;
            _axisRef : REF_TO TO_Axis;
            _enable : BOOL;
        END_VAR

        {inline}
        METHOD INTERNAL Start : ICommand
            VAR_INPUT
                axisRef : REF_TO TO_Axis;
                enable : BOOL;
                positionControlled : BOOL;
                stopMode : PowerOffMode;
            END_VAR

            IF positionControlled THEN
                _power.StartMode := DINT#1;
            ELSE
                _power.StartMode := DINT#0;
            END_IF;

            _axisRef := axisRef;
            _power.StopMode := stopMode;
            _enable := enable;

            this.Execute();
            Start := THIS;
        END_METHOD

        METHOD PROTECTED OVERRIDE Execute
            VAR_TEMP
                tempPowerStatus : BOOL;
                tempPowerBusy : BOOL;
            END_VAR

            _power(
                Axis := this._axisRef^,
                Enable := _enable,
                Status => tempPowerStatus,
                Busy => tempPowerBusy,
                ErrorID => _errorID,
                Error => _error
            );

            _done := (tempPowerStatus = _enable) AND (tempPowerBusy = _enable);
            //_aborted can be kept untouched:  An "MC_Power" job cannot be aborted by any other Motion Control job.
        END_METHOD
    END_CLASS
END_NAMESPACE
