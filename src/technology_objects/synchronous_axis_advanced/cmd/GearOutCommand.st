USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS INTERNAL FINAL GearOutCommand EXTENDS ExecuteCommand
        VAR
            _gearOut : MC_GearOut;
            _followingAxisRef : REF_TO TO_SynchronousAxis;
        END_VAR

        {inline}
        METHOD INTERNAL Start : ICommand
            VAR_INPUT
                followingAxisRef : REF_TO TO_SynchronousAxis;
                syncProfileReference : SyncOutProfile;
                followingPosition : LREAL;
                leadingStopDistance : LREAL;
                deceleration : LREAL;
                jerk : LREAL;
                syncOutDirection : DirectionSyncOut;
            END_VAR

            _followingAxisRef := followingAxisRef;
            _gearOut.SyncProfileReference := syncProfileReference;
            _gearOut.SlavePosition := followingPosition;
            _gearOut.MasterStopDistance := leadingStopDistance;
            _gearOut.Deceleration := deceleration;
            _gearOut.Jerk := jerk;
            _gearOut.SyncOutDirection := syncOutDirection;

            this.ExecuteWithRisingEdge();
            Start := THIS;
        END_METHOD

        {inline}
        METHOD PROTECTED OVERRIDE SetExecute
            VAR_INPUT
                execute : BOOL;
            END_VAR

            _gearOut.Execute := execute;
        END_METHOD

        {inline}
        METHOD OVERRIDE Execute
            _gearOut(
                slave := _followingAxisRef^,
                Done => _done,
                CommandAborted => _aborted,
                ErrorID => _errorID,
                Error => _error
            );
        END_METHOD
    END_CLASS
END_NAMESPACE