USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS PUBLIC ExtEncoder EXTENDS Axis IMPLEMENTS IExtEncoder
        VAR
            _externalEncoderRef : REF_TO TO_ExternalEncoder;
            _homeCmd : HomeCommand;
        END_VAR

        METHOD PROTECTED OVERRIDE MakeAxisAbstract ; END_METHOD
    
        METHOD PROTECTED OVERRIDE MakeObjectAbstract ; END_METHOD

        /// Attaches the given technology object of type TO_ExternalEncoder to this specific instance.
        METHOD PUBLIC Attach : BOOL
            VAR_IN_OUT
                axis : TO_ExternalEncoder;
            END_VAR

            _resolvedType := TO_Type#ExternalEncoder;
            Attach := this.Attach(AsExternalEncoderRef(axis));
        END_METHOD

        /// Attaches the given technology object of any type to this specific instance.
        METHOD PUBLIC Attach : BOOL
            VAR_INPUT
                axisDB : DB_ANY;
            END_VAR

            _resolvedType := GetType(axisDB);
            Attach := this.Attach(AsExternalEncoderRef(axisDB));
        END_METHOD

        /// Attaches the given technology object of type TO_ExternalEncoder to this specific instance.
        METHOD PUBLIC Attach : BOOL
            VAR_INPUT
                axis : REF_TO TO_ExternalEncoder;
            END_VAR

            _externalEncoderRef := axis;
            SUPER.Attach(_externalEncoderRef);
            Attach := this.IsAttached();
        END_METHOD

        /// Detaches the current assigned technology object from this instance.
        METHOD PUBLIC Detach : BOOL
            _externalEncoderRef := NULL;
            SUPER.Detach();
            Detach := this.IsAttached();
        END_METHOD

        /// IsAttached returns the state of the attached technology object for this instance.
        METHOD PUBLIC IsAttached : BOOL
            IsAttached := (_externalEncoderRef <> NULL);
        END_METHOD

        /// With method GetExternalEncoderRef, you get the reference of the attached external encoder.
        METHOD PUBLIC GetExternalEncoderRef : REF_TO TO_ExternalEncoder
            GetExternalEncoderRef := _externalEncoderRef;
        END_METHOD

        /// Gets the reference of the attached technology object.
        METHOD PUBLIC GetAxisRef : REF_TO TO_Axis
            GetAxisRef := _axisRef;
        END_METHOD

        /// With the method HomeAbsEncoder, you home the position of a technology object with an absolute encoder on a mechanical reference mark.
        /// The actual position value in the technology object is assigned to a homing mark at the same time. This homing mark represents a known mechanical position.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD PUBLIC HomeAbsEncoder : IHomeCommand
            VAR_INPUT
                /// The specified value is used according to the selected Mode.
                position : LREAL;
                /// The mode of homing operation.
                mode : HomingModeAbsEncoder := HomingModeAbsEncoder#ADJUSTMENT_SENSOR_ABSOLUTE;
            END_VAR

            HomeAbsEncoder := _homeCmd.Start(axisRef := _axisRef, position := position, mode := mode);
        END_METHOD

        /// With the method HomeIncEncoder, you home the position of a technology object with an incremental encoder on a mechanical reference mark.
        /// The actual position value in the technology object is assigned to a homing mark at the same time. This homing mark represents a known mechanical position.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD PUBLIC HomeIncEncoder : IHomeCommand
            VAR_INPUT
                /// The specified value is used according to the selected Mode.
                position : LREAL;
                /// The mode of homing operation.
                mode : HomingModeIncEncoder := HomingModeIncEncoder#PASSIVE_WITH_POSITION_PARAMETER;
            END_VAR

            HomeIncEncoder := _homeCmd.Start(axisRef := _axisRef, position := position, mode := mode);
        END_METHOD

        /// With the method HomeDirect, you home the position of a technology object on a mechanical reference mark.
        /// The actual position value in the technology object is assigned to a homing mark at the same time. This homing mark represents a known mechanical position.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD PUBLIC HomeDirect : IHomeCommand
            VAR_INPUT
                /// The specified value is used according to the selected Mode.
                position : LREAL;
                /// The mode of homing operation.
                mode : HomingModeDirect := HomingModeDirect#ACTUAL_POSITION_ABSOLUTE;
            END_VAR

            HomeDirect := _homeCmd.Start(axisRef := _axisRef, position := position, mode := mode);
        END_METHOD

        /// With the method AbortPassiveHoming, you can abort an active job for passive homing.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD PUBLIC AbortPassiveHoming : ICommand
            AbortPassiveHoming := _homeCmd.Start(axisRef := _axisRef, mode := INT#9);
        END_METHOD
    
        {inline}
        /// With the method GetWarnings, you split the variable WarningWord of this external encoder into individual bits.
        METHOD PUBLIC FINAL GetWarnings : ExternalEncoderWarnings
            GetWarnings := GetExternalEncoderWarnings(_externalEncoderRef^);
        END_METHOD

        {inline}
        /// With the method GetErrors, you split the variable ErrorWord of this external encoder into individual bits.
        METHOD PUBLIC FINAL GetErrors : ExternalEncoderErrors
            GetErrors := GetExternalEncoderErrors(_externalEncoderRef^);
        END_METHOD

        {inline}
        /// With the method GetStatus, you split the variables StatusWord of this external encoder into individual bits.
        METHOD PUBLIC FINAL GetStatus : ExternalEncoderStatus
            GetStatus := GetExternalEncoderStatus(_externalEncoderRef^);
        END_METHOD
    END_CLASS
END_NAMESPACE