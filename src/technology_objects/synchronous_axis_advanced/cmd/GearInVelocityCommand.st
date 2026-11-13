USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS INTERNAL FINAL GearInVelocityCommand EXTENDS ExecuteCommand
        VAR
            _gearIn : MC_GearInVelocity;
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
                PositionControlled : BOOL;
            END_VAR

            _leadingAxisRef := leadingAxisRef;
            _followingAxisRef := followingAxisRef;
            _gearIn.ContinuousUpdate := FALSE;
            _gearIn.ratioNumerator := ratioNumerator;
            _gearIn.ratioDenominator := ratioDenominator;
            _gearIn.acceleration := acceleration;
            _gearIn.deceleration := deceleration;
            _gearIn.jerk := jerk;
            _gearIn.PositionControlled := PositionControlled;

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
                tempInSync : BOOL;
            END_VAR

            _gearIn(
                master := _leadingAxisRef^,
                slave := _followingAxisRef^,
                Busy => tempBusy,
                CommandAborted => _aborted,
                InSync => tempInSync,
                ErrorID => _errorID,
                Error => _error
            );

            _done := tempInSync AND tempBusy;
        END_METHOD
    END_CLASS
END_NAMESPACE