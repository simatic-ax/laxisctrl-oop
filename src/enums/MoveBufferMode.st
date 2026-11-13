NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    TYPE
        /// Buffer behaviour of a motion command.
        MoveBufferMode : DINT (
            /// Abort active motion (results into an aborted command for any previous command).
            ABORT_MOTION := DINT#0,
            /// Append new motion.
            APPEND_MOTION := DINT#1
        ) := ABORT_MOTION;
    END_TYPE
END_NAMESPACE
