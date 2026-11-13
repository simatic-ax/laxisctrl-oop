NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    TYPE
        /// Mode for direct homing operation.
        HomingModeDirect : INT (
            /// The current position of the technology object is set to the value of parameter Position.
            ACTUAL_POSITION_ABSOLUTE := INT#0,
            /// The current position of the technology object is shifted by the value of parameter Position.
            ACTUAL_POSITION_RELATIVE := INT#1,
            /// The set position of the technology object is set to the value of the Position parameter.
            SETPOINT_POSITION_ABSOLUTE := INT#11,
            /// The set position of the technology object is shifted by the value of the Position parameter.
            SETPOINT_POSITION_RELATIVE := INT#12
        ) := ACTUAL_POSITION_ABSOLUTE;
    END_TYPE
END_NAMESPACE
