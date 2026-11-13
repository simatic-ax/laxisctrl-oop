USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS INTERNAL FINAL OffsetAbsoluteCommand EXTENDS ExecuteCommand
        VAR
            _offsetAbsolute : MC_OffsetAbsolute;
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
            _offsetAbsolute.Offset := offset;
            _offsetAbsolute.ProfileReference := profileReference;
            _offsetAbsolute.StartPosition := startPosition;
            _offsetAbsolute.OffsetDistance := offsetDistance;
            _offsetAbsolute.Direction := direction;

            this.ExecuteWithRisingEdge();
            Start := THIS;
        END_METHOD

        {inline}
        METHOD PROTECTED OVERRIDE SetExecute
            VAR_INPUT
                execute : BOOL;
            END_VAR

            _offsetAbsolute.Execute := execute;
        END_METHOD

        {inline}
        METHOD OVERRIDE Execute
            _offsetAbsolute(
                slave := _followingAxisRef^,
                Done => _done,
                CommandAborted => _aborted,
                ErrorID => _errorID,
                Error => _error
            );
        END_METHOD
    END_CLASS
END_NAMESPACE