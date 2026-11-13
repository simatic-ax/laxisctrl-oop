USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS INTERNAL FINAL PhasingAbsoluteCommand EXTENDS ExecuteCommand
        VAR
            _phasingAbsolute : MC_PhasingAbsolute;
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
                direction : DirectionPhasingOffset;
            END_VAR

            _leadingAxisRef := leadingAxisRef;
            _followingAxisRef := followingAxisRef;
            _phasingAbsolute.PhaseShift := phaseShift;
            _phasingAbsolute.Velocity := velocity;
            _phasingAbsolute.Acceleration := acceleration;
            _phasingAbsolute.Deceleration := deceleration;
            _phasingAbsolute.Jerk := jerk;
            _phasingAbsolute.ProfileReference := profileReference;
            _phasingAbsolute.PhasingDistance := phasingDistance;
            _phasingAbsolute.StartPosition := startPosition;
            _phasingAbsolute.Direction := direction;

            this.ExecuteWithRisingEdge();
            Start := THIS;
        END_METHOD

        {inline}
        METHOD PROTECTED OVERRIDE SetExecute
            VAR_INPUT
                execute : BOOL;
            END_VAR

            _phasingAbsolute.Execute := execute;
        END_METHOD

        {inline}
        METHOD OVERRIDE Execute
            _phasingAbsolute(master := _leadingAxisRef^,
                slave := _followingAxisRef^,
                Done => _done,
                CommandAborted => _aborted,
                ErrorID => _errorID,
                Error => _error
            );
        END_METHOD
    END_CLASS
END_NAMESPACE