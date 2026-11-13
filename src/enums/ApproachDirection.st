NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    TYPE
        /// Approach direction for getting leading value.
        ApproachDirection : DINT (
            /// Positive direction.
            POSITIVE := DINT#1,
            /// Negative direction.
            NEGATIVE := DINT#2,
            /// Nearest value.
            NEAREST_VALUE := DINT#3
        ) := NEAREST_VALUE;
    END_TYPE
END_NAMESPACE
