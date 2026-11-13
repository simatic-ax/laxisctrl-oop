# GearInRelative

With the method `GearInRelative`, you start a relative gearing operation between a leading axis and a following axis. You can start the synchronous operation whether the leading axis is at a standstill or already in motion.

## Underlying Instruction

- Native `MC_GearIn` executed with rising edge on `Execute`.
- Synchronizes the following axis (`slave`) with `leadingAxis.GetAxisRef()` (`master`).

## Effects

- Starts velocity-ratio synchronization based on `ratioNumerator / ratioDenominator`.
- When the gear ratio synchronization is locked (`InGear AND Busy`), the returned `ICommand` indicates `Done := TRUE`.
- The following axis continues in synchronization until aborted or decoupled (e.g. by a motion command or gear out).

## Parameters

| Name             | Type                                               | Section | Description                                                                 |
| :--------------- | :------------------------------------------------- | :------ | :-------------------------------------------------------------------------- |
| leadingAxis      | `ILeadingAxis`                                     | Input   | Leading axis interface object providing `GetAxisRef()`.                     |
| ratioNumerator   | `DINT`                                             | Input   | Gear ratio numerator. Value `0` is prohibited (default: `1`).               |
| ratioDenominator | `DINT`                                             | Input   | Gear ratio denominator. Range: `1` to `2147483647` (default: `1`).          |
| acceleration     | `LREAL`                                            | Input   | Acceleration setpoint. Default TO configuration used when `< 0.0`.          |
| deceleration     | `LREAL`                                            | Input   | Deceleration setpoint. Default TO configuration used when `< 0.0`.          |
| jerk             | `LREAL`                                            | Input   | Jerk setpoint. Trapezoidal profile applied when `= 0.0`.                    |
| GearInRelative   | [`ICommand`](../../../common/commands/ICommand.md) | Return  | Returns the interface to monitor the result of the asynchronous operation.  |
