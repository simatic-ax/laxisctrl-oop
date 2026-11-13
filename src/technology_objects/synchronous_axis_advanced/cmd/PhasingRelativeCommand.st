USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS INTERNAL FINAL PhasingRelativeCommand EXTENDS ExecuteCommand
        VAR
            _phasingRelative : MC_PhasingRelative;
            _leadingAxisRef : REF_TO TO_Axis;
            _followingAxisRef : REF_TO TO_SynchronousAxis;
        END_VAR

        {inline}
        METHOD INTERNAL Start : ICommand
            VAR_INPUT
                leadingAxisRef : REF_TO TO_Axis;
                followingAxisRef : REF_TO TO_SynchronousAxis;
                phaseShift : LREAL;
                velocity : LREAL;
                acceleration : LREAL;
                deceleration : LREAL;
                jerk : LREAL;
                profileReference : PhasingProfile;
                phasingDistance : LREAL;
                startPosition : LREAL;
                sirection : DirectionPhasingOffset;
            END_VAR

            _leadingAxisRef := leadingAxisRef;
            _followingAxisRef := followingAxisRef;
            _phasingRelative.PhaseShift := phaseShift;
            _phasingRelative.Velocity := velocity;
            _phasingRelative.Acceleration := acceleration;
            _phasingRelative.Deceleration := deceleration;
            _phasingRelative.Jerk := jerk;
            _phasingRelative.ProfileReference := profileReference;
            _phasingRelative.PhasingDistance := phasingDistance;
            _phasingRelative.StartPosition := startPosition;
            _phasingRelative.Direction := sirection;

            this.ExecuteWithRisingEdge();
            Start := THIS;
        END_METHOD

        {inline}
        METHOD PROTECTED OVERRIDE SetExecute
            VAR_INPUT
                execute : BOOL;
            END_VAR

            _phasingRelative.Execute := execute;
        END_METHOD

        {inline}
        METHOD OVERRIDE Execute
            _phasingRelative(master := _leadingAxisRef^,
                slave := _followingAxisRef^,
                Done => _done,
                CommandAborted => _aborted,
                ErrorID => _errorID,
                Error => _error
            );
        END_METHOD
    END_CLASS
END_NAMESPACE