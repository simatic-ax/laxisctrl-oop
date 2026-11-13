USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    INTERFACE IObject
        /// With the method ResetAlarms, you acknowledge all technology alarms that can be acknowledged in the user program.
        /// Acknowledgment also resets the "Error" and "Warning" bits in the technology object data block.
        /// An acknowledgment of alarms in the drive is also possible without a pending error at the technology object.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD ResetAlarms : ICommand END_METHOD

        /// With the method Restart, you start reinitialization (restart) of technology objects.
        /// Upon restart of the technology object, the new configuration data are applied in the technology object data block.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD Restart : ICommand END_METHOD
        
        /// By using the GetType method, you can determine the specific type of the technology object that is attached.  
        /// Returns the type of this technology object.
        METHOD GetType : TO_Type END_METHOD
    END_INTERFACE
END_NAMESPACE
