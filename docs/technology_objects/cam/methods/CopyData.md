# CopyData

With the method `CopyData`, you copy calculated cam elements from an array of interpolation points and an array of segments into the cam technology object data block.

## Underlying Instruction

- Native `MC_CopyCamData` executed with rising edge on `Execute`.

## Effects

- Overwrites or updates the specified range of points and segments in the cam data block.
- Upon completion, the cam usually requires [`Interpolate`](Interpolate.md) before it can be used for motion.
- Returns an `ICommand` handle to track asynchronous copying progress.

## Parameters

| Name              | Type                                                   | Section   | Description                                                                 |
| :---------------- | :----------------------------------------------------- | :-------- | :-------------------------------------------------------------------------- |
| startPointCam     | `DINT`                                                 | Input     | Start point index in target cam (default: `1`).                             |
| startSegmentCam   | `DINT`                                                 | Input     | Start segment index in target cam (default: `1`).                           |
| startPointArray   | `DINT`                                                 | Input     | Start point index in source `points` array (default: `1`).                  |
| startSegmentArray | `DINT`                                                 | Input     | Start segment index in source `segments` array (default: `1`).              |
| numberOfPoints    | `DINT`                                                 | Input     | Number of points to copy from `points` array.                               |
| numberOfSegments  | `DINT`                                                 | Input     | Number of segments to copy from `segments` array.                           |
| mode              | [`CopyCamDataMode`](../../../enums/CopyCamDataMode.md) | Input     | Mode for copying data (default: `SET_EXISTING_INVALID`).                    |
| points            | `ARRAY[*] OF TO_Cam_Struct_Point`                      | In/Out    | Source array containing interpolation point data structures.                |
| segments          | `ARRAY[*] OF TO_Cam_Struct_Seg`                        | In/Out    | Source array containing segment data structures.                            |
| CopyData          | `ICommand`                                             | Return    | Returns the interface to monitor the result of the asynchronous operation.  |
