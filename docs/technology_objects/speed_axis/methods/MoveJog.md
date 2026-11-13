# MoveJog

With the method `MoveJog`, you move an axis in jog mode. You define the dynamic behavior of the jogging motion with parameters `velocity`, `acceleration`, `deceleration`, and `jerk`.

## Underlying Instruction

- Native `MC_MoveJog` called directly in each cycle.

## Effects

- Moves the axis continuously in positive direction (`jogForward = TRUE`) or negative direction (`jogBackward = TRUE`).
- When both inputs are `FALSE`, the axis decelerates to standstill.
- Setting both `jogForward` and `jogBackward` to `TRUE` simultaneously results in an error.
- **Note**: Unlike commands returning `ICommand`, `MoveJog` is designed to be called cyclically in the user program, providing status directly via output parameters.

## Parameters

| Name           | Type    | Section | Description                                                                                                                                  |
| :------------- | :------ | :------ | :------------------------------------------------------------------------------------------------------------------------------------------- |
| jogForward     | `BOOL`  | Input   | Jog in positive direction (default: `FALSE`).                                                                                                |
| jogBackward    | `BOOL`  | Input   | Jog in negative direction (default: `FALSE`).                                                                                                |
| velocity       | `LREAL` | Input   | Velocity setpoint. Absolute value used when `< 0.0` (default: `100.0`).                                                                      |
| acceleration   | `LREAL` | Input   | Acceleration setpoint. Value used when `> 0.0`. Configured TO default used when `< 0.0`. Value `0.0` is not permitted (default: `-1.0`).     |
| deceleration   | `LREAL` | Input   | Deceleration setpoint. Value used when `> 0.0`. Configured TO default used when `< 0.0`. Value `0.0` is not permitted (default: `-1.0`).     |
| jerk           | `LREAL` | Input   | Jerk setpoint. Value used when `> 0.0`. Configured TO default used when `< 0.0`. Trapezoidal profile applied when `= 0.0` (default: `-1.0`). |
| inVelocity     | `BOOL`  | Output  | Indicates the axis has reached the velocity setpoint.                                                                                        |
| busy           | `BOOL`  | Output  | The jog job is currently active.                                                                                                             |
| commandAborted | `BOOL`  | Output  | The jog job was aborted by another motion command.                                                                                           |
| error          | `BOOL`  | Output  | Indicates an error occurred during jogging.                                                                                                  |
| errorID        | `WORD`  | Output  | Error identifier (refer to Siemens Native MC documentation).                                                                                 |
