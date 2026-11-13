NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    TYPE
        /// Modes for reading following value from a cam disk.
        CamValueApplicationMode : DINT (
            /// Read following value (position).
            ONLY_VALUE := DINT#0,
            /// Read following value (position) and first derivative (velocity).
            UP_TO_FIRST_DERIVATIVE := DINT#1,
            /// Read following value (position), first derivative (velocity) and second derivative (acceleration).
            UP_TO_SECOND_DERIVATIVE := DINT#2,
            /// Read following value (position), first derivative (velocity), second derivative (acceleration) and third derivative (jerk).
            UP_TO_THIRD_DERIVATIVE := DINT#3
        ) := UP_TO_SECOND_DERIVATIVE;
    END_TYPE
END_NAMESPACE
