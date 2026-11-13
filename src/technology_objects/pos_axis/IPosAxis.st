USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    INTERFACE IPosAxis EXTENDS ISpeedAxis, ILeadingAxis
        /// With method GetPositioningAxisRef, you get the reference of the attached positioning axis.
        METHOD GetPositioningAxisRef : REF_TO TO_PositioningAxis END_METHOD

        /// With the method PowerOn, a positioning or synchronous axis is enabled and set to position-controlled mode by default.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD PowerOn : ICommand
            VAR_INPUT
                /// FALSE = Enables axis non position-controlled.
                /// TRUE = Enables axis position-controlled.
                positionControlled : BOOL := TRUE;
            END_VAR
        END_METHOD

        /// With the method HomeAbsEncoder, you home the position of a technology object with an absolute encoder on a mechanical reference mark.
        /// The actual position value in the technology object is assigned to a homing mark at the same time. This homing mark represents a known mechanical position.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD HomeAbsEncoder : IHomeCommand
            VAR_INPUT
                /// The specified value is used according to the selected Mode.
                position : LREAL;
                /// The mode of homing operation. 
                mode : HomingModeAbsEncoder := HomingModeAbsEncoder#ADJUSTMENT_SENSOR_ABSOLUTE;
                /// Torque limit for Mode: ACTIVE_ON_FIXED_STOP, ACTIVE_ON_FIXED_STOP_MOVE_OUT_OF_CLAMPING, ACTIVE_ON_FIXED_STOP_MOVE_TO_TARGET_POSITION
                /// Value < 0.0 is not permitted
                fixedStopTorqueLimit : LREAL := LREAL#0.0;
                /// Target position for Mode: ACTIVE_ON_FIXED_STOP_MOVE_TO_TARGET_POSITION
                fixedStopTargetPosition : LREAL := LREAL#0.0;
            END_VAR
        END_METHOD

        /// With the method HomeIncEncoder, you home the position of a technology object with an incremental encoder on a mechanical reference mark.
        /// The actual position value in the technology object is assigned to a homing mark at the same time. This homing mark represents a known mechanical position.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD HomeIncEncoder : IHomeCommand
            VAR_INPUT
                /// The specified value is used according to the selected Mode.
                position : LREAL;
                /// The mode of homing operation.
                mode : HomingModeIncEncoder := HomingModeIncEncoder#PASSIVE_WITH_POSITION_PARAMETER;
                /// Torque limit for Mode: ACTIVE_ON_FIXED_STOP, ACTIVE_ON_FIXED_STOP_MOVE_OUT_OF_CLAMPING, ACTIVE_ON_FIXED_STOP_MOVE_TO_TARGET_POSITION
                /// Value < 0.0 is not permitted
                fixedStopTorqueLimit : LREAL := LREAL#0.0;
                /// Target position for Mode: ACTIVE_ON_FIXED_STOP_MOVE_TO_TARGET_POSITION
                fixedStopTargetPosition : LREAL := LREAL#0.0;
            END_VAR
        END_METHOD

        /// With the method HomeDirect, you home the position of a technology object on a mechanical reference mark.
        /// The actual position value in the technology object is assigned to a homing mark at the same time. This homing mark represents a known mechanical position.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD HomeDirect : IHomeCommand
            VAR_INPUT
                /// The specified value is used according to the selected Mode.
                position : LREAL;
                /// The mode of homing operation.
                mode : HomingModeDirect := HomingModeDirect#ACTUAL_POSITION_ABSOLUTE;
            END_VAR
        END_METHOD

        /// With the method AbortPassiveHoming, you can abort an active job for passive homing.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD AbortPassiveHoming : ICommand END_METHOD

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
                /// FALSE = Jog axis non position-controlled.
                /// TRUE = Jog axis position-controlled.
                positionControlled : BOOL := TRUE;
                /// Increment/distance for Mode: INCREMENTAL, CONTINUE_INCREMENT
                increment : LREAL := LREAL#0.0;
                /// The mode of jogging operation.
                mode : JogMode := JogMode#CONTINUOUS;
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

        /// With the method MoveAbsolute, you can move an axis to an absolute position.
        /// You define the dynamic behavior of the motion with parameters Velocity, Acceleration, Deceleration and Jerk.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD MoveAbsolute : IMoveCommand
            VAR_INPUT
                /// Absolute target position.
                position : LREAL;
                /// Velocity setpoint for the motion.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Value 0.0 is not permitted
                velocity : LREAL := LREAL#-1.0;
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
                /// Direction of the motion of the axis.
                /// This parameter is only evaluated when the technology object is configured as modulo axis.
                direction : DirectionModulo := DirectionModulo#POSITIVE;
                /// Mode of motion transition.
                bufferMode: MoveBufferMode := MoveBufferMode#ABORT_MOTION;
            END_VAR
        END_METHOD

        /// With the method MoveRelative, you move an axis relative to its position when execution of the job began.
        /// You define the dynamic behavior of the motion with parameters Velocity, Acceleration, Deceleration and Jerk.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD MoveRelative : IMoveCommand
            VAR_INPUT
                /// Distance to travel (negative or positive)
                distance : LREAL;
                /// Velocity setpoint for the motion.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Value 0.0 is not permitted
                velocity : LREAL := LREAL#-1.0;
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
                /// Mode of motion transition.
                bufferMode: MoveBufferMode := MoveBufferMode#ABORT_MOTION;
            END_VAR
        END_METHOD

        /// With the method MoveSuperimposed, you can start a relative positioning motion which is superimposed on a running basic motion.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD MoveSuperimposed : ICommand
            VAR_INPUT
                /// Additional distance for the overlapping positioning operation (negative or positive)
                distance : LREAL;
                /// Maximum velocity deviation compared to the active motion
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Value 0.0 is not permitted
                velocityDiff : LREAL := LREAL#-1.0;
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

        /// With the method HaltSuperimposed, you can to decelerate a superimposed motion operation on the axis to zero velocity.
        /// This instruction has no effect on the basic motion of the axis.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD HaltSuperimposed : ICommand
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
                /// FALSE = The current acceleration at the start of the job is reduced using the configured jerk. Afterwards, the deceleration builds up.
                /// TRUE = The acceleration is set to 0.0 at the start of the job, and the deceleration immediately builds up.
                abortAcceleration : BOOL;
            END_VAR
        END_METHOD
        
        /// With the method SetTorqueLimit, you activate and assign parameters for force/torque limiting and fixed stop detection.
        /// The functions can be activated and deactivated by method ResetTorqueLimit, before and during a motion job.
        /// Returns the error ID of the operation (refer to the list of error IDs in manual from Siemens.S7.MotionControl library).
        METHOD SetTorqueLimit : WORD
            VAR_INPUT
                /// Mode of the torque limiting operation.
                mode : TorqueLimitingMode := TorqueLimitingMode#TORQUE_LIMITING;
                /// With rotary motor: Additive setpoint torque 
                /// With linear motor: Additive setpoint force 
                /// Permissible values are -1.0E12 to 1.0E12
                limit : LREAL := LREAL#-1.0;
            END_VAR

            VAR_OUTPUT
                /// The drive operates at least at the threshold value (default 90%) of the torque limit/force limitation.
                inLimitation : BOOL;
                /// The drive is kept at the fixed stop position for Mode: TorqueLimitingMode#FIXED_STOP_DETECTION.
                inClamping : BOOL;
            END_VAR
        END_METHOD
    END_INTERFACE
END_NAMESPACE
