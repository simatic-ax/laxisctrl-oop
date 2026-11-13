USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS INTERNAL GetLeadingValueCommand EXTENDS ExecuteCommand
        VAR
            _getLeadingValue : MC_GetCamLeadingValue;
            _camRef : REF_TO TO_CamBase;
        END_VAR

        VAR PUBLIC
            LeadingValue: LREAL;
        END_VAR

        {inline}
        METHOD INTERNAL Start : ICommand
            VAR_INPUT
                camRef : REF_TO TO_CamBase;
                followingValue : LREAL;
                approachLeadingValue : LREAL;
                approachDirection : DINT;
                masterOffset : LREAL;
                slaveOffset : LREAL;
                masterScaling : LREAL;
                slaveScaling : LREAL;
            END_VAR

            _camRef := camRef;
            _getLeadingValue.FollowingValue := followingValue;
            _getLeadingValue.ApproachLeadingValue := approachLeadingValue;
            _getLeadingValue.ApproachDirection := approachDirection;
            _getLeadingValue.MasterOffset := masterOffset;
            _getLeadingValue.SlaveOffset := slaveOffset;
            _getLeadingValue.MasterScaling := masterScaling;
            _getLeadingValue.SlaveScaling := slaveScaling;

            this.ExecuteWithRisingEdge();
            Start := THIS;
        END_METHOD

        {inline}
        METHOD PROTECTED OVERRIDE SetExecute
            VAR_INPUT
                execute : BOOL;
            END_VAR

            _getLeadingValue.Execute := execute;
        END_METHOD

        {inline}
        METHOD PROTECTED OVERRIDE Execute
            _getLeadingValue(
                Cam := _camRef^,
                Done => _done,
                Error => _error,
                ErrorID => _errorID,
                Value => LeadingValue
            );
        END_METHOD

        // Make execute accessible for the trick - see impl of ICam.GetCamLeadingValue()
        METHOD PUBLIC ExecuteUntilDone
            REPEAT
                this.Execute();
            UNTIL _done || _error END_REPEAT;
        END_METHOD
    END_CLASS
END_NAMESPACE
