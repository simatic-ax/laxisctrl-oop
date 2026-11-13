NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    TYPE
        /// Mode for absolute homing operation.
        HomingModeAbsEncoder : INT (
            /// The current position is shifted by the value of parameter Position.
            ADJUSTMENT_SENSOR_RELATIVE := INT#6,
            /// The current position is set to the value of parameter Position.
            ADJUSTMENT_SENSOR_ABSOLUTE := INT#7,
            /// Homes the axis via fixed stop detection.
            ACTIVE_ON_FIXED_STOP := INT#20,
            /// Homes the axis via fixed stop detection and moves out of clamping.
            ACTIVE_ON_FIXED_STOP_MOVE_OUT_OF_CLAMPING := INT#21,
            /// Homes the axis via fixed stop detection and moves to a target position.
            ACTIVE_ON_FIXED_STOP_MOVE_TO_TARGET_POSITION := INT#22
        ) := ADJUSTMENT_SENSOR_ABSOLUTE;
    END_TYPE
END_NAMESPACE
