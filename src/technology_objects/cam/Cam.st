USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS PUBLIC Cam EXTENDS CamBase IMPLEMENTS ICam
        VAR PRIVATE
             interpolateCamCmd : InterpolateCamCommand;
             copyCamDataCmd : CopyCamDataCommand;
             getCamLeadingValueCmd : GetLeadingValueCommand;
             getCamFollowingValueCyclic : MC_GETCAMFOLLOWINGVALUECYCLIC;

             camLeadingValue : ValueImpl;
             camFollowingValue : CamValueImpl;
        END_VAR

        VAR PROTECTED
            _camRef : REF_TO TO_CAM;
            _cam10kRef : REF_TO TO_CAM_10K;
            _cam600SegRef : REF_TO TO_Cam_600Seg;
            _cam6kSegRef : REF_TO TO_Cam_6kSeg;
        END_VAR

        /// Attaches the given technology object of type TO_Cam to this specific instance.
        METHOD PUBLIC Attach : BOOL
            VAR_IN_OUT
                cam : TO_Cam;
            END_VAR

            _resolvedType := TO_Type#Cam;
            _camRef := AsCamRef(cam);
            Attach := this.Attach(_camRef);
        END_METHOD

        /// Attaches the given technology object of type TO_Cam_10K to this specific instance.
        METHOD PUBLIC Attach : BOOL
            VAR_IN_OUT
                cam : TO_Cam_10K;
            END_VAR

             _resolvedType := TO_Type#Cam_10k;
            _cam10kRef := AsCam_10KRef(cam);
            Attach := this.Attach(_cam10kRef);
        END_METHOD

        /// Attaches the given technology object of type TO_Cam_600Seg to this specific instance.
        METHOD PUBLIC Attach : BOOL
            VAR_IN_OUT
                cam : TO_Cam_600Seg;
            END_VAR

             _resolvedType := TO_Type#Cam_600Seg;
            _cam600SegRef := AsCam_600SegRef(cam);
            Attach := this.Attach(_cam600SegRef);
        END_METHOD

        /// Attaches the given technology object of type TO_Cam_6kSeg to this specific instance.
        METHOD PUBLIC Attach : BOOL
            VAR_IN_OUT
                cam : TO_Cam_6kSeg;
            END_VAR

             _resolvedType := TO_Type#Cam_6kSeg;
            _cam6kSegRef := AsCam_6kSegRef(cam);
            Attach := this.Attach(_cam6kSegRef);
        END_METHOD

        /// Attaches the given technology object of any type to this specific instance.
        METHOD PUBLIC OVERRIDE Attach : BOOL
            VAR_INPUT
                axisDB : DB_ANY;
            END_VAR

            Attach := SUPER.Attach(axisDB);
            CASE _resolvedType OF
                TO_Type#Cam:
                    _camRef := AsCamRef(axisDB);
                TO_Type#Cam_10k:
                    _cam10kRef := AsCam_10KRef(axisDB);
                TO_Type#Cam_600Seg:
                    _cam600SegRef := AsCam_600SegRef(axisDB);
                TO_Type#Cam_6kSeg:
                    _cam6kSegRef := AsCam_6kSegRef(axisDB);
            END_CASE;
        END_METHOD

        /// Detaches the current assigned technology object from this instance.
        METHOD PUBLIC OVERRIDE Detach : BOOL
            CASE _resolvedType OF
                TO_Type#Cam:
                    _camRef := NULL;
                TO_Type#Cam_10k:
                    _cam10kRef := NULL;
                TO_Type#Cam_600Seg:
                    _cam600SegRef := NULL;
                TO_Type#Cam_6kSeg:
                    _cam6kSegRef := NULL;
            END_CASE;
            SUPER.Detach();
            Detach := this.IsAttached();
        END_METHOD

        /// With method GetCamRef, you get the reference of the attached cam (standard cam size with 1k points and 50 segments).
        METHOD PUBLIC GetCamRef : REF_TO TO_CAM
            IF this.GetType() = TO_Type#Cam THEN
                GetCamRef := _camRef;
            ELSE
                 GetCamRef := NULL;
            END_IF;
        END_METHOD

        /// With method GetCam10KRef, you get the reference of the attached cam (variant with 10k points).
        METHOD PUBLIC GetCam10KRef : REF_TO TO_CAM_10K
            IF this.GetType() = TO_Type#Cam_10k THEN
                GetCam10KRef := _cam10kRef;
            ELSE
                GetCam10KRef := NULL;
            END_IF;
        END_METHOD

        /// With method GetCam600SegRef, you get the reference of the attached cam (variant with 600 segments).
        METHOD PUBLIC GetCam600SegRef : REF_TO TO_Cam_600Seg
            IF this.GetType() = TO_Type#Cam_600Seg THEN
                GetCam600SegRef := _cam600SegRef;
            ELSE
                GetCam600SegRef := NULL;
            END_IF;
        END_METHOD

        /// With method GetCam6kSegRef, you get the reference of the attached cam (variant with 6k segments).
        METHOD PUBLIC GetCam6kSegRef : REF_TO TO_Cam_6kSeg
            IF this.GetType() = TO_Type#Cam_6kSeg THEN
                GetCam6kSegRef := _cam6kSegRef;
            ELSE
                GetCam6kSegRef := NULL;
            END_IF;
        END_METHOD

        /// With the method Interpolate, you interpolate a cam. The interpolation closes the gaps between the defined interpolation points and segments of the cam.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD PUBLIC Interpolate : ICommand
            Interpolate := interpolateCamCmd.Start(_camBaseRef);
        END_METHOD

        /// With the method GetLeadingValue, you read the leading value that is defined for a following value from a cam.
        /// Returns an object which contains the getter functions to read the status and value of the asynchronous reading operation.
        METHOD PUBLIC GetLeadingValue : ICamValue
            VAR_INPUT
                /// Following value for which the leading value is read.
                followingValue : LREAL;
                /// Approximation value for the searched for leading value.
                /// If the following value is used multiple times in the cam, it can be used to limit the searched leading value.
                approachLeadingValue : LREAL;
                /// Approach direction for the sought leading value.
                approachDirection : ApproachDirection := ApproachDirection#NEAREST_VALUE;
                /// Offset of the leading values of the cam (data from the cam technology object is not being altered).
                masterOffset : LREAL;
                /// Offset of the following values of the cam (data from the cam technology object is not being altered).
                slaveOffset : LREAL;
                /// Scaling of the leading values of the cam (data from the cam technology object is not being altered).
                /// Value 0.0 is not permitted
                masterScaling : LREAL := LREAL#1.0;
                /// Scaling of the following values of the cam (data from the cam technology object is not being altered).
                /// Value 0.0 is not permitted
                slaveScaling : LREAL := LREAL#1.0;
            END_VAR

            getCamLeadingValueCmd.Start(
                camRef := _camBaseRef,
                followingValue := followingValue,
                approachLeadingValue := approachLeadingValue,
                approachDirection := approachDirection,
                masterOffset := masterOffset,
                slaveOffset := slaveOffset,
                masterScaling := masterScaling,
                slaveScaling := slaveScaling
            );

            // Trick: execute it several times in the same cycle and the leading value will be available in advance.
            // It becomes a synchronous function.
            getCamLeadingValueCmd.ExecuteUntilDone();

            // set return values
            camLeadingValue.setErrorID := getCamLeadingValueCmd.ErrorID();
            camLeadingValue.setValid :=  getCamLeadingValueCmd.Done();
            camLeadingValue.setValue := getCamLeadingValueCmd.LeadingValue;

            GetLeadingValue := camLeadingValue;
        END_METHOD

        /// You use the method CopyData to copy calculated cam elements from an array of points and an array of segments to the technology object of the cam. 
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD PUBLIC CopyData : ICommand
            VAR_INPUT
                /// Index of the start point of the points to be copied in the cam.
                /// Permitted values for TO_Cam: 1 ≤ StartPointCam ≤ 1000
                /// Permitted values for TO_Cam_600Seg, TO_Cam_6kSeg: 1 ≤ StartPointCam ≤ 50
                /// Permitted values for TO_Cam_10k: 1 ≤ StartPointCam ≤ 10 000
                startPointCam : DINT := DINT#1;
                /// Index of the start segment of the segments to be copied in the cam.
                /// Permitted values TO_Cam, TO_Cam_10k: 1 ≤ StartSegmentCam ≤ 50
                /// Permitted values TO_Cam_600Seg: 1 ≤ StartSegmentCam ≤ 600
                /// Permitted values TO_Cam_6kSeg: 1 ≤ StartSegmentCam ≤ 6000
                startSegmentCam : DINT := DINT#1;
                /// Index of the start point to be copied from ArrayOfPoints.
                /// Permitted values: Lower boundary of ArrayOfPoints ≤ StartPointArray ≤ higher boundary of ArrayOfPoints
                startPointArray: DINT := DINT#1; 
                /// Index of the start segment to be copied from ArrayOfSegments
                /// Permitted values: Lower boundary of ArrayOfSegments ≤ StartSegmentArray ≤ higher boundary of ArrayOfSegments
                startSegmentArray : DINT := DINT#1;
                ///  Number of points to be copied from ArrayOfPoints
                /// Permitted values for TO_Cam: NumberOfPoints ≤ number of points from ArrayOfPoints and 0 ≤ NumberOfPoints ≤ 1 001 - StartPointCam
                /// Permitted values for TO_Cam_600Seg, TO_Cam_6kSeg: NumberOfPoints ≤ number of points from ArrayOfPoints and 0 ≤ NumberOfPoints ≤ 51 - StartPointCam
                /// Permitted values for TO_Cam_10k: NumberOfPoints ≤ number of points from ArrayOfPoints and 0 ≤ NumberOfPoints ≤ 10 001 - StartPointCam
                numberOfPoints : DINT;
                /// Number of segments to be copied
                /// Permitted values for TO_Cam, TO_Cam_10k: NumberOfSegments ≤ number of segments in the ArrayOfSegments and 0 ≤ NumberOfSegments ≤ 51 - StartSegmentCam
                /// Permitted values for TO_Cam, TO_Cam_600Seg: NumberOfSegments ≤ number of segments in the ArrayOfSegments and 0 ≤ NumberOfSegments ≤ 601 - StartSegmentCam
                /// Permitted values for TO_Cam, TO_Cam_6kSeg: NumberOfSegments ≤ number of segments in the ArrayOfSegments and 0 ≤ NumberOfSegments ≤ 6001 - StartSegmentCam
                numberOfSegments : DINT;
                // Mode for copying data to a cam.
                mode : CopyCamDataMode := CopyCamDataMode#SET_EXISTING_INVALID;
            END_VAR

            VAR_IN_OUT
                /// Array of points for the copy operation.
                points : ARRAY[*] OF TO_Cam_Struct_PointData;
                /// Array of segments for the copy operation.
                segments : ARRAY[*] OF TO_Cam_Struct_SegmentData;
            END_VAR

            CopyData := copyCamDataCmd.Start(
                camRef := _camBaseRef,
                mode := mode,
                startPointCam := startPointCam,
                startSegmentCam := startSegmentCam,
                startPointArray := startPointArray,
                startSegmentArray := startSegmentArray,
                numberOfPoints := numberOfPoints,
                numberOfSegments := numberOfSegments,
                points := points,
                segments := segments
            );
            END_METHOD

        /// With the method GetFollowingValue, you read the following value aswell as the first and second derivative of the following value for a leading value from a cam.
        /// Returns an object which contains the getter functions to read the values of the asynchronous reading operation.
        METHOD PUBLIC GetFollowingValue : ICamFollowingValue
            VAR_INPUT
                /// Leading value for which the following value is read.
                leadingValue : LREAL;
                // Offset of the leading values of the cam (data from the cam technology object is not being altered).
                masterOffset : LREAL;
                // Offset of the following values of the cam (data from the cam technology object is not being altered).
                slaveOffset : LREAL;
                // Scaling of the leading values of the cam (data from the cam technology object is not being altered).
                masterScaling : LREAL := LREAL#1.0;
                // Scaling of the following values of the cam (data from the cam technology object is not being altered).
                slaveScaling : LREAL := LREAL#1.0;
                /// Mode for reading following values from a cam.
                applicationMode: CamValueApplicationMode := CamValueApplicationMode#UP_TO_SECOND_DERIVATIVE;
            END_VAR

            getCamFollowingValueCyclic(
                Cam := _camBaseRef^,
                Enable := TRUE,
                LeadingValue := leadingValue,
                MasterOffset := masterOffset,
                SlaveOffset := slaveOffset,
                MasterScaling := masterScaling,
                SlaveScaling := slaveScaling,
                ApplicationMode := applicationMode,
                Valid => camFollowingValue.setValid,
                Value => camFollowingValue.setValue,
                FirstDerivative => camFollowingValue.setFirstDerivative,
                SecondDerivative => camFollowingValue.setSecondDerivative,
                ThirdDerivative => camFollowingValue.setThirdDerivative,
                ErrorID => camFollowingValue.setErrorID
            );

            GetFollowingValue := camFollowingValue;
        END_METHOD

        {inline}
        /// With the method GetStatus, you split the variable StatusWord of this cam into individual bits.
        METHOD PUBLIC GetStatus : CamStatus
            CASE this.GetType() OF
                TO_Type#Cam:
                   GetStatus := GetCamStatus(this.GetCamRef()^);
                TO_Type#Cam_10k:
                   GetStatus := GetCamStatus(this.GetCam10kRef()^);
                TO_Type#Cam_600Seg:
                   GetStatus := GetCamStatus(this.GetCam600SegRef()^);
                TO_Type#Cam_6kSeg:
                   GetStatus := GetCamStatus(this.GetCam6kSegRef()^);
            END_CASE;
        END_METHOD

        {inline}
        /// With the method GetErrors, you split the variable ErrorWord of this cam into individual bits.
        METHOD PUBLIC GetErrors : CamErrors
            CASE this.GetType() OF
                TO_Type#Cam:
                   GetErrors := GetCamErrors(this.GetCamRef()^);
                TO_Type#Cam_10k:
                   GetErrors := GetCamErrors(this.GetCam10kRef()^);
                TO_Type#Cam_600Seg:
                   GetErrors := GetCamErrors(this.GetCam600SegRef()^);
                TO_Type#Cam_6kSeg:
                   GetErrors := GetCamErrors(this.GetCam6kSegRef()^);
            END_CASE;
        END_METHOD

        {inline}
        /// With the method GetWarnings, you split the variable WarningWord of this cam into individual bits.
        METHOD PUBLIC GetWarnings : CamWarnings
            CASE this.GetType() OF
                TO_Type#Cam:
                   GetWarnings := GetCamWarnings(this.GetCamRef()^);
                TO_Type#Cam_10k:
                   GetWarnings := GetCamWarnings(this.GetCam10kRef()^);
                TO_Type#Cam_600Seg:
                   GetWarnings := GetCamWarnings(this.GetCam600SegRef()^);
                TO_Type#Cam_6kSeg:
                   GetWarnings := GetCamWarnings(this.GetCam6kSegRef()^);
            END_CASE;
        END_METHOD
    END_CLASS
END_NAMESPACE
