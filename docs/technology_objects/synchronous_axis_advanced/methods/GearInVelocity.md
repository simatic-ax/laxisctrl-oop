# GearInVelocity

With the method `GearInVelocity`, you start a velocity gearing operation between a leading axis and a following axis. The following axis is synchronized to the velocity of the leading axis according to the specified gear ratio.

## Underlying Instruction

- Native `MC_GearInVelocity` executed with rising edge on `Execute`.

## Effects

- Synchronizes the following axis to the velocity of the leading axis according to `ratioNumerator / ratioDenominator`.
- Synchronization can be performed with or without position control via `positionControlled`.
- The returned `ICommand` indicates `Done := TRUE` once velocity synchronization is achieved (`InSync AND Busy`).

## Parameters

| Name               | Type                                               | Section | Description                                                                 |
| :----------------- | :------------------------------------------------- | :------ | :-------------------------------------------------------------------------- |
| leadingAxis        | `ILeadingAxis`                                     | Input   | Leading axis interface object providing `GetAxisRef()`.                     |
| ratioNumerator     | `DINT`                                             | Input   | Gear ratio numerator. Value `0` prohibited (default: `1`).                  |
| ratioDenominator   | `DINT`                                             | Input   | Gear ratio denominator. Range: `1` to `2147483647` (default: `1`).          |
| acceleration       | `LREAL`                                            | Input   | Acceleration setpoint. Default TO configuration used when `< 0.0`.          |
| deceleration       | `LREAL`                                            | Input   | Deceleration setpoint. Default TO configuration used when `< 0.0`.          |
| jerk               | `LREAL`                                            | Input   | Jerk setpoint. Trapezoidal profile applied when `= 0.0`.                    |
| positionControlled | `BOOL`                                             | Input   | `TRUE` = position-controlled synchronization; `FALSE` = speed-controlled.   |
| GearInVelocity     | [`ICommand`](../../../common/commands/ICommand.md) | Return  | Returns the interface to monitor the result of the asynchronous operation.  |
