USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    INTERFACE ICamBase EXTENDS IObject
        /// With method GetCamBaseRef, you get the reference of the attached cam (base type for other cams).
        METHOD GetCamBaseRef : REF_TO TO_CamBase END_METHOD
    END_INTERFACE
END_NAMESPACE
