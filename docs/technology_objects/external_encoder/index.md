# IExtEncoder

Inheritance: [`IObject`](../object/index.md) &rarr; [`IAxis`](../axis/index.md) &rarr; `IExtEncoder`

Interface for external encoder technology objects within `Simatic.Ax.LAxisCtrl.Oop`. It represents the contract for measuring external positions via an external encoder technology object (`TO_ExternalEncoder`), providing homing operations, status decoding, and leading axis reference export to allow other axes to synchronize against it.

## Methods

### Inherited from `IObject`

See [`IObject`](../object/index.md) for detailed descriptions.

| Name | Description |
| :--- | :---------- |
| [`ResetAlarms()`](../object/methods/ResetAlarms.md) | Acknowledges all acknowledgeable technology alarms on the attached external encoder. Resets "Error" and "Warning" bits in the TO data block. |
| [`Restart()`](../object/methods/Restart.md) | Initiates reinitialization (restart) of the attached external encoder to apply updated configuration data. |
| [`GetType()`](../object/methods/GetType.md) | Returns the resolved type identifier (`TO_Type` enum from `Siemens.S7.MotionControl`) of the attached external encoder. |

### Inherited from `IAxis`

See [`IAxis`](../axis/index.md) for detailed descriptions.

| Name | Description |
| :--- | :---------- |
| [`PowerOn()`](../axis/methods/PowerOn.md) | Enables the external encoder technology object. |
| [`PowerOff()`](../axis/methods/PowerOff.md) | Disables the external encoder technology object. |

### Inherited from `ILeadingAxis`

See [ILeadingAxis](../../common/ILeadingAxis.md) for detailed descriptions.

| Name | Description |
| :--- | :---------- |
| [`GetAxisRef()`](../../common/ILeadingAxis.md#method-details) | Returns the reference to the underlying native `TO_Axis` data block, serving as the master base reference for native motion control instructions. |

### Defined in `IExtEncoder`

| Name | Description |
| :--- | :---------- |
| [`GetExternalEncoderRef()`](methods/GetExternalEncoderRef.md) | Returns the reference to the attached `TO_ExternalEncoder` data block. |
| [`HomeAbsEncoder()`](methods/HomeAbsEncoder.md) | Homes an external encoder equipped with an absolute sensor. |
| [`HomeIncEncoder()`](methods/HomeIncEncoder.md) | Homes an external encoder equipped with an incremental sensor. |
| [`HomeDirect()`](methods/HomeDirect.md) | Directly sets or shifts the external encoder coordinate system without movement. |
| [`AbortPassiveHoming()`](methods/AbortPassiveHoming.md) | Aborts an active passive homing job. |
| [`GetWarnings()`](methods/GetWarnings.md) | Evaluates and splits the encoder `WarningWord` into individual boolean flags. |
| [`GetErrors()`](methods/GetErrors.md) | Evaluates and splits the encoder `ErrorWord` into individual boolean flags. |
| [`GetStatus()`](methods/GetStatus.md) | Evaluates and splits the encoder `StatusWord` into individual boolean flags. |
