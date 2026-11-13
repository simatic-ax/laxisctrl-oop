USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    INTERFACE ISpeedAxis EXTENDS IAxis
        /// With method GetSpeedAxisRef, you get the reference of the attached speed axis.
        METHOD GetSpeedAxisRef : REF_TO TO_SpeedAxis END_METHOD

        /// With the method PowerOff, a technology object is disabled and, if necessary, a configured drive is switched off.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD PowerOff : ICommand
            VAR_INPUT
                /// The axis decelerates in accordance with the selected mode.
                mode : PowerOffMode := PowerOffMode#EMERGENCY_STOP;
            END_VAR
        END_METHOD

        /// With the method MoveVelocity, you move an axis at constant velocity/speed.
        /// You define the dynamic behavior of the motion with parameters Velocity, Acceleration, Deceleration and Jerk.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD MoveVelocity : ICommand
            VAR_INPUT
                /// Velocity setpoint for the motion.
                /// Value 0.0 is permitted
                velocity : LREAL := LREAL#100.0;
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
                /// Direction of the motion.
                direction : Direction := Direction#VELOCITY_SPECIFIED;
                /// FALSE = Move axis non position-controlled.
                /// TRUE = Move axis position-controlled.
                /// This parameter is ignored for TO_SpeedAxis.
                positionControlled : BOOL := FALSE;
            END_VAR
        END_METHOD

        /// With the method Halt, you brake an axis until it comes to a standstill.
        /// You define the dynamic behavior of the braking operation with parameters Jerk and Deceleration.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD Halt : ICommand
            VAR_INPUT
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
                /// Specifies the mode to halt an axis.
                mode: HaltMode := HaltMode#ALL_AXIS_MOTION;
                /// FALSE = The current acceleration at the start of the job is reduced using the configured jerk. Afterwards, the deceleration builds up.
                /// TRUE = The acceleration is set to 0.0 at the start of the job, and the deceleration immediately builds up.
                abortAcceleration : BOOL;
            END_VAR
        END_METHOD

        /// With the method Stop, you stop all movements of an axis and prevent new motion jobs for the technology object. The axis brakes to a standstill and remains switched on.
        /// You define the dynamic behavior of the braking operation with parameters Mode, Jerk and Deceleration.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD Stop : ICommand
            VAR_INPUT
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
                /// Specifies the mode to stop an axis.
                mode : StopMode := StopMode#EMERGENCY_STOP;
                /// FALSE = The current acceleration at the start of the job is reduced using the configured jerk. Afterwards, the deceleration builds up.
                /// TRUE = The acceleration is set to 0.0 at the start of the job, and the deceleration immediately builds up.
                abortAcceleration : BOOL;
            END_VAR
        END_METHOD

        /// With the method UnlockStop, you can prepare a stopped technology object for further motion operations.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD UnlockStop : ICommand END_METHOD

        /// With the method OpenBrake, you unconditionally open holding brake.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD OpenBrake : ICommand END_METHOD

        /// With the method CloseBrake, you unconditionally close holding brake.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD CloseBrake : ICommand END_METHOD

        /// With the method MoveJog, you move an axis at jog mode.
        /// You define the dynamic behavior of the motion with parameters Velocity, Acceleration, Deceleration and Jerk.
        METHOD MoveJog
            VAR_INPUT
                /// Jog in positive direction.
                /// Defaults to FALSE
                jogForward : BOOL;
                /// Jog in negative direction.
                /// Defaults to FALSE
                jogBackward : BOOL;
                /// Velocity setpoint for the motion.
                /// Absolute value is used when < 0.0
                velocity : LREAL := LREAL#100.0;
                /// Deceleration setpoint for the motion.
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

            VAR_OUTPUT
                /// The Velcoity setpoint has been reached.
                inVelocity : BOOL;
                /// The job is being processed.
                busy : BOOL;
                /// The job was aborted by another job during execution.
                commandAborted : BOOL;
                /// An error occurred while processing the job. The cause of the error can be found in the ErrorID parameter.
                error : BOOL;
                /// The error ID of the operation (refer to the list of error IDs in manual from Siemens.S7.MotionControl library).
                errorID : WORD;
            END_VAR
        END_METHOD

        /// With the method SetTorqueAdditive, you specify an additive torque for the drive to which the technology object is assigned. The torque data are transferred via the telegram 750.
        /// With a linear motor, use the operation to specify an additive force.
        /// The functions can be activated and deactivated by method ResetTorqueAdditive, before and during a motion job.
        /// Returns the error ID of the operation (refer to the list of error IDs in manual from Siemens.S7.MotionControl library).
        METHOD SetTorqueAdditive : WORD
            VAR_INPUT
                /// For rotary motor: Additive setpoint torque 
                /// For linear motor: Additive setpoint force
                /// Permissible values are -1.0E12 to 1.0E12
                value : LREAL;
            END_VAR
        END_METHOD

        /// With the method ResetTorqueAdditive, you reset an additive torque set by method SetTorqueAdditive.
        /// The additive torque transferred to the drive is set to zero.
        METHOD ResetTorqueAdditive END_METHOD

        /// With the method SetTorqueRange, you can specify an upper and lower torque or force limit to the drive assigned to the technology object. The torque data are transferred via the telegram 750.
        /// Returns the error ID of the operation (refer to the list of error IDs in manual from Siemens.S7.MotionControl library).
        METHOD SetTorqueRange : WORD
            VAR_INPUT
                /// With rotary motor: Upper torque limit
                /// With linear motor: Upper force limit 
                upperLimit : LREAL := LREAL#1000000000000.0;
                /// With rotary motor: Lower torque limit
                /// With linear motor: Lower force limit 
                lowerLimit : LREAL := LREAL#-1000000000000.0;
            END_VAR
        END_METHOD

        /// With the method ResetTorqueRange, you reset upper and lower torque limit set by method SetTorqueRange.
        METHOD ResetTorqueRange END_METHOD

        /// With the method SetTorqueLimit, you activate and assign parameters for force/torque limiting and fixed stop detection.
        /// The functions can be activated and deactivated by method ResetTorqueLimit, before and during a motion job.
        /// Returns the error ID of the operation (refer to the list of error IDs in manual from Siemens.S7.MotionControl library).
        METHOD SetTorqueLimit : WORD
            VAR_INPUT
                /// With rotary motor: Additive setpoint torque 
                /// With linear motor: Additive setpoint force 
                /// Permissible values are -1.0E12 to 1.0E12
                limit : LREAL := LREAL#-1.0;
            END_VAR

            VAR_OUTPUT
                /// The drive operates at least at the threshold value (default 90%) of the torque limit/force limitation.
                inLimitation : BOOL;
            END_VAR
        END_METHOD

        /// With the method ResetTorqueLimit, you deactivate force/torque limiting and fixed stop detection.
        METHOD ResetTorqueLimit END_METHOD

        /// With the method GetWarnings, you split the variable WarningWord of this axis into individual bits.
        METHOD GetWarnings : AxisWarnings  END_METHOD
        
        /// With the method GetErrors, you split the variable ErrorWord of this axis into individual bits.
        METHOD GetErrors : AxisErrors END_METHOD

        /// With the method GetStatus, you split the variables StatusWord and StatusWord2 of this axis into individual bits.
        METHOD GetStatus : AxisStatus END_METHOD
    END_INTERFACE
END_NAMESPACE
