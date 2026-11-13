USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS INTERNAL ABSTRACT Axis EXTENDS Object IMPLEMENTS IAxis
        VAR PROTECTED
            _axisRef : REF_TO TO_Axis;
            _powerCmd : PowerCommand;
        END_VAR

        METHOD ABSTRACT MakeAxisAbstract END_METHOD

        /// Attaches the given technology object of type TO_Axis to this specific instance.
        METHOD PROTECTED Attach
            VAR_INPUT
                axisRef : REF_TO TO_Axis;
            END_VAR
            
            _axisRef := axisRef;
            SUPER.Attach(_axisRef);
        END_METHOD

        /// Detaches the current assigned technology object from this instance.
        METHOD PROTECTED OVERRIDE Detach
            _axisRef := NULL;
            SUPER.Detach();
        END_METHOD

        /// With the method PowerOn, a technology object is enabled and, if necessary, a configured drive is switched on.
        /// Returns an object which contains the getter functions to read the status of the
        METHOD PUBLIC PowerOn : ICommand
            PowerOn := _powerCmd.Start(axisRef := _axisRef, enable := TRUE, positionControlled := TRUE, stopMode := PowerOffMode#EMERGENCY_STOP);
        END_METHOD

        /// With the method PowerOff, a technology object is disabled and, if necessary, a configured drive is switched off.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD PUBLIC PowerOff : ICommand
            PowerOff := _powerCmd.Start(axisRef := _axisRef, enable := FALSE, positionControlled := TRUE, stopMode := PowerOffMode#EMERGENCY_STOP);
        END_METHOD
    END_CLASS
END_NAMESPACE
