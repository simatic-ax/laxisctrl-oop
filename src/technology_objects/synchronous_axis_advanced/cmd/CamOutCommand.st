USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS INTERNAL FINAL CamOutCommand EXTENDS ExecuteCommand
        VAR
            _camOut : MC_CamOut;
            _followingAxisRef : REF_TO TO_SynchronousAxis;
        END_VAR

        {inline}
        METHOD INTERNAL Start : ICommand
            VAR_INPUT
                followingAxisRef : REF_TO TO_SynchronousAxis;
                followingPosition : LREAL;
                syncProfileReference : SyncOutProfile;
                leadingStopDistance : LREAL;
                deceleration : LREAL;
                jerk : LREAL;
                syncOutDirection : DirectionSyncOut;
            END_VAR

            _followingAxisRef := followingAxisRef;
            _camOut.SyncProfileReference := syncProfileReference;
            _camOut.SlavePosition := followingPosition;
            _camOut.MasterStopDistance := leadingStopDistance;
            _camOut.Deceleration := deceleration;
            _camOut.Jerk := jerk;
            _camOut.SyncOutDirection := syncOutDirection;

            this.ExecuteWithRisingEdge();
            Start := THIS;
        END_METHOD

        {inline}
        METHOD PROTECTED OVERRIDE SetExecute
            VAR_INPUT
                execute : BOOL;
            END_VAR

            _camOut.Execute := execute;
        END_METHOD

        {inline}
        METHOD OVERRIDE Execute
            _camOut(
                slave := _followingAxisRef^,
                Done => _done,
                CommandAborted => _aborted,
                ErrorID => _errorID,
                Error => _error
            );
        END_METHOD
    END_CLASS
END_NAMESPACE