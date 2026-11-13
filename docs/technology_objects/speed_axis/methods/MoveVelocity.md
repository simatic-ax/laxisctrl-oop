# MoveVelocity

With the method `MoveVelocity`, you move an axis at a constant velocity/speed. You define the dynamic behavior of the motion using parameters `velocity`, `acceleration`, `deceleration`, and `jerk`.

## Underlying Instruction

- Native `MC_MoveVelocity` executed with rising edge on `Execute`.

## Effects

- Accelerates or decelerates the axis to the specified target velocity setpoint.
- The returned `ICommand` indicates `Done := TRUE` once the setpoint velocity is reached (`InVelocity AND Busy`).
- The motion continues at constant velocity until interrupted or aborted by another motion command.

## Parameters

| Name               | Type                                                | Section | Description                                                                                                             |
| :-----------       | :-------------------------------------------------- | :------ | :---------------------------------------------------------------------------------------------------------------------- |
| velocity           | `LREAL`                                             | Input   | Velocity setpoint for the motion (default: `100.0`). Value `0.0` permitted.                                             |
| acceleration       | `LREAL`                                             | Input   | Acceleration setpoint. Default TO configuration used when `< 0.0`.                                                      |
| deceleration       | `LREAL`                                             | Input   | Deceleration setpoint. Default TO configuration used when `< 0.0`.                                                      |
| jerk               | `LREAL`                                             | Input   | Jerk setpoint. Trapezoidal profile applied when `= 0.0`.                                                                |
| direction          | [`Direction`](../../../enums/shared/Direction.md)   | Input   | Direction of motion (default: `Direction#VELOCITY_SPECIFIED`).                                                          |
| positionControlled | `BOOL`                                              | Input   | `TRUE` = position-controlled (default); `FALSE` = non-position-controlled. This parameter is ignored for TO_SpeedAxis.  |
| MoveVelocity       | [`ICommand`](../../../common/commands/ICommand.md)  | Return  | Returns the interface to monitor the result of the asynchronous operation.                                              |
