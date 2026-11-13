# MoveRelative

With the method `MoveRelative`, you move an axis relative to its position at the time the job begins. You define the dynamic behavior of the motion using parameters `velocity`, `acceleration`, `deceleration`, and `jerk`.

## Underlying Instruction

- Native `MC_MoveRelative` executed with rising edge on `Execute`.

## Effects

- Travels the specified relative `distance` from the starting position.
- Supports motion blending and queuing via `bufferMode` (`MoveBufferMode`).
- Returns an [`IMoveCommand`](../../../common/commands/IMoveCommand.md) handle which provides the `Active()` status in addition to standard `ICommand` methods.

## Parameters

| Name         | Type                                                 | Section | Description                                                                 |
| :----------- | :--------------------------------------------------- | :------ | :-------------------------------------------------------------------------- |
| distance     | `LREAL`                                              | Input   | Distance to travel (positive or negative).                                  |
| velocity     | `LREAL`                                              | Input   | Velocity setpoint. Default TO configuration used when `< 0.0`.              |
| acceleration | `LREAL`                                              | Input   | Acceleration setpoint. Default TO configuration used when `< 0.0`.          |
| deceleration | `LREAL`                                              | Input   | Deceleration setpoint. Default TO configuration used when `< 0.0`.          |
| jerk         | `LREAL`                                              | Input   | Jerk setpoint. Trapezoidal profile applied when `= 0.0`.                    |
| bufferMode   | [`MoveBufferMode`](../../../enums/MoveBufferMode.md) | Input   | Mode of motion transition (default: `MoveBufferMode#ABORT_MOTION`).         |
| MoveRelative | `IMoveCommand`                                       | Return  | Returns the interface to monitor the result of the asynchronous operation.  |
