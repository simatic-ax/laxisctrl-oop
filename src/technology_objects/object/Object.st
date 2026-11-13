USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS INTERNAL ABSTRACT Object IMPLEMENTS IObject
        VAR PRIVATE
            _resetCmd : ResetCommand;
            _objectRef : REF_TO TO_Object;
        END_VAR

        VAR PROTECTED
            _resolvedType : TO_Type := TO_Type#Unknown;
        END_VAR

        METHOD ABSTRACT MakeObjectAbstract END_METHOD
        
        METHOD PROTECTED Attach
            VAR_INPUT
                objectRef : REF_TO TO_Object;
            END_VAR
            
            _objectRef := objectRef;
        END_METHOD

        METHOD PROTECTED Detach
            _objectRef := NULL;
        END_METHOD

        /// With the method ResetAlarms, you acknowledge all technology alarms that can be acknowledged in the user program.
        /// Acknowledgment also resets the "Error" and "Warning" bits in the technology object data block.
        /// An acknowledgment of alarms in the drive is also possible without a pending error at the technology object.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD PUBLIC ResetAlarms : ICommand
            ResetAlarms := _resetCmd.Start(_objectRef, FALSE);
        END_METHOD

        /// With the method Restart, you start reinitialization (restart) of technology objects.
        /// Upon restart of the technology object, the new configuration data are applied in the technology object data block.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD PUBLIC Restart : ICommand
            Restart := _resetCmd.Start(_objectRef, TRUE);
        END_METHOD

        /// By using the GetType method, you can determine the specific type of the technology object that is attached.  
        /// Returns the type of this technology object.
        METHOD PUBLIC GetType : TO_Type
            GetType := _resolvedType;
        END_METHOD
    END_CLASS
END_NAMESPACE
