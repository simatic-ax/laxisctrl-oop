USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS INTERNAL FINAL OffsetRelativeCommand EXTENDS ExecuteCommand
        VAR
            _offsetRelative : MC_OffsetRelative;
            _followingAxisRef : REF_TO TO_SynchronousAxis;
        END_VAR

        {inline}
        METHOD INTERNAL Start : ICommand
            VAR_INPUT
                followingAxisRef : REF_TO TO_SynchronousAxis;
                offset : LREAL;
                profileReference : OffsetProfile;
                offsetDistance : LREAL;
                startPosition : LREAL;
                direction : DirectionPhasingOffset;
            END_VAR

            _followingAxisRef := followingAxisRef;
            _offsetRelative.Offset := offset;
            _offsetRelative.ProfileReference := profileReference;
            _offsetRelative.StartPosition := startPosition;
            _offsetRelative.OffsetDistance := offsetDistance;
            _offsetRelative.Direction := direction;

            this.ExecuteWithRisingEdge();
            Start := THIS;
        END_METHOD

        {inline}
        METHOD PROTECTED OVERRIDE SetExecute
            VAR_INPUT
                execute : BOOL;
            END_VAR

            _offsetRelative.Execute := execute;
        END_METHOD

        {inline}
        METHOD OVERRIDE Execute
            _offsetRelative(
                slave := _followingAxisRef^,
                Done => _done,
                CommandAborted => _aborted,
                ErrorID => _errorID,
                Error => _error
            );
        END_METHOD
    END_CLASS
END_NAMESPACE