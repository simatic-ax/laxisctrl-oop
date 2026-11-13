# Halt

With the method `Halt`, you brake an axis until it comes to a standstill. You define the dynamic behavior of the braking operation with parameters `deceleration` and `jerk`.

## Underlying Instruction

- Native `MC_Halt` executed with rising edge on `Execute`.

## Effects

- Decelerates the axis to velocity `0.0`.
- Can be aborted by a subsequent motion job.
- The returned `ICommand` indicates `Done := TRUE` once the axis has come to a standstill.

## Parameters

| Name              | Type                                                   | Section | Description                                                                                                                                  |
| :---------------- | :----------------------------------------------------- | :------ | :------------------------------------------------------------------------------------------------------------------------------------------- |
| deceleration      | `LREAL`                                                | Input   | Deceleration setpoint. Value used when `> 0.0`. Configured TO default used when `< 0.0`. Value `0.0` is not permitted (default: `-1.0`).     |
| jerk              | `LREAL`                                                | Input   | Jerk setpoint. Value used when `> 0.0`. Configured TO default used when `< 0.0`. Trapezoidal profile applied when `= 0.0` (default: `-1.0`). |
| mode              | [`HaltMode`](../../../enums/shared/HaltMode.md)        | Input   | Specifies the mode to halt an axis (default: `HaltMode#ALL_AXIS_MOTION`).                                                                    |
| abortAcceleration | `BOOL`                                                 | Input   | `FALSE` = reduces current acceleration with configured jerk before braking; `TRUE` = immediately starts deceleration.                        |
| Halt              | [`ICommand`](../../../common/commands/ICommand.md)     | Return  | Returns the interface to monitor the result of the asynchronous operation.                                                                   |
