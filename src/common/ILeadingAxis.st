USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    INTERFACE ILeadingAxis
        /// With method GetAxisRef, you get the reference of the attached axis (base type for possible leading axis)
        METHOD GetAxisRef : REF_TO TO_Axis END_METHOD
    END_INTERFACE
END_NAMESPACE
