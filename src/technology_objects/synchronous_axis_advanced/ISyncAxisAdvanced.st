NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    INTERFACE ISyncAxisAdvanced EXTENDS ISyncAxis
        /// With the method GearInVelocity, you start a velocity gearing operation between a leading axis and a following axis.
        /// The following axis is synchronized to the velocity of the leading axis depending on the specified gear ratio.
        /// You can start velocity synchronous operation when the leading axis is at a standstill or when it is in motion.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD GearInVelocity : ICommand
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
                /// FALSE = Synchronizes the following axis non position-controlled.
                /// TRUE = Synchronizes the following axis position-controlled.
                positionControlled : BOOL;
            END_VAR
        END_METHOD

        /// With the method GearInAbsolute, you start a gearing operation between a leading axis and a following axis.
        /// The following axis is synchronized depending on the specified synchronous positions for the leading and following axis.
        /// You can start synchronous operation when the leading axis is at a standstill or when it is in motion.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD GearInAbsolute : ICommand
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
                /// Synchronous position of leading axis.
                /// Position of the leading axis from which the axes are synchronous and the synchronization is completed when profile is IN_ADVANCE_BY_LEADING_VALUE_DISTANCE or IN_ADVANCE_BY_LEADING_VALUE_DISTANCE.
                /// Position of the leading axis from which synchronization starts when profile is SUBSEQUENT_BY_LEADING_VALUE_DISTANCE.
                leadingSyncPosition : LREAL;
                /// Synchronous position of following axis.
                /// Position of the following axis from which the axes are synchronous and the synchronization is completed, when profile is IN_ADVANCE_BY_DYNAMICS_PARAMETER or IN_ADVANCE_BY_LEADING_VALUE_DISTANCE.
                /// Position of the following axis, which is assigned to the synchronous position of the leading axis when profile is SUBSEQUENT_BY_LEADING_VALUE_DISTANCE.
                followingSyncPosition : LREAL;
                /// Profile of synchronization.
                syncProfileReference : GearInProfile := GearInProfile#IN_ADVANCE_BY_LEADING_VALUE_DISTANCE;
                /// Leading value distance when profile is IN_ADVANCE_BY_LEADING_VALUE_DISTANCE, SUBSEQUENT_BY_LEADING_VALUE_DISTANCE, SUBSEQUENT_BY_LEADING_VALUE_DISTANCE, SUBSEQUENT_BY_LEADING_VALUE_DISTANCE_IMMEDIATELY OR SUBSEQUENT_BY_LEADING_VALUE_DISTANCE_AT_LEADING_SYNC_POSITION.
                /// Value <= 0.0 is not permitted.
                leadingStartDistance : LREAL;
                /// Velocity setpoint for the motion when profile is IN_ADVANCE_BY_DYNAMICS_PARAMTERS.
                /// Default value from technology object is used when < 0.0
                /// Value 0.0 is not permitted
                velocity : LREAL := LREAL#-1.0;
                /// Acceleration setpoint for the motion when profile is IN_ADVANCE_BY_DYNAMICS_PARAMTERS.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Value 0.0 is not permitted                   
                acceleration : LREAL := LREAL#-1.0;
                /// Deceleration setpoint for the motion when profile is IN_ADVANCE_BY_DYNAMICS_PARAMTERS.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Value 0.0 is not permitted                    
                deceleration : LREAL := LREAL#-1.0;
                /// Jerk setpoint for the motion when profile is IN_ADVANCE_BY_DYNAMICS_PARAMTERS.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Trapezoid velocity profile is applied when = 0.0                   
                jerk : LREAL := LREAL#-1.0;
                /// Direction of synchronization (effective for following axes with activated modulo setting).
                syncDirection : DirectionModulo := DirectionModulo#SHORTEST_DISTANCE;
            END_VAR
        END_METHOD

        /// With the method GearOut, you end a gearing operation between a leading axis and a following axis.
        /// The following axis is desynchronized and comes to a standstill at the specified stop position.
        /// Pending gearing operation is being canceled.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD GearOut : ICommand
            VAR_INPUT
                /// Profile of desynchronization
                syncProfileReference : SyncOutProfile := SyncOutProfile#LEADING_VALUE_DISTANCE;
                /// Stop position of the following axis.
                followingPosition : LREAL;
                /// Leading value distance whe profile is LEADING_VALUE_DISTANCE.
                leadingStopDistance : LREAL;
                /// Deceleration setpoint for the motion when profile is DYNAMICS_PARAMETERS.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Value 0.0 is not permitted     
                deceleration : LREAL := LREAL#-1.0;
                /// Jerk setpoint for the motion when profile is DYNAMICS_PARAMETERS.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Trapezoid velocity profile is applied when = 0.0   
                jerk : LREAL := LREAL#-1.0;
                /// Direction of synchronization (effective for following axes with activated modulo setting).
                syncOutDirection : DirectionSyncOut := DirectionSyncOut#CURRENT;
            END_VAR
        END_METHOD

        /// With the method CamIn, you start a camming operation between a leading axis and a following axis.
        /// The following axis is synchronized depending on the specified synchronous position of the leading axis.
        /// The synchronous position of the leading axis and the corresponding position of the following axis from the cam represent the relationship of both axes to one another.
        /// Returns an object which contains the getter functions to read the status of the asynchronous camming operation.
        METHOD CamIn : ICamInCommand
            VAR_INPUT
                /// Leading axis interface object.   
                leadingAxis : ILeadingAxis;
                /// Cam interface object.
                cam : ICamBase;
                /// Offset of the leading values of the cam when profile is SYNC_DYNAMIC, SYNC_LEADING, SUBSEQUENT_SYNC_LEADING or SUBSEQUENT_SYNC_LEADING_STARTING_CURRENT_POS.
                leadingOffset : LREAL;
                /// Offset of the following values of the cam when profile is SYNC_DYNAMIC, SYNC_LEADING, SUBSEQUENT_SYNC_LEADING, SUBSEQUENT_SYNC_LEADING_STARTING_CURRENT_POS or SYNC_LEADING_STARTING_NOW.
                followingOffset : LREAL;
                /// Scaling the leading values of the cam.
                leadingScaling : LREAL := LREAL#1.0;
                /// Scaling the following values of the cam.
                followingScaling : LREAL := LREAL#1.0;
                /// Synchronous position of leading axis.
                /// Position of the leading axis (relative to the start position of the cam), from which the axes are synchronous and synchronization is complete when profile is SYNC_DYNAMIC, SYNC_LEADING, SYNC_LEADING_STARTING_NOW.
                /// Position of the leading axis (relative to the start position of the cam) from which the synchronization begins when profile is SUBSEQUENT_SYNC_LEADING.
                /// Position of the leading axis (relative to the start position of the cam to be changed), from which the axes are synchronous when profile is SYNC_DIRECT or SYNC_DIRECT_AT_CAM_END. 
                /// Value must be within the definition of the cam.
                leadingSyncPosition : LREAL;
                /// Profile for synchronization.
                syncProfileReference : CamInProfile := CamInProfile#IN_ADVANCE_BY_LEADING_VALUE_DISTANCE;
                /// Distance of the leading axis during the synchronization when profile is SYNC_LEADING, SUBSEQUENT_SYNC_LEADING, SUBSEQUENT_SYNC_LEADING_STARTING_CURRENT_POS or SYNC_LEADING_STARTING_NOW. 
                /// Value <= 0.0 is not permitted   
                leadingStartDistance : LREAL;
                /// Velocity setpoint for the motion when profile is IN_ADVANCE_BY_DYNAMICS_PARAMETERS.
                /// Default value from technology object is used when < 0.0
                /// Value 0.0 is not permitted
                velocity : LREAL := LREAL#-1.0;
                /// Acceleration setpoint for the motion when profile is IN_ADVANCE_BY_DYNAMICS_PARAMTERS.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Value 0.0 is not permitted    
                acceleration : LREAL := LREAL#-1.0;
                /// Deceleration setpoint for the motion when profile is IN_ADVANCE_BY_DYNAMICS_PARAMTERS.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Value 0.0 is not permitted
                deceleration : LREAL := LREAL#-1.0;
                /// Jerk setpoint for the motion when profile is IN_ADVANCE_BY_DYNAMICS_PARAMTERS.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Trapezoid velocity profile is applied when = 0.0 
                jerk : LREAL := LREAL#-1.0;
                /// Application mode of the cam.
                applicationMode : CamApplicationMode;
                /// Direction of synchronization (effective for following axes with activated modulo setting).
                syncDirection : DirectionModulo := DirectionModulo#SHORTEST_DISTANCE;
            END_VAR
        END_METHOD

        /// With the method CamOut, you end a camming operation between a leading axis and a following axis.
        /// The following axis is desynchronized and comes to a standstill at the specified stop position.
        /// Pending gearing operation is being canceled.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD CamOut : ICommand
            VAR_INPUT
                /// Stop position of following axis.
                followingPosition : LREAL;
                /// Profile for desynchronization.
                syncProfileReference : SyncOutProfile := SyncOutProfile#LEADING_VALUE_DISTANCE;
                /// Leading value distance when profile is LEADING_VALUE_DISTANCE. 
                /// Value <= 0.0 is not permitted
                leadingStopDistance : LREAL;
                /// Deceleration setpoint for the motion when profile is DYNAMICS_PARAMETERS.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Value 0.0 is not permitted 
                deceleration : LREAL := LREAL#-1.0;
                /// Jerk setpoint for the motion when profile is DYNAMICS_PARAMETERS.
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Trapezoid velocity profile is applied when = 0.0 
                jerk : LREAL := LREAL#-1.0;
                /// Direction of desynchronization (effective for following axes with activated modulo setting).
                syncOutDirection : DirectionSyncOut := DirectionSyncOut#CURRENT;
            END_VAR
        END_METHOD

        /// With the method SyncMotionSimulationEnable, you enable to simulate an active synchronous operation on a following axis.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD SyncMotionSimulationEnable : ICommand END_METHOD

        /// With the method SyncMotionSimulationDisable, you disable to simulate an active synchronous operation on a following axis.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD SyncMotionSimulationDisable : ICommand END_METHOD

        /// With the method PhasingRelative, you shift the effective leading value relative to a following axis.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD PhasingRelative : ICommand
            VAR_INPUT
                /// Leading axis interface object.
                leadingAxis : ILeadingAxis;
                /// Relative leading value offset.
                phaseShift : LREAL;
                /// Velocity setpoint for the motion (added to synchronous operation motion).
                /// Default value from technology object is used when < 0.0
                /// Value 0.0 is not permitted
                velocity : LREAL := LREAL#-1.0;
                /// Acceleration setpoint for the motion (added to synchronous operation motion).
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Value 0.0 is not permitted    
                acceleration : LREAL := LREAL#-1.0;
                /// Deceleration setpoint for the motion (added to synchronous operation motion).
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Value 0.0 is not permitted
                deceleration : LREAL := LREAL#-1.0;
                /// Jerk setpoint for the motion (added to synchronous operation motion).
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Trapezoid velocity profile is applied when = 0.0 
                jerk : LREAL := LREAL#-1.0;
                /// Profile of leading value offset.
                profileReference : PhasingProfile;
                /// Distance of the leading axis during leading value offset when profileReference is LEADING_VALUE_DISTANCE or LEADING_VALUE_DISTANCE_AT_START_POSITION.
                phasingDistance : LREAL;
                /// Leading value position as of which the leading value is offset when profileReference is LEADING_VALUE_DISTANCE_AT_START_POSITION.
                startPosition : LREAL;
                /// Direction of the leading value distance when profileReference is LEADING_VALUE_DISTANCE_AT_START_POSITION.
                direction : DirectionPhasingOffset := DirectionPhasingOffset#CURRENT;
             END_VAR
        END_METHOD

        /// With the method PhasingAbsolute, you shift the effective leading value absolute to a following axis.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD PhasingAbsolute : ICommand
            VAR_INPUT
                /// Leading axis interface object.
                leadingAxis : ILeadingAxis;
                /// Relative leading value offset.
                phaseShift : LREAL;
                /// Velocity setpoint for the motion (added to synchronous operation motion).
                /// Default value from technology object is used when < 0.0
                /// Value 0.0 is not permitted
                velocity : LREAL := LREAL#-1.0;
                /// Acceleration setpoint for the motion (added to synchronous operation motion).
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Value 0.0 is not permitted    
                acceleration : LREAL := LREAL#-1.0;
                /// Deceleration setpoint for the motion (added to synchronous operation motion).
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Value 0.0 is not permitted
                deceleration : LREAL := LREAL#-1.0;
                /// Jerk setpoint for the motion (added to synchronous operation motion).
                /// Value is used when > 0.0
                /// Default value from technology object is used when < 0.0
                /// Trapezoid velocity profile is applied when = 0.0 
                jerk : LREAL := LREAL#-1.0;
                /// Profile of leading value offset.
                profileReference : PhasingProfile;
                /// Distance of the leading axis during leading value offset when profileReference is LEADING_VALUE_DISTANCE or LEADING_VALUE_DISTANCE_AT_START_POSITION.
                phasingDistance : LREAL;
                /// Leading value position as of which the leading value is offset when profileReference is LEADING_VALUE_DISTANCE_AT_START_POSITION.
                startPosition : LREAL;
                /// Direction of the leading value distance when profileReference is LEADING_VALUE_DISTANCE_AT_START_POSITION.
                direction : DirectionPhasingOffset := DirectionPhasingOffset#CURRENT;
             END_VAR
        END_METHOD
        
        /// With the method OffsetRelative, you shift the following value relative to the current position of a following axis.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD OffsetRelative : ICommand
            VAR_INPUT
                /// Relative following value offset.
                offset : LREAL;
                /// Profile for the following value offset.
                profileReference : OffsetProfile := OffsetProfile#LEADING_VALUE_DISTANCE;
                /// Effective leading value distance during following value offset when profileReference is LEADING_VALUE_DISTANCE or LEADING_VALUE_DISTANCE_AT_START_POSITION.
                offsetDistance : LREAL;
                /// Effective leading value position as of which the following value is offset when profileReference is LEADING_VALUE_DISTANCE_AT_START_POSITION.
                startPosition : LREAL;
                /// Direction of the leading value distance when profileReference is LEADING_VALUE_DISTANCE or LEADING_VALUE_DISTANCE_AT_START_POSITION.
                direction : DirectionPhasingOffset := DirectionPhasingOffset#CURRENT;
             END_VAR
        END_METHOD

        /// With the method OffsetAbsolute, you shift the following value absolute to the current position of a following axis.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD OffsetAbsolute : ICommand
            VAR_INPUT
                /// Absolute following value offset.
                offset : LREAL;
                /// Profile for the following value offset.
                profileReference : OffsetProfile := OffsetProfile#LEADING_VALUE_DISTANCE;
                /// Effective leading value distance during following value offset when profileReference is LEADING_VALUE_DISTANCE or LEADING_VALUE_DISTANCE_AT_START_POSITION.
                offsetDistance : LREAL;
                /// Effective leading value position as of which the following value is offset when profileReference is LEADING_VALUE_DISTANCE_AT_START_POSITION.
                startPosition : LREAL;
                /// Direction of the leading value distance when profileReference is LEADING_VALUE_DISTANCE or LEADING_VALUE_DISTANCE_AT_START_POSITION.
                direction : DirectionPhasingOffset := DirectionPhasingOffset#CURRENT;
             END_VAR
        END_METHOD
        
        /// With the method SetLeadingValueAdditive, you specify an additive leading value cyclically in addition to the active leading value of a following axis.
        /// Changes to the specified values are effective immediately without consideration of the dynamic limits.
        /// Returns the error ID of the operation.
        METHOD SetLeadingValueAdditive : Word
            VAR_INPUT
                /// Additive position value.
                /// Warning: Provide the position difference iterative, otherwise this will lead to setpoint jumps in case of greater value differences.
                position : LREAL;
                /// Additive velocity value.
                /// Warning: Observe the dynamic limits and provide the position difference iterative, otherwise this will lead to setpoint jumps in case of greater value differences.
                velocity : LREAL;
                /// Additive acceleration value.
                /// Warning: Observe the dynamic limits and provide the position difference iterative, otherwise this will lead to setpoint jumps in case of greater value differences.
                acceleration : LREAL;
             END_VAR
        END_METHOD

        /// With the method ResetLeadingValueAdditive, you reset an additive leading value set before with SetLeadingValueAdditive.
        METHOD ResetLeadingValueAdditive END_METHOD
    END_INTERFACE
END_NAMESPACE
