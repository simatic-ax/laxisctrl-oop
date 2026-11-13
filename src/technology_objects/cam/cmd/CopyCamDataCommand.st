USING Siemens.S7.MotionControl; 

NAMESPACE Simatic.Ax.LAxisCtrl.Oop
    CLASS INTERNAL CopyCamDataCommand EXTENDS ExecuteCommand
        VAR
            _copyCamData : MC_CopyCamData;
            _camRef : REF_TO TO_CamBase;

            _arrayOfPointsRef : REF_TO ARRAY[*] OF TO_Cam_Struct_PointData;
            _arrayOfSegmentsRef : REF_TO ARRAY[*] OF TO_Cam_Struct_SegmentData;
        END_VAR

        {inline}
        METHOD INTERNAL Start : ICommand
            VAR_INPUT
                camRef : REF_TO TO_CamBase;
                mode : DINT;
                startPointCam : DINT;
                startSegmentCam : DINT;
                startPointArray : DINT;
                startSegmentArray : DINT;
                numberOfPoints : DINT;
                numberOfSegments : DINT;
            END_VAR

            VAR_IN_OUT
                points : ARRAY[*] OF TO_Cam_Struct_PointData;
                segments : ARRAY[*] OF TO_Cam_Struct_SegmentData;
            END_VAR

            _camRef := camRef;
            _arrayOfPointsRef := AsCamPointArrayRef(points);
            _arrayOfSegmentsRef := AsCamSegmentArrayRef(segments);

            _copyCamData.Mode := mode;
            _copyCamData.StartPointCam := startPointCam;
            _copyCamData.StartSegmentCam := startSegmentCam;
            _copyCamData.StartPointArray := startPointArray;
            _copyCamData.StartSegmentArray := startSegmentArray;
            _copyCamData.NumberOfPoints := numberOfPoints;
            _copyCamData.NumberOfSegments := numberOfSegments;
            
            this.ExecuteWithRisingEdge();
            Start := THIS;
        END_METHOD

        {inline}
        METHOD PROTECTED OVERRIDE SetExecute
            VAR_INPUT
                execute : BOOL;
            END_VAR

            _copyCamData.Execute := execute;
        END_METHOD

        {inline}
        METHOD OVERRIDE Execute
            _copyCamData(
                Cam := _camRef^,
                Done => _done,
                Error => _error,
                ErrorID => _errorID,
                ArrayOfPoints := _arrayOfPointsRef^,
                ArrayOfSegments := _arrayOfSegmentsRef^
            );
        END_METHOD
    END_CLASS
END_NAMESPACE