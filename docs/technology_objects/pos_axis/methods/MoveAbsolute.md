# MoveAbsolute

With the method `MoveAbsolute`, you move an axis to an absolute target position. You define the dynamic behavior of the motion using parameters `velocity`, `acceleration`, `deceleration`, and `jerk`.

## Underlying Instruction

- Native `MC_MoveAbsolute` executed with rising edge on `Execute`.

## Effects

- Moves the axis to the specified absolute position coordinate.
- For modulo axes, the approach direction is controlled by the `direction` parameter (`DirectionModulo`).
- Supports motion blending and queuing via `bufferMode` (`MoveBufferMode`).
- Returns an [`IMoveCommand`](../../../common/commands/IMoveCommand.md) handle which provides the `Active()` status in addition to standard `ICommand` methods.

## Parameters

| Name         | Type                                                          | Section | Description                                                                 |
| :----------- | :------------------------------------------------------------ | :------ | :-------------------------------------------------------------------------- |
| position     | `LREAL`                                                       | Input   | Absolute target position coordinate.                                        |
| velocity     | `LREAL`                                                       | Input   | Velocity setpoint. Default TO configuration used when `< 0.0`.              |
| acceleration | `LREAL`                                                       | Input   | Acceleration setpoint. Default TO configuration used when `< 0.0`.          |
| deceleration | `LREAL`                                                       | Input   | Deceleration setpoint. Default TO configuration used when `< 0.0`.          |
| jerk         | `LREAL`                                                       | Input   | Jerk setpoint. Trapezoidal profile applied when `= 0.0`.                    |
| direction    | [`DirectionModulo`](../../../enums/shared/DirectionModulo.md) | Input   | Direction of motion for modulo axes (default: `DirectionModulo#POSITIVE`).  |
| bufferMode   | [`MoveBufferMode`](../../../enums/MoveBufferMode.md)              | Input   | Mode of motion transition (default: `MoveBufferMode#ABORT_MOTION`).         |
| MoveAbsolute | [`IMoveCommand`](../../../common/commands/IMoveCommand.md)    | Return  | Returns the interface to monitor the result of the asynchronous operation.  |
