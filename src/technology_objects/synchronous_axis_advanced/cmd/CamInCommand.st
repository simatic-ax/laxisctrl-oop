USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS INTERNAL FINAL CamInCommand EXTENDS ExecuteCommand IMPLEMENTS ICamInCommand
        VAR
            _camIn : MC_CamIn;
            _leadingAxisRef : REF_TO TO_Axis;
            _followingAxisRef : REF_TO TO_SynchronousAxis;
            _camRef : REF_TO TO_CamBase;
            _endOfProfile : BOOL;
        END_VAR

        {inline}
        METHOD INTERNAL Start : ICamInCommand
            VAR_INPUT
                leadingAxisRef : REF_TO TO_Axis;
                followingAxisRef : REF_TO TO_SynchronousAxis;
                camRef : REF_TO TO_CamBase;
                leadingOffset : LREAL;
                followingOffset : LREAL;
                leadingScaling : LREAL;
                followingScaling : LREAL;
                leadingSyncPosition : LREAL;
                syncProfileReference : CamInProfile;
                leadingStartDistance : LREAL;
                velocity : LREAL;
                acceleration : LREAL;
                deceleration : LREAL;
                jerk : LREAL;
                applicationMode : CamApplicationMode;
                syncDirection : DirectionModulo;
            END_VAR

            _leadingAxisRef := leadingAxisRef;
            _followingAxisRef := followingAxisRef;
            _camRef := camRef;
            _camIn.MasterOffset := leadingOffset;
            _camIn.SlaveOffset := followingOffset;
            _camIn.MasterScaling := leadingScaling;
            _camIn.SlaveScaling := followingScaling;
            _camIn.MasterSyncPosition := leadingSyncPosition;
            _camIn.SyncProfileReference := syncProfileReference;
            _camIn.MasterStartDistance := leadingStartDistance;
            _camIn.Velocity := velocity;
            _camIn.Acceleration := acceleration;
            _camIn.Deceleration := deceleration;
            _camIn.Jerk := jerk;
            _camIn.ApplicationMode := applicationMode;
            _camIn.SyncDirection := syncDirection;

            this.ExecuteWithRisingEdge();
            Start := THIS;
        END_METHOD

        {inline}
        METHOD PROTECTED OVERRIDE SetExecute
            VAR_INPUT
                execute : BOOL;
            END_VAR

            _camIn.Execute := execute;
        END_METHOD

        {inline}
        METHOD OVERRIDE Execute
            VAR_TEMP
                tempBusy : BOOL;
                tempInSync : BOOL;
            END_VAR

            _camIn(
                master := _leadingAxisRef^,
                slave := _followingAxisRef^,
                cam := _camRef^,
                Busy => tempBusy,
                InSync => tempInSync,
                CommandAborted => _aborted,
                ErrorID => _errorID,
                Error => _error,
                EndOfProfile => _endOfProfile
            );

            _done := tempInSync AND tempBusy;
        END_METHOD

        /// Indicates the end of the cam profile.
        METHOD PUBLIC EndOfProfile : BOOL
            this.ExecuteIfBusy();
            EndOfProfile := _endOfProfile;
        END_METHOD
    END_CLASS
END_NAMESPACE