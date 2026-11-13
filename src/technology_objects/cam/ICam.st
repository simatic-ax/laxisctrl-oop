USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    INTERFACE ICam EXTENDS ICamBase
        /// With method GetCamRef, you get the reference of the attached cam (standard cam size with 1k points and 50 segments).
        METHOD GetCamRef : REF_TO TO_CAM END_METHOD
        /// With method GetCam10KRef, you get the reference of the attached cam (variant with 10k points).
        METHOD GetCam10KRef : REF_TO TO_CAM_10K END_METHOD
        /// With method GetCam600SegRef, you get the reference of the attached cam (variant with 600 segments).
        METHOD GetCam600SegRef : REF_TO TO_Cam_600Seg END_METHOD
        /// With method GetCam6kSegRef, you get the reference of the attached cam (variant with 6k segments).
        METHOD GetCam6kSegRef : REF_TO TO_Cam_6kSeg END_METHOD
        
        /// With the method Interpolate, you interpolate a cam. The interpolation closes the gaps between the defined interpolation points and segments of the cam.
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD Interpolate : ICommand END_METHOD

        /// With the method GetLeadingValue, you read the leading value that is defined for a following value from a cam.
        /// Returns an object which contains the getter functions to read the status and value of the asynchronous reading operation.
        METHOD GetLeadingValue : ICamValue
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
        END_METHOD

        /// With the method GetFollowingValue, you read the following value aswell as the first and second derivative of the following value for a leading value from a cam.
        /// Returns an object which contains the getter functions to read the values of the asynchronous reading operation.
        METHOD GetFollowingValue : ICamFollowingValue
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
        END_METHOD

        /// You use the method CopyData to copy calculated cam elements from an array of points and an array of segments to the technology object of the cam. 
        /// Returns an object which contains the getter functions to read the status of the asynchronous operation.
        METHOD CopyData : ICommand
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
        END_METHOD

        /// With the method GetStatus, you split the variable StatusWord of this cam into individual bits.
        METHOD GetStatus : CamStatus END_METHOD
        /// With the method GetErrors, you split the variable ErrorWord of this cam into individual bits.
        METHOD GetErrors : CamErrors END_METHOD
        /// With the method GetWarnings, you split the variable WarningWord of this cam into individual bits.
        METHOD GetWarnings : CamWarnings END_METHOD
    END_INTERFACE
END_NAMESPACE
