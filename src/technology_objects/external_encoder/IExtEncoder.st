USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    INTERFACE IExtEncoder EXTENDS IAxis, ILeadingAxis
        /// With method GetExternalEncoderRef, you get the reference of the attached external encoder.
        METHOD GetExternalEncoderRef : REF_TO TO_ExternalEncoder END_METHOD

        /// With the method HomeAbsEncoder, you home the position of a technology object with an absolute encoder on a mechanical reference mark.
        /// The actual position value in the technology object is assigned to a homing mark at the same time. This homing mark represents a known mechanical position.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD HomeAbsEncoder : IHomeCommand
            VAR_INPUT
                /// The specified value is used according to the selected Mode.
                position : LREAL;
                /// The mode of homing operation.
                mode : HomingModeAbsEncoder := HomingModeAbsEncoder#ADJUSTMENT_SENSOR_ABSOLUTE;
            END_VAR
        END_METHOD

        /// With the method HomeIncEncoder, you home the position of a technology object with an incremental encoder on a mechanical reference mark.
        /// The actual position value in the technology object is assigned to a homing mark at the same time. This homing mark represents a known mechanical position.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD HomeIncEncoder : IHomeCommand
            VAR_INPUT
                /// The specified value is used according to the selected Mode.
                position : LREAL;
                /// The mode of homing operation.
                mode : HomingModeIncEncoder := HomingModeIncEncoder#PASSIVE_WITH_POSITION_PARAMETER;
            END_VAR
        END_METHOD

        /// With the method HomeDirect, you home the position of a technology object on a mechanical reference mark.
        /// The actual position value in the technology object is assigned to a homing mark at the same time. This homing mark represents a known mechanical position.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD HomeDirect : IHomeCommand
            VAR_INPUT
                /// The specified value is used according to the selected Mode.
                position : LREAL;
                /// The mode of homing operation.
                mode : HomingModeDirect := HomingModeDirect#ACTUAL_POSITION_ABSOLUTE;
            END_VAR
        END_METHOD

        /// With the method AbortPassiveHoming, you can abort an active job for passive homing.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD AbortPassiveHoming : ICommand END_METHOD

        /// With the method GetWarnings, you split the variable WarningWord of this external encoder into individual bits.
        METHOD GetWarnings : ExternalEncoderWarnings  END_METHOD
        
        /// With the method GetErrors, you split the variable ErrorWord of this external encoder into individual bits.
        METHOD GetErrors : ExternalEncoderErrors END_METHOD

        /// With the method GetStatus, you split the variables StatusWord of this external encoder into individual bits.
        METHOD GetStatus : ExternalEncoderStatus END_METHOD
    END_INTERFACE
END_NAMESPACE
