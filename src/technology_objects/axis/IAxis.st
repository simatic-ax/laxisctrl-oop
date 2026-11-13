NAMESPACE Simatic.Ax.LAxisCtrl.Oop
/// Contains the 
INTERFACE IAxis EXTENDS IObject
        /// With the method PowerOn, a technology object is enabled and, if necessary, a configured drive is switched on.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD PowerOn : ICommand END_METHOD

        /// With the method PowerOff, a technology object is disabled and, if necessary, a configured drive is switched off.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD PowerOff : ICommand END_METHOD
    END_INTERFACE
END_NAMESPACE
