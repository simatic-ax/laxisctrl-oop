# ISpeedAxis

Inheritance: [`IObject`](../object/index.md) &rarr; [`IAxis`](../axis/index.md) &rarr; `ISpeedAxis`

Interface for speed-controlled technology objects within `Simatic.Ax.LAxisCtrl.Oop`. It represents the contract for speed/velocity-controlled motion axes (`TO_SpeedAxis`), providing motion operations, brake control, torque limiting/ranges, and status diagnostics.

## Methods

### Inherited from `IObject`

See [`IObject`](../object/index.md) for detailed descriptions.

| Name | Description |
| :--- | :---------- |
| [`ResetAlarms()`](../object/methods/ResetAlarms.md) | Acknowledges all acknowledgeable technology alarms on the attached axis and attached drive. Resets "Error" and "Warning" bits in the TO data block. |
| [`Restart()`](../object/methods/Restart.md) | Initiates reinitialization (restart) of the attached axis to apply updated configuration data. |
| [`GetType()`](../object/methods/GetType.md) | Returns the resolved type identifier (`TO_Type` enum from `Siemens.S7.MotionControl`) of the attached axis. |

### Inherited from `IAxis`

See [`IAxis`](../axis/index.md) for detailed descriptions.

| Name | Description |
| :--- | :---------- |
| [`PowerOn()`](../axis/methods/PowerOn.md) | Enables the technology object and, if configured, powers on the associated drive in position-controlled mode. |

### Defined in `ISpeedAxis`

| Name | Description |
| :--- | :---------- |
| [`GetSpeedAxisRef()`](methods/GetSpeedAxisRef.md) | Returns the reference to the attached `TO_SpeedAxis` data block. |
| [`PowerOff()`](methods/PowerOff.md) | Disables the technology object and stops the drive according to the specified `PowerOffMode`. |
| [`MoveVelocity()`](methods/MoveVelocity.md) | Moves the axis at a constant setpoint velocity. |
| [`Halt()`](methods/Halt.md) | Decelerates the axis to a standstill with the specified deceleration and jerk. |
| [`Stop()`](methods/Stop.md) | Brakes the axis to standstill and locks the TO against new motion jobs until unlocked. |
| [`UnlockStop()`](methods/UnlockStop.md) | Cancels the active stop lock on the technology object, permitting new motion jobs. |
| [`OpenBrake()`](methods/OpenBrake.md) | Unconditionally opens the motor holding brake via drive control word 1 (STW1 bit 12). |
| [`CloseBrake()`](methods/CloseBrake.md) | Unconditionally closes the motor holding brake via drive control word 1 (STW1 bit 12). |
| [`MoveJog()`](methods/MoveJog.md) | Moves the axis in jog mode (continuous forward/backward) while called cyclically. |
| [`SetTorqueAdditive()`](methods/SetTorqueAdditive.md) | Sets an additive torque or force for the assigned drive (via telegram 750). |
| [`ResetTorqueAdditive()`](methods/ResetTorqueAdditive.md) | Resets additive torque/force transferred to the drive to zero. |
| [`SetTorqueRange()`](methods/SetTorqueRange.md) | Sets upper and lower torque or force limits on the assigned drive (via telegram 750). |
| [`ResetTorqueRange()`](methods/ResetTorqueRange.md) | Disables the configured torque/force range limits on the drive. |
| [`SetTorqueLimit()`](methods/SetTorqueLimit.md) | Activates and configures torque/force limiting on the assigned drive. |
| [`ResetTorqueLimit()`](methods/ResetTorqueLimit.md) | Deactivates torque/force limiting on the assigned drive. |
| [`GetWarnings()`](methods/GetWarnings.md) | Evaluates and splits the axis `WarningWord` into individual boolean flags. |
| [`GetErrors()`](methods/GetErrors.md) | Evaluates and splits the axis `ErrorWord` into individual boolean flags. |
| [`GetStatus()`](methods/GetStatus.md) | Evaluates and splits `StatusWord` and `StatusWord2` into individual boolean flags. |
