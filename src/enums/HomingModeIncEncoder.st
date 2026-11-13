NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    TYPE
        /// Mode for homing operation of incremental encoder.
        HomingModeIncEncoder : INT (
            /// When the homing mark is detected, the actual value is set to the value of the Position parameter (status homed remains active).
            PASSIVE_WITHOUT_RESET := INT#2,
            /// The positioning axis/synchronous axis technology object performs a homing movement according to the configuration.
            ACTIVE_WITH_POSITION_PARAMETER := INT#3,
            // Reserved := INT#4,
            /// The positioning axis/synchronous axis technology object performs a homing movement according to the configuration.
            ACTIVE := INT#5,
            /// When the homing mark is detected, the actual value is set to the value of the Position parameter.
            PASSIVE_WITH_POSITION_PARAMETER := INT#8,
            /// When the homing mark is detected, the actual value is set to the home position configured in the properties of the axis technology object.
            PASSIVE := INT#10,
            /// The current position is set to the value of parameter Position.
            ADJUSTMENT_SENSOR := INT#13,
            /// Homes the axis via fixed stop detection.
            ACTIVE_ON_FIXED_STOP := INT#20,
            /// Homes the axis via fixed stop detection and moves out of clamping.
            ACTIVE_ON_FIXED_STOP_MOVE_OUT_OF_CLAMPING := INT#21,
            /// Homes the axis via fixed stop detection and moves to a target position.
            ACTIVE_ON_FIXED_STOP_MOVE_TO_TARGET_POSITION := INT#22
        ) := ADJUSTMENT_SENSOR;
    END_TYPE
END_NAMESPACE
