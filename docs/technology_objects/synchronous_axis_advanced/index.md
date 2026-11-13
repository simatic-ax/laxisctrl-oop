# ISyncAxisAdvanced

Inheritance: [`IObject`](../object/index.md) &rarr; [`IAxis`](../axis/index.md) &rarr; [`ISpeedAxis`](../speed_axis/index.md) &rarr; [`IPosAxis`](../pos_axis/index.md) &rarr; [`ISyncAxis`](../synchronous_axis/index.md) &rarr; `ISyncAxisAdvanced`

Interface for advanced synchronous axis technology objects within `Simatic.Ax.LAxisCtrl.Oop`. It represents the most capable axis contract, providing absolute and velocity gearing, desynchronization (`GearOut`, `CamOut`), cam synchronization (`CamIn`), synchronized motion simulation, relative and absolute phasing/offsetting, and additive leading value injection.

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
| [`PowerOff()`](../axis/methods/PowerOff.md) | Disables the technology object and switches off the associated drive using emergency stop deceleration. |

### Inherited from `ISpeedAxis`

See [`ISpeedAxis`](../speed_axis/index.md) for detailed descriptions.

| Name | Description |
| :--- | :---------- |
| [`GetSpeedAxisRef()`](../speed_axis/methods/GetSpeedAxisRef.md) | Returns the reference to the underlying `TO_SpeedAxis` data block. |
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

### Inherited from `IPosAxis`

See [`IPosAxis`](../pos_axis/index.md) for detailed descriptions.

| Name | Description |
| :--- | :---------- |
| [`GetPositioningAxisRef()`](../pos_axis/methods/GetPositioningAxisRef.md) | Returns the reference to the attached `TO_PositioningAxis` data block. |
| [`PowerOn()`](../pos_axis/methods/PowerOn.md) | Enables the axis with selectable position control mode (`positionControlled`). |
| [`MoveAbsolute()`](../pos_axis/methods/MoveAbsolute.md) | Moves the axis to an absolute position with configurable dynamics, buffer mode, and modulo direction. |
| [`MoveRelative()`](../pos_axis/methods/MoveRelative.md) | Moves the axis relative to its start position with configurable dynamics and buffer mode. |
| [`MoveSuperimposed()`](../pos_axis/methods/MoveSuperimposed.md) | Executes a relative positioning motion superimposed on top of an active basic motion. |
| [`HaltSuperimposed()`](../pos_axis/methods/HaltSuperimposed.md) | Decelerates only the superimposed motion component to standstill without affecting the basic motion. |
| [`MoveJog()`](../pos_axis/methods/MoveJog.md) | Moves the axis in jog mode, supporting continuous jogging, single increments, or resumed increments. |
| [`HomeAbsEncoder()`](../pos_axis/methods/HomeAbsEncoder.md) | Homes an axis equipped with an absolute encoder or performs active homing on fixed stop. |
| [`HomeIncEncoder()`](../pos_axis/methods/HomeIncEncoder.md) | Homes an axis equipped with an incremental encoder or performs active homing on fixed stop. |
| [`HomeDirect()`](../pos_axis/methods/HomeDirect.md) | Directly sets or shifts the axis coordinate system without mechanical movement. |
| [`AbortPassiveHoming()`](../pos_axis/methods/AbortPassiveHoming.md) | Aborts an active passive homing job. |
| [`SetTorqueLimit()`](../pos_axis/methods/SetTorqueLimit.md) | Configures torque/force limiting or fixed stop detection with clamping status feedback. |

### Inherited from `ISyncAxis`

See [`ISyncAxis`](../synchronous_axis/index.md) for detailed descriptions.

| Name | Description |
| :--- | :---------- |
| [`GetSynchronousAxisRef()`](../synchronous_axis/methods/GetSynchronousAxisRef.md) | Returns the reference to the attached `TO_SynchronousAxis` data block. |
| [`GearInRelative()`](../synchronous_axis/methods/GearInRelative.md) | Initiates relative electronic gear synchronization with a leading axis. |

### Defined in `ISyncAxisAdvanced`

| Name | Description |
| :--- | :---------- |
| [`GearInVelocity()`](methods/GearInVelocity.md) | Synchronizes following axis velocity to leading axis velocity by a gear ratio. |
| [`GearInAbsolute()`](methods/GearInAbsolute.md) | Synchronizes following axis to leading axis based on specified synchronous positions. |
| [`GearOut()`](methods/GearOut.md) | Terminates electronic gear synchronization and stops the following axis. |
| [`CamIn()`](methods/CamIn.md) | Initiates cam synchronization against a leading axis and a cam object. |
| [`CamOut()`](methods/CamOut.md) | Terminates cam synchronization and stops the following axis. |
| [`SyncMotionSimulationEnable()`](methods/SyncMotionSimulationEnable.md) | Enables simulation mode for active synchronous operation on the following axis. |
| [`SyncMotionSimulationDisable()`](methods/SyncMotionSimulationDisable.md) | Disables simulation mode for synchronous operation, returning to normal setpoint output. |
| [`PhasingRelative()`](methods/PhasingRelative.md) | Applies an incremental phase shift to the effective leading value coordinate. |
| [`PhasingAbsolute()`](methods/PhasingAbsolute.md) | Sets an absolute phase shift to the effective leading value coordinate. |
| [`OffsetRelative()`](methods/OffsetRelative.md) | Applies an incremental offset to the following axis during synchronous operation. |
| [`OffsetAbsolute()`](methods/OffsetAbsolute.md) | Sets an absolute offset to the following axis during synchronous operation. |
| [`SetLeadingValueAdditive()`](methods/SetLeadingValueAdditive.md) | Cyclically injects additive leading position, velocity, and acceleration values. |
| [`ResetLeadingValueAdditive()`](methods/ResetLeadingValueAdditive.md) | Deactivates additive leading value injection. |
