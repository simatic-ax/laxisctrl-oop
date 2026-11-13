NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    TYPE
        /// Mode for copying cam data.
        CopyCamDataMode : DINT (
            /// All existing defined cam elements are set as invalid before the copying procedure.
            SET_EXISTING_INVALID := DINT#0,
            /// All existing defined cam elements remain valid.
            KEEP_EXISTING_VALID := DINT#1
        ) := SET_EXISTING_INVALID;
    END_TYPE
END_NAMESPACE
