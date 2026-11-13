# GearInAbsolute

With the method `GearInAbsolute`, you start an absolute gearing operation between a leading axis and a following axis based on specified synchronous positions.

## Underlying Instruction

- Native `MC_GearInPos` executed with rising edge on `Execute`.

## Effects

- Synchronizes the following axis to the leading axis such that `followingSyncPosition` coincides with `leadingSyncPosition`.
- Follows the selected synchronization profile (`syncProfileReference`).
- The returned `ICommand` indicates `Done := TRUE` once synchronous position lock is reached (`InSync AND Busy`).

## Parameters

| Name                  | Type                                                          | Section | Description                                                                 |
| :-------------------- | :------------------------------------------------------------ | :------ | :-------------------------------------------------------------------------- |
| leadingAxis           | `ILeadingAxis`                                                | Input   | Leading axis interface object providing `GetAxisRef()`.                     |
| ratioNumerator        | `DINT`                                                        | Input   | Gear ratio numerator. Value `0` prohibited (default: `1`).                  |
| ratioDenominator      | `DINT`                                                        | Input   | Gear ratio denominator. Range: `1` to `2147483647` (default: `1`).          |
| leadingSyncPosition   | `LREAL`                                                       | Input   | Synchronous position coordinate of leading axis.                            |
| followingSyncPosition | `LREAL`                                                       | Input   | Synchronous position coordinate of following axis.                          |
| syncProfileReference  | [`GearInProfile`](../../../enums/shared/GearInProfile.md)     | Input   | Profile for synchronization (default: `IN_ADVANCE_BY_LEADING_VALUE_DIST`).  |
| leadingStartDistance  | `LREAL`                                                       | Input   | Leading value distance for synchronization when using distance profile.     |
| velocity              | `LREAL`                                                       | Input   | Velocity setpoint for dynamics-based profile. Configured TO used if `< 0`.  |
| acceleration          | `LREAL`                                                       | Input   | Acceleration setpoint. Default TO configuration used when `< 0.0`.          |
| deceleration          | `LREAL`                                                       | Input   | Deceleration setpoint. Default TO configuration used when `< 0.0`.          |
| jerk                  | `LREAL`                                                       | Input   | Jerk setpoint. Trapezoidal profile applied when `= 0.0`.                    |
| syncDirection         | [`DirectionModulo`](../../../enums/shared/DirectionModulo.md) | Input   | Direction of synchronization for modulo axes (default: `SHORTEST_DISTANCE`).|
| GearInAbsolute        | [`ICommand`](../../../common/commands/ICommand.md)            | Return  | Returns the interface to monitor the result of the asynchronous operation.  |
