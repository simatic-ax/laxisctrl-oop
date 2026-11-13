NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    /// Contains the outputs of a move absolute or relative instruction which is returned from an asynchronous operation.
    INTERFACE IMoveCommand EXTENDS ICommand
        /// Gets the Active output of the PLCopen instruction.
        METHOD Active : BOOL END_METHOD
    END_INTERFACE
END_NAMESPACE
