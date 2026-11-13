USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS INTERNAL FINAL GearInCommand EXTENDS ExecuteCommand
        VAR
            _gearIn : MC_GearIn;
            _leadingAxisRef : REF_TO TO_Axis;
            _followingAxisRef : REF_TO TO_SynchronousAxis;
        END_VAR

        {inline}
        METHOD INTERNAL Start : ICommand
            VAR_INPUT
                leadingAxisRef : REF_TO TO_Axis;
                followingAxisRef : REF_TO TO_SynchronousAxis;
                ratioNumerator : DINT;
                ratioDenominator : DINT;
                acceleration : LREAL;
                deceleration : LREAL;
                jerk : LREAL;
            END_VAR

            _leadingAxisRef := leadingAxisRef;
            _followingAxisRef := followingAxisRef;
            _gearIn.ratioNumerator := ratioNumerator;
            _gearIn.ratioDenominator := ratioDenominator;
            _gearIn.acceleration := acceleration;
            _gearIn.deceleration := deceleration;
            _gearIn.jerk := jerk;

            this.ExecuteWithRisingEdge();
            Start := THIS;
        END_METHOD

        {inline}
        METHOD PROTECTED OVERRIDE SetExecute
            VAR_INPUT
                execute : BOOL;
            END_VAR

            _gearIn.Execute := execute;
        END_METHOD

        {inline}
        METHOD OVERRIDE Execute
            VAR_TEMP
                tempBusy : BOOL;
                tempInGear : BOOL;
            END_VAR

            _gearIn(
                master := _leadingAxisRef^,
                slave := _followingAxisRef^,
                Busy => tempBusy,
                CommandAborted => _aborted,
                InGear => tempInGear,
                ErrorID => _errorID,
                Error => _error
            );

            _done := tempInGear AND tempBusy;
        END_METHOD
    END_CLASS
END_NAMESPACE