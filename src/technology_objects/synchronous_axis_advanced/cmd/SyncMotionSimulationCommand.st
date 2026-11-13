USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS INTERNAL FINAL SyncMotionSimulationCommand EXTENDS Command
        VAR
            _syncMotionSimulation : MC_SynchronizedMotionSimulation;
            _followingAxisRef : REF_TO TO_SynchronousAxis;
            _enable : BOOL;
        END_VAR

        {inline}
        METHOD INTERNAL Start : ICommand
            VAR_INPUT
                followingAxisRef : REF_TO TO_SynchronousAxis;
                enable : BOOL;
            END_VAR

            _followingAxisRef := followingAxisRef;
            _enable := enable;

            this.Execute();
            Start := THIS;
        END_METHOD

        METHOD PROTECTED OVERRIDE Execute
            VAR_TEMP
                tempInSimulation : BOOL;
                tempBusy : BOOL;
            END_VAR

            _syncMotionSimulation(
                Slave := this._followingAxisRef^,
                Enable := _enable,
                InSimulation => tempInSimulation,
                Busy => tempBusy,
                ErrorID => _errorID,
                Error => _error
            );

            _done := (tempInSimulation = _enable) AND (tempBusy = _enable);
        END_METHOD
    END_CLASS
END_NAMESPACE
