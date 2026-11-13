USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS INTERNAL CamBase EXTENDS Object IMPLEMENTS ICamBase
        VAR PROTECTED
            _camBaseRef : REF_TO TO_CamBase;
        END_VAR
    
        METHOD PROTECTED OVERRIDE MakeObjectAbstract ; END_METHOD
        
        /// Attaches the given technology object of any type to this specific instance.
        METHOD PUBLIC Attach : BOOL
            VAR_INPUT
                axisDB : DB_ANY;
            END_VAR

            _resolvedType := GetType(axisDB);
            Attach := this.Attach(AsCamBaseRef(axisDB));
        END_METHOD

        /// Detaches the current assigned technology object from this instance.
        METHOD PUBLIC Detach : BOOL
            _camBaseRef := NULL;
            SUPER.Detach();
            Detach := this.IsAttached();
        END_METHOD

        /// Attaches the given technology object of type TO_CamBase to this specific instance.
        METHOD INTERNAL Attach : BOOL
            VAR_INPUT
                axis : REF_TO TO_CamBase;
            END_VAR

            _camBaseRef := axis;
            SUPER.Attach(axis);
            Attach := this.IsAttached();
        END_METHOD

        /// IsAttached returns the state of the attached technology object for this instance.
        METHOD PUBLIC IsAttached : BOOL
            IsAttached := (_camBaseRef <> NULL);
        END_METHOD

        /// With method GetCamBaseRef, you get the reference of the attached cam (base type for other cams).
        METHOD PUBLIC GetCamBaseRef : REF_TO TO_CamBase
            GetCamBaseRef := _camBaseRef;
        END_METHOD
    END_CLASS
END_NAMESPACE