NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    INTERFACE ICamValue
        /// Gets the Valid output of the PLCopen instruction. 
        METHOD Valid : BOOL END_METHOD
        /// Gets the Value output of the PLCopen instruction.
        METHOD Value : LREAL END_METHOD
        /// Gets the ErrorID output of the PLCopen instruction.
        METHOD ErrorID : WORD END_METHOD
    END_INTERFACE
END_NAMESPACE
