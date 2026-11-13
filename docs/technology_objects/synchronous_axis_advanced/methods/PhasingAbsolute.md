# PhasingAbsolute

With the method `PhasingAbsolute`, you shift the effective leading value coordinate system to an absolute phase position relative to a following axis while synchronous motion is active.

## Underlying Instruction

- Native `MC_PhasingAbsolute` executed with rising edge on `Execute`.

## Effects

- Sets the absolute phase shift between leading and following axes to `phaseShift`.
- The phase compensation motion is overlaid onto the existing synchronous movement without decoupling.
- Returns an `ICommand` handle to track execution.

## Parameters

| Name             | Type                                                                        | Section | Description                                                                 |
| :--------------- | :-------------------------------------------------------------------------- | :------ | :-------------------------------------------------------------------------- |
| leadingAxis      | `ILeadingAxis`                                                              | Input   | Leading axis interface object providing `GetAxisRef()`.                     |
| phaseShift       | `LREAL`                                                                     | Input   | Absolute phase offset value to achieve.                                     |
| velocity         | `LREAL`                                                                     | Input   | Velocity setpoint for compensation motion. Default TO used when `< 0.0`.    |
| acceleration     | `LREAL`                                                                     | Input   | Acceleration setpoint. Default TO configuration used when `< 0.0`.          |
| deceleration     | `LREAL`                                                                     | Input   | Deceleration setpoint. Default TO configuration used when `< 0.0`.          |
| jerk             | `LREAL`                                                                     | Input   | Jerk setpoint. Trapezoidal profile applied when `= 0.0`.                    |
| profileReference | [`PhasingProfile`](../../../enums/shared/PhasingProfile.md)                 | Input   | Profile for phase shifting calculation.                                     |
| phasingDistance  | `LREAL`                                                                     | Input   | Leading axis travel distance during which phase shift is applied.           |
| startPosition    | `LREAL`                                                                     | Input   | Leading axis position at which phase shifting starts.                       |
| direction        | [`DirectionPhasingOffset`](../../../enums/shared/DirectionPhasingOffset.md) | Input   | Direction of leading value distance (default: `CURRENT`).                   |
| PhasingAbsolute  | [`ICommand`](../../../common/commands/ICommand.md)                          | Return  | Returns the interface to monitor the result of the asynchronous operation.  |
