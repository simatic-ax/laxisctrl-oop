# IPosAxis

Inheritance: [`IObject`](../object/index.md) &rarr; [`IAxis`](../axis/index.md) &rarr; [`ISpeedAxis`](../speed_axis/index.md) &rarr; `IPosAxis`

Interface for positioning axis technology objects within `Simatic.Ax.LAxisCtrl.Oop`. It represents the contract for position-controlled motion axes (`TO_PositioningAxis`), providing absolute, relative, and superimposed positioning, homing with multiple encoder types and fixed stop detection, advanced incremental jogging, and leading axis reference export.

## Methods

### Inherited from `IObject`

See [`IObject`](../object/index.md) for detailed descriptions.

| Name | Description |
| :--- | :---------- |
| [`ResetAlarms()`](../object/methods/ResetAlarms.md) | Acknowledges all acknowledgeable technology alarms on the attached axis and attached drive. Resets "Error" and "Warning" bits in the TO data block. |
| [`Restart()`](../object/methods/Restart.md) | Initiates reinitialization (restart) of the attached axis to apply updated configuration data. |
| [`GetType()`](../object/methods/GetType.md) | Returns the resolved type identifier (`TO_Type` enum from `Siemens.S7.MotionControl`) of the attached axis. |

### Inherited from `ISpeedAxis`

See [`ISpeedAxis`](../speed_axis/index.md) for detailed descriptions.

| Name | Description |
| :--- | :---------- |
| [`GetSpeedAxisRef()`](../speed_axis/methods/GetSpeedAxisRef.md) | Returns the reference to the underlying `TO_SpeedAxis` data block. |
| [`PowerOff()`](../speed_axis/methods/PowerOff.md) | Disables the technology object and stops the drive according to the specified `PowerOffMode`. |
| [`MoveVelocity()`](../speed_axis/methods/MoveVelocity.md) | Moves the axis at a constant setpoint velocity. |
| [`Halt()`](../speed_axis/methods/Halt.md) | Decelerates the axis to a standstill with the specified deceleration and jerk. |
| [`Stop()`](../speed_axis/methods/Stop.md) | Brakes the axis to standstill and locks the TO against new motion jobs until unlocked. |
| [`UnlockStop()`](../speed_axis/methods/UnlockStop.md) | Cancels the active stop lock on the technology object, permitting new motion jobs. |
| [`OpenBrake()`](../speed_axis/methods/OpenBrake.md) | Unconditionally opens the motor holding brake via drive control word 1 (STW1 bit 12). |
| [`CloseBrake()`](../speed_axis/methods/CloseBrake.md) | Unconditionally closes the motor holding brake via drive control word 1 (STW1 bit 12). |
| [`SetTorqueAdditive()`](../speed_axis/methods/SetTorqueAdditive.md) | Sets an additive torque or force for the assigned drive (via telegram 750). |
| [`ResetTorqueAdditive()`](../speed_axis/methods/ResetTorqueAdditive.md) | Resets additive torque/force transferred to the drive to zero. |
| [`SetTorqueRange()`](../speed_axis/methods/SetTorqueRange.md) | Sets upper and lower torque or force limits on the assigned drive (via telegram 750). |
| [`ResetTorqueRange()`](../speed_axis/methods/ResetTorqueRange.md) | Disables the configured torque/force range limits on the drive. |
| [`ResetTorqueLimit()`](../speed_axis/methods/ResetTorqueLimit.md) | Deactivates force/torque limiting on the assigned drive. |
| [`GetWarnings()`](../speed_axis/methods/GetWarnings.md) | Evaluates and splits the axis `WarningWord` into individual boolean flags. |
| [`GetErrors()`](../speed_axis/methods/GetErrors.md) | Evaluates and splits the axis `ErrorWord` into individual boolean flags. |
| [`GetStatus()`](../speed_axis/methods/GetStatus.md) | Evaluates and splits `StatusWord` and `StatusWord2` into individual boolean flags. |

### Inherited from `ILeadingAxis`

See [ILeadingAxis](../../common/ILeadingAxis.md) for detailed descriptions.

| Name | Description |
| :--- | :---------- |
| [`GetAxisRef()`](../../common/ILeadingAxis.md#method-details) | Returns the reference to the underlying native `TO_Axis` data block, serving as the master base reference for native motion control instructions. |

### Defined in `IPosAxis`

| Name | Description |
| :--- | :---------- |
| [`GetPositioningAxisRef()`](methods/GetPositioningAxisRef.md) | Returns the reference to the attached `TO_PositioningAxis` data block. |
| [`PowerOn()`](methods/PowerOn.md) | Enables the axis with selectable position control mode (`positionControlled`). |
| [`MoveAbsolute()`](methods/MoveAbsolute.md) | Moves the axis to an absolute position with configurable dynamics, buffer mode, and modulo direction. |
| [`MoveRelative()`](methods/MoveRelative.md) | Moves the axis relative to its start position with configurable dynamics and buffer mode. |
| [`MoveSuperimposed()`](methods/MoveSuperimposed.md) | Executes a relative positioning motion superimposed on top of an active basic motion. |
| [`HaltSuperimposed()`](methods/HaltSuperimposed.md) | Decelerates only the superimposed motion component to standstill without affecting the basic motion. |
| [`MoveJog()`](methods/MoveJog.md) | Moves the axis in jog mode, supporting continuous jogging, single increments, or resumed increments. |
| [`HomeAbsEncoder()`](methods/HomeAbsEncoder.md) | Homes an axis equipped with an absolute encoder or performs active homing on fixed stop. |
| [`HomeIncEncoder()`](methods/HomeIncEncoder.md) | Homes an axis equipped with an incremental encoder or performs active homing on fixed stop. |
| [`HomeDirect()`](methods/HomeDirect.md) | Directly sets or shifts the axis coordinate system without mechanical movement. |
| [`AbortPassiveHoming()`](methods/AbortPassiveHoming.md) | Aborts an active passive homing job. |
| [`SetTorqueLimit()`](methods/SetTorqueLimit.md) | Configures torque/force limiting or fixed stop detection with clamping status feedback. |
