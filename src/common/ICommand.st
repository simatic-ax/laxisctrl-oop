NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    /// Contains the common status outputs of a PLCopen instruction which is returned from an aynchronous operation. 
    INTERFACE ICommand
        /// Gets the Busy output of the PLCopen instruction.
        METHOD Busy : BOOL END_METHOD
        /// Gets the Done output of the PLCopen instruction.
        METHOD Done : BOOL END_METHOD
        /// Gets the Aborted output of the PLCopen instruction.
        METHOD Aborted : BOOL END_METHOD
        /// Gets the Error output of the PLCopen instruction.
        METHOD Error : BOOL END_METHOD
        /// Gets the ErrorId output of the PLCopen instruction (refer to the list of error IDs in manual from Siemens.S7.MotionControl library).
        METHOD ErrorID : WORD END_METHOD
    END_INTERFACE
END_NAMESPACE
