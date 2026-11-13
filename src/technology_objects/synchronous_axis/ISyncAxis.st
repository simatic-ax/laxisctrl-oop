USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    INTERFACE ISyncAxis EXTENDS IPosAxis
        /// With method GetSynchronousAxisRef, you get the reference of the attached synchronous axis.
        METHOD GetSynchronousAxisRef : REF_TO TO_SynchronousAxis END_METHOD
        
        /// With the method GearInRelative, you start a gearing operation between a leading axis and a following axis.
        /// You can start synchronous operation when the leading axis is at a standstill or when it is in motion.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD GearInRelative : ICommand
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
        END_METHOD
    END_INTERFACE
END_NAMESPACE
