NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    TYPE
        /// Mode for stopping the motion operations of an axis.
        StopMode : DINT (
            /// Using emergency stopping dynamics.
            EMERGENCY_STOP := DINT#0,
            // Reserved := DINT#1,
            /// Using maximum stopping dynamics.
            MAX_DYNAMICS_STOP := DINT#2,
            /// Using dynamics from stop instruction.
            BY_PARAMETERS := DINT#3
        ) := EMERGENCY_STOP;
    END_TYPE
END_NAMESPACE
