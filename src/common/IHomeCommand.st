NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    /// Contains the outputs of a homing instruction which is returned from an asynchronous operation.
    INTERFACE IHomeCommand EXTENDS ICommand
        /// Returns the reference mark position of a successfull homing instruction.
        METHOD ReferenceMarkPosition : LREAL END_METHOD
    END_INTERFACE
END_NAMESPACE
