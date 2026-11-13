# CamOut

With the method `CamOut`, you terminate a camming operation between a leading axis and a following axis. The following axis is desynchronized and decelerates to standstill.

## Underlying Instruction

- Native `MC_CamOut` executed with rising edge on `Execute`.

## Effects

- Decouples the following axis from cam synchronization.
- Decelerates the following axis to a standstill at the target `followingPosition` according to the selected desynchronization profile.
- Returns an `ICommand` handle to track completion of desynchronization.

## Parameters

| Name                 | Type                                                            | Section | Description                                                                 |
| :------------------- | :-------------------------------------------------------------- | :------ | :-------------------------------------------------------------------------- |
| followingPosition    | `LREAL`                                                         | Input   | Stop position of following axis.                                            |
| syncProfileReference | [`SyncOutProfile`](../../../enums/shared/SyncOutProfile.md)     | Input   | Profile for desynchronization (default: `LEADING_VALUE_DISTANCE`).          |
| leadingStopDistance  | `LREAL`                                                         | Input   | Leading value distance when using `LEADING_VALUE_DISTANCE` profile.         |
| deceleration         | `LREAL`                                                         | Input   | Deceleration setpoint. Default TO configuration used when `< 0.0`.          |
| jerk                 | `LREAL`                                                         | Input   | Jerk setpoint. Trapezoidal profile applied when `= 0.0`.                    |
| syncOutDirection     | [`DirectionSyncOut`](../../../enums/shared/DirectionSyncOut.md) | Input   | Direction of desynchronization for modulo axes (default: `CURRENT`).        |
| CamOut               | [`ICommand`](../../../common/commands/ICommand.md)              | Return  | Returns the interface to monitor the result of the asynchronous operation.  |
