NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    INTERFACE ICamFollowingValue EXTENDS ICamValue
        /// Gets the value of the first derivative of the following value.
        METHOD FirstDerivative : LREAL END_METHOD
        /// Gets the value of the second derivative of the following value.
        METHOD SecondDerivative : LREAL END_METHOD
    END_INTERFACE
END_NAMESPACE
