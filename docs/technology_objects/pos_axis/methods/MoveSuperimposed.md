# MoveSuperimposed

With the method `MoveSuperimposed`, you start a relative positioning motion that is superimposed on an already active basic motion without interrupting it.

## Underlying Instruction

- Native `MC_MoveSuperimposed` executed with rising edge on `Execute`.

## Effects

- Overlays a relative positioning displacement (`distance`) on top of the ongoing basic motion.
- Velocity of the axis is temporarily altered by up to `velocityDiff` to achieve the superimposed displacement.
- Does not interrupt or abort the active basic motion.
- Returns an `ICommand` handle to track completion of the superimposed motion component.

## Parameters

| Name             | Type       | Section | Description                                                                 |
| :--------------- | :--------- | :------ | :-------------------------------------------------------------------------- |
| distance         | `LREAL`    | Input   | Additional distance for overlapping positioning (positive or negative).     |
| velocityDiff     | `LREAL`    | Input   | Maximum velocity deviation relative to basic motion. Default used when < 0. |
| acceleration     | `LREAL`    | Input   | Acceleration setpoint. Default TO configuration used when `< 0.0`.          |
| deceleration     | `LREAL`    | Input   | Deceleration setpoint. Default TO configuration used when `< 0.0`.          |
| jerk             | `LREAL`    | Input   | Jerk setpoint. Trapezoidal profile applied when `= 0.0`.                    |
| MoveSuperimposed | [`ICommand`](../../../common/commands/ICommand.md) | Return  | Returns the interface to monitor the result of the asynchronous operation.  |
