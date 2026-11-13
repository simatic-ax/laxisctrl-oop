# HaltSuperimposed

With the method `HaltSuperimposed`, you decelerate an active superimposed motion operation on the axis to zero velocity. This instruction has no effect on the underlying basic motion of the axis.

## Underlying Instruction

- Native `MC_HaltSuperimposed` executed with rising edge on `Execute`.

## Effects

- Decelerates only the superimposed motion component to standstill without aborting or changing the underlying basic motion.
- Returns an `ICommand` handle indicating `Done := TRUE` when the superimposed velocity reaches zero.

## Parameters

| Name              | Type       | Section | Description                                                                                                                                  |
| :---------------- | :--------- | :------ | :------------------------------------------------------------------------------------------------------------------------------------------- |
| deceleration      | `LREAL`    | Input   | Deceleration setpoint. Value used when `> 0.0`. Configured TO default used when `< 0.0`. Value `0.0` is not permitted (default: `-1.0`).     |
| jerk              | `LREAL`    | Input   | Jerk setpoint. Value used when `> 0.0`. Configured TO default used when `< 0.0`. Trapezoidal profile applied when `= 0.0` (default: `-1.0`). |
| abortAcceleration | `BOOL`     | Input   | `FALSE` = reduces current superimposed acceleration using jerk before braking; `TRUE` = immediately starts deceleration.                     |
| HaltSuperimposed  | [`ICommand`](../../../common/commands/ICommand.md) | Return  | Returns the interface to monitor the result of the asynchronous operation.                                                                   |
