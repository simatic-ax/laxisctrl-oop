USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS PUBLIC SpeedAxis EXTENDS Axis IMPLEMENTS ISpeedAxis
        VAR PRIVATE
            _haltCmd : HaltCommand;
            _stopCmd : StopCommand;
            _setAxisSTWCmd : SetAxisSTWCommand;

            _torqueAdditive : MC_TorqueAdditive;
            _torqueRange : MC_TorqueRange;
        END_VAR

        VAR CONSTANT
            STW1_OPENHOLDINGBRAKE_BIT : Word := WORD#2#0001_0000_0000_0000; // Bit 12 in STW1 controls open holding brake
        END_VAR

        VAR PROTECTED
            _speedAxisRef : REF_TO TO_SpeedAxis;
            _moveJog : MC_MoveJog;
            _torqueLimiting : MC_TorqueLimiting;
            _moveVelocityCmd : MoveVelocityCommand;
        END_VAR

        METHOD PROTECTED OVERRIDE MakeAxisAbstract ; END_METHOD
    
        METHOD PROTECTED OVERRIDE MakeObjectAbstract ; END_METHOD

        METHOD INTERNAL Attach : BOOL
            VAR_INPUT
                axis : REF_TO TO_SpeedAxis;
            END_VAR

            _speedAxisRef := axis;
            SUPER.Attach(axis);
            Attach := this.IsAttached();
        END_METHOD

        /// Attaches the given technology object of type TO_SpeedAxis to this specific instance.
        METHOD PUBLIC Attach : BOOL
            VAR_IN_OUT
                axis :  TO_SpeedAxis;
            END_VAR

            _resolvedType := TO_Type#SpeedAxis;
            Attach := this.Attach(AsSpeedAxisRef(axis));
        END_METHOD

        /// Attaches the given technology object of type TO_PositioningAxis to this specific instance.
        METHOD PUBLIC Attach : BOOL
            VAR_IN_OUT
                axis : TO_PositioningAxis;
            END_VAR

            _resolvedType := TO_Type#PositioningAxis;
            Attach := this.Attach(AsPositioningAxisRef(axis));
        END_METHOD

        /// Attaches the given technology object of type TO_SynchronousAxis to this specific instance.
        METHOD PUBLIC Attach : BOOL
            VAR_IN_OUT
                axis : TO_SynchronousAxis;
            END_VAR

            _resolvedType := TO_Type#SynchronousAxis;
            Attach := this.Attach(AsSynchronousAxisRef(axis));
        END_METHOD

        /// Attaches the given technology object of any type to this specific instance.
        METHOD PUBLIC Attach : BOOL
            VAR_INPUT
                axisDB : DB_ANY;
            END_VAR

            _resolvedType := GetType(axisDB);
            Attach := this.Attach(AsSpeedAxisRef(axisDB));
        END_METHOD

        /// Detaches the current assigned technology object from this instance.
        METHOD PUBLIC Detach : BOOL
            _speedAxisRef := NULL;
            SUPER.Detach();
            Detach := this.IsAttached();
        END_METHOD

        /// IsAttached returns the state of the attached technology object for this instance.
        METHOD PUBLIC IsAttached : BOOL
            IsAttached := (_speedAxisRef <> NULL);
        END_METHOD

        /// With method GetSpeedAxisRef, you get the reference of the attached speed axis.
        METHOD PUBLIC GetSpeedAxisRef : REF_TO TO_SpeedAxis
            GetSpeedAxisRef := _speedAxisRef;
        END_METHOD

        /// With the method PowerOff, a technology object is disabled and, if necessary, a configured drive is switched off.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD PUBLIC PowerOff : ICommand
            VAR_INPUT
                /// The axis decelerates in accordance with the selected mode.
                mode : PowerOffMode;
            END_VAR

            PowerOff := _powerCmd.Start(axisRef := _axisRef, enable := FALSE, positionControlled := TRUE, stopMode := mode);
        END_METHOD

        /// With the method Halt, you brake an axis until it comes to a standstill.
        /// You define the dynamic behavior of the braking operation with parameters Jerk and Deceleration.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD PUBLIC Halt : ICommand
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

            Halt := _haltCmd.Start(
                axisRef := _speedAxisRef,
                deceleration := deceleration,
                jerk := jerk,
                abortAcceleration := abortAcceleration,
                mode := mode
            );
        END_METHOD

        /// With the method Stop, you stop all movements of an axis and prevent new motion jobs for the technology object. The axis brakes to a standstill and remains switched on.
        /// You define the dynamic behavior of the braking operation with parameters Mode, Jerk and Deceleration.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD PUBLIC Stop : ICommand
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

            Stop := _stopCmd.Start(
                axisRef := _speedAxisRef,
                mode := mode,
                deceleration := deceleration,
                jerk := jerk,
                abortAcceleration := abortAcceleration
            );
        END_METHOD

        /// With the method UnlockStop, you can prepare a stopped technology object for further motion operations.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD PUBLIC UnlockStop : ICommand
            _stopCmd.Cancel();
            UnlockStop := _stopCmd;
        END_METHOD

        /// With the method MoveVelocity, you move an axis at constant velocity/speed.
        /// You define the dynamic behavior of the motion with parameters Velocity, Acceleration, Deceleration and Jerk.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD PUBLIC MoveVelocity : ICommand
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

            MoveVelocity := _moveVelocityCmd.Start(
                axisRef := _speedAxisRef,
                velocity := velocity,
                acceleration := acceleration,
                deceleration := deceleration,
                jerk := jerk,
                direction := direction,
                positionControlled := FALSE
            );
        END_METHOD

        /// With the method OpenBrake, you unconditionally open holding brake.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD PUBLIC OpenBrake : ICommand
            OpenBrake := _setAxisSTWCmd.Start(axisRef := _speedAxisRef, stw1 := STW1_OPENHOLDINGBRAKE_BIT, stw1BitMask := STW1_OPENHOLDINGBRAKE_BIT);
        END_METHOD

        /// With the method CloseBrake, you unconditionally close holding brake.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD PUBLIC CloseBrake : ICommand
            CloseBrake := _setAxisSTWCmd.Start(axisRef := _speedAxisRef, stw1 := WORD#2#0000_0000_0000_0000, stw1BitMask := STW1_OPENHOLDINGBRAKE_BIT);
        END_METHOD

        METHOD PUBLIC MoveJog
            VAR_INPUT
                jogForward : BOOL;
                jogBackward : BOOL;
                velocity : LREAL;
                acceleration : LREAL;
                deceleration : LREAL;
                jerk : LREAL;
            END_VAR

            VAR_OUTPUT
                inVelocity : BOOL;
                busy : BOOL;
                commandAborted : BOOL;
                error : BOOL;
                errorID : Word;
            END_VAR

            _moveJog(
                Axis := _speedAxisRef^,
                JogForward := jogForward,
                JogBackward := jogBackward,
                Velocity := velocity,
                Acceleration := acceleration,
                Deceleration := deceleration,
                Jerk := jerk,
                InVelocity => inVelocity,
                Busy => busy,
                CommandAborted => commandAborted,
                Error => error,
                ErrorID => errorID
            );
        END_METHOD

        /// With the method SetTorqueAdditive, you specify an additive torque for the drive to which the technology object is assigned. The torque data are transferred via the telegram 750.
        /// With a linear motor, use the operation to specify an additive force.
        /// The functions can be activated and deactivated by method ResetTorqueAdditive, before and during a motion job.
        /// Returns the error ID of the operation (refer to the list of error IDs in manual from Siemens.S7.MotionControl library).
        METHOD PUBLIC SetTorqueAdditive : Word
            VAR_INPUT
                /// For rotary motor: Additive setpoint torque 
                /// For linear motor: Additive setpoint force
                /// Permissible values are -1.0E12 to 1.0E12
                value : LREAL;
            END_VAR

            _torqueAdditive(
                Axis := _speedAxisRef^,
                Enable := TRUE,
                Value := value,
                ErrorID => SetTorqueAdditive
            );
        END_METHOD

        /// With the method ResetTorqueAdditive, you reset an additive torque set by method SetTorqueAdditive.
        /// The additive torque transferred to the drive is set to zero.
        METHOD PUBLIC ResetTorqueAdditive
            _torqueAdditive(Axis := _speedAxisRef^, Enable := FALSE);
        END_METHOD

        /// With the method SetTorqueRange, you can specify an upper and lower torque or force limit to the drive assigned to the technology object. The torque data are transferred via the telegram 750.
        /// Returns the error ID of the operation (refer to the list of error IDs in manual from Siemens.S7.MotionControl library).
        METHOD PUBLIC SetTorqueRange : Word
            VAR_INPUT
                /// With rotary motor: Upper torque limit
                /// With linear motor: Upper force limit 
                upperLimit : LREAL := LREAL#1000000000000.0;
                /// With rotary motor: Lower torque limit
                /// With linear motor: Lower force limit 
                lowerLimit : LREAL := LREAL#-1000000000000.0;
            END_VAR
            
            _torqueRange(
                Axis := _speedAxisRef^,
                Enable := TRUE,
                UpperLimit := upperLimit,
                LowerLimit := lowerLimit,
                ErrorID => SetTorqueRange
            );
        END_METHOD

        /// With the method ResetTorqueRange, you reset upper and lower torque limit set by method SetTorqueRange.
        METHOD PUBLIC ResetTorqueRange
            _torqueRange(Axis := _speedAxisRef^, Enable := FALSE);
        END_METHOD

        /// With the method SetTorqueLimit, you activate and assign parameters for force/torque limiting and fixed stop detection.
        /// The functions can be activated and deactivated by method ResetTorqueLimit, before and during a motion job.
        /// Returns the error ID of the operation (refer to the list of error IDs in manual from Siemens.S7.MotionControl library).
        METHOD PUBLIC SetTorqueLimit : Word
            VAR_INPUT
                /// With rotary motor: Additive setpoint torque 
                /// With linear motor: Additive setpoint force 
                /// Permissible values are -1.0E12 to 1.0E12
                limit : LREAL;
            END_VAR

            VAR_OUTPUT
                /// The drive operates at least at the threshold value (default 90%) of the torque limit/force limitation.
                inLimitation : BOOL;
            END_VAR

            _torqueLimiting(
                Axis   := _speedAxisRef^,
                Enable := TRUE,
                Limit  := limit,
                Mode   := DINT#0, // for SpeedAxis
                InLimitation => inLimitation,
                ErrorID => SetTorqueLimit
            );
        END_METHOD

        /// With the method ResetTorqueLimit, you deactivate force/torque limiting and fixed stop detection.
        METHOD PUBLIC ResetTorqueLimit
            _torqueLimiting(Axis := _speedAxisRef^, Enable := FALSE);
        END_METHOD

        METHOD INTERNAL SetSTW : ICommand
            VAR_INPUT
                stw1 : WORD;
                stw1BitMask : WORD;
            END_VAR

            SetSTW := _setAxisSTWCmd.Start(axisRef := _speedAxisRef, stw1 := stw1, stw1BitMask := stw1BitMask);   // Bit 12 in STW
        END_METHOD

        {inline}
        /// With the method GetWarnings, you split the variable WarningWord of this axis into individual bits.
        METHOD PUBLIC FINAL GetWarnings : AxisWarnings
            GetWarnings := GetAxisWarnings(_speedAxisRef^);
        END_METHOD

        {inline}
        /// With the method GetErrors, you split the variable ErrorWord of this axis into individual bits.
        METHOD PUBLIC FINAL GetErrors : AxisErrors
            GetErrors := GetAxisErrors(_speedAxisRef^);
        END_METHOD

        {inline}
        /// With the method GetStatus, you split the variables StatusWord and StatusWord2 of this axis into individual bits.
        METHOD PUBLIC FINAL GetStatus : AxisStatus
            GetStatus := GetAxisStatus(_speedAxisRef^);
        END_METHOD
    END_CLASS
END_NAMESPACE
