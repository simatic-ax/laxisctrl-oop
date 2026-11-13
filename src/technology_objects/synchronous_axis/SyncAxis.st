USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS PUBLIC SyncAxis EXTENDS PosAxis IMPLEMENTS ISyncAxis
        VAR PRIVATE
            gearInCmd : GearInCommand;
        END_VAR

        VAR PROTECTED
            _synchronousAxisRef : REF_TO TO_SynchronousAxis;
        END_VAR

        METHOD INTERNAL Attach : BOOL
            VAR_INPUT
                axis : REF_TO TO_SynchronousAxis;
            END_VAR

            _synchronousAxisRef := axis;
            SUPER.Attach(axis);
            Attach := this.IsAttached();
        END_METHOD

        /// Attaches the given technology object of type TO_SynchronousAxis to this specific instance.
        METHOD PUBLIC OVERRIDE Attach : BOOL
            VAR_IN_OUT
                axis :  TO_SynchronousAxis;
            END_VAR

            _resolvedType := TO_Type#SynchronousAxis;
            Attach := this.Attach(AsSynchronousAxisRef(axis));
        END_METHOD

        /// Attaches the given technology object of any type to this specific instance.
        METHOD PUBLIC OVERRIDE Attach : BOOL
            VAR_INPUT
                axisDB : DB_ANY;
            END_VAR

            _resolvedType := GetType(axisDB);
            Attach := this.Attach(AsSynchronousAxisRef(axisDB));
        END_METHOD

        /// Detaches the current assigned technology object from this instance.
        METHOD PUBLIC OVERRIDE Detach : BOOL
            _synchronousAxisRef := NULL;
            SUPER.Detach();
            Detach := this.IsAttached();
        END_METHOD

        /// IsAttached returns the state of the attached technology object for this instance.
        METHOD PUBLIC OVERRIDE IsAttached : BOOL
            IsAttached := (_synchronousAxisRef <> NULL);
        END_METHOD

        /// With method GetSynchronousAxisRef, you get the reference of the attached synchronous axis.
        METHOD PUBLIC GetSynchronousAxisRef : REF_TO TO_SynchronousAxis
            GetSynchronousAxisRef := _synchronousAxisRef;
        END_METHOD

        /// With the method GearInRelative, you start a gearing operation between a leading axis and a following axis.
        /// You can start synchronous operation when the leading axis is at a standstill or when it is in motion.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD PUBLIC GearInRelative : ICommand
            VAR_INPUT
                /// Leading axis interface object.
                leadingAxis : ILeadingAxis;
                /// Gear ratio numerator.
                /// Permissible values are -2147483648 to 2147483647
                /// Value 0 is not permitted
                ratioNumerator : DINT := DINT#1;
                /// Gear ratio denominator.
                /// Permissible values are 1 to 2147483647
                ratioDenominator : DINT := DINT#1;
                /// Acceleration setpoint for the motion.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Value 0.0 is not permitted
                acceleration : LREAL := LREAL#-1.0;
                /// Deceleration setpoint for the motion.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Value 0.0 is not permitted  
                deceleration : LREAL := LREAL#-1.0;
                /// Jerk setpoint for the motion.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Trapezoid velocity profile is applied when = 0.0  
                jerk : LREAL := LREAL#-1.0;
            END_VAR

            GearInRelative := gearInCmd.Start(
                leadingAxis.GetAxisRef(),
                _synchronousAxisRef,
                ratioNumerator,
                ratioDenominator,
                acceleration,
                deceleration,
                jerk
            );
        END_METHOD
    END_CLASS
END_NAMESPACE
