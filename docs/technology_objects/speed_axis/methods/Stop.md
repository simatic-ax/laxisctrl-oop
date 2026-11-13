# Stop

With the method `Stop`, you stop all movements of an axis and lock it against new motion jobs. The axis brakes to a standstill and remains switched on.

## Underlying Instruction

- Native `MC_Stop` executed with `Execute := TRUE`.

## Effects

- Brakes the axis to standstill in accordance with the specified `mode`, `deceleration`, and `jerk`.
- Locks the technology object: no other motion job can be started while `Stop` is active.
- To release the axis lock and permit new motion jobs, [`UnlockStop`](UnlockStop.md) must be called.

## Parameters

| Name              | Type                                               | Section | Description                                                                                                                                  |
| :---------------- | :------------------------------------------------- | :------ | :------------------------------------------------------------------------------------------------------------------------------------------- |
| deceleration      | `LREAL`                                            | Input   | Deceleration setpoint. Value used when `> 0.0`. Configured TO default used when `< 0.0`. Value `0.0` is not permitted (default: `-1.0`).     |
| jerk              | `LREAL`                                            | Input   | Jerk setpoint. Value used when `> 0.0`. Configured TO default used when `< 0.0`. Trapezoidal profile applied when `= 0.0` (default: `-1.0`). |
| mode              | [`StopMode`](../../../enums/StopMode.md)           | Input   | Specifies the stopping mode (default: `StopMode#EMERGENCY_STOP`).                                                                            |
| abortAcceleration | `BOOL`                                             | Input   | `FALSE` = reduces current acceleration with configured jerk before braking; `TRUE` = immediately starts deceleration.                        |
| Stop              | [`ICommand`](../../../common/commands/ICommand.md) | Return  | Returns the interface to monitor the result of the asynchronous operation.                                                                   |
