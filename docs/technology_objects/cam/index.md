# ICam

Inheritance: [`IObject`](../object/index.md) &rarr; `ICamBase` &rarr; `ICam`

Interface for cam technology objects within `Simatic.Ax.LAxisCtrl.Oop`. It represents the contract for all cam variants (`TO_Cam`, `TO_Cam_10k`, `TO_Cam_600Seg`, `TO_Cam_6kSeg`), providing cam interpolation, runtime evaluation of leading/following values, programmatic point and segment data copying, and diagnostic status decoding.

## Methods

### Inherited from `IObject`

See [`IObject`](../object/index.md) for detailed descriptions.

| Name | Description |
| :--- | :---------- |
| [`ResetAlarms()`](../object/methods/ResetAlarms.md) | Acknowledges all acknowledgeable technology alarms on the attached cam. Resets "Error" and "Warning" bits in the TO data block. |
| [`Restart()`](../object/methods/Restart.md) | Initiates reinitialization (restart) of the attached cam to apply updated configuration data. |
| [`GetType()`](../object/methods/GetType.md) | Returns the resolved type identifier (`TO_Type` enum from `Siemens.S7.MotionControl`) of the attached cam. |

### Inherited from `ICamBase`

| Name | Description |
| :--- | :---------- |
| [`GetCamBaseRef()`](methods/GetCamBaseRef.md) | Returns the reference to the underlying base `TO_CamBase` data block. |

### Defined in `ICam`

| Name | Description |
| :--- | :---------- |
| [`GetCamRef()`](methods/GetCamRef.md) | Returns the reference to `TO_Cam` (1k points, 50 segments), or `NULL` if another variant. |
| [`GetCam10KRef()`](methods/GetCam10KRef.md) | Returns the reference to `TO_Cam_10k` (10k points), or `NULL` if another variant. |
| [`GetCam600SegRef()`](methods/GetCam600SegRef.md) | Returns the reference to `TO_Cam_600Seg` (600 segments), or `NULL` if another variant. |
| [`GetCam6kSegRef()`](methods/GetCam6kSegRef.md) | Returns the reference to `TO_Cam_6kSeg` (6k segments), or `NULL` if another variant. |
| [`Interpolate()`](methods/Interpolate.md) | Interpolates the cam, closing gaps between defined points and segments. |
| [`GetLeadingValue()`](methods/GetLeadingValue.md) | Synchronously reads the leading value for a specified following value. |
| [`GetFollowingValue()`](methods/GetFollowingValue.md) | Evaluates the following value and its derivatives for a specified leading value. |
| [`CopyData()`](methods/CopyData.md) | Programmatically copies points and segments into the cam data block. |
| [`GetStatus()`](methods/GetStatus.md) | Evaluates and splits the cam `StatusWord` into individual boolean flags. |
| [`GetErrors()`](methods/GetErrors.md) | Evaluates and splits the cam `ErrorWord` into individual boolean flags. |
| [`GetWarnings()`](methods/GetWarnings.md) | Evaluates and splits the cam `WarningWord` into individual boolean flags. |
