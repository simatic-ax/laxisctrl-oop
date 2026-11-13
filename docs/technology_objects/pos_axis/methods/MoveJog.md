# MoveJog

With the method `MoveJog`, you move an axis in jog mode. In addition to continuous velocity jogging, positioning axes support incremental jogging and continuous increment resumption.

## Underlying Instruction and Mechanism

- **Continuous mode (`mode := JogMode#CONTINUOUS`)**: Delegates directly to native `MC_MoveJog`.
- **Incremental modes (`JogMode#INCREMENTAL`, `JogMode#CONTINUE_INCREMENT`)**: Managed via an internal state machine. Calculates relative distance targets and invokes `MoveRelative` internally. When a jog signal is released before reaching the target increment, `Halt` is issued to decelerate to standstill.

## Effects

- Moves the axis continuously or by discrete increments in positive (`jogForward`) or negative (`jogBackward`) directions.
- Setting both `jogForward` and `jogBackward` simultaneously raises `error := TRUE` with `errorID := 16#8007`.
- Selecting an invalid jog mode raises `error := TRUE` with `errorID := 16#8201`.
- Must be called cyclically in the user program.

## Parameters

| Name               | Type                                          | Section | Description                                                                 |
| :----------------- | :-------------------------------------------- | :------ | :-------------------------------------------------------------------------- |
| jogForward         | `BOOL`                                        | Input   | Jog in positive direction (default: `FALSE`).                               |
| jogBackward        | `BOOL`                                        | Input   | Jog in negative direction (default: `FALSE`).                               |
| velocity           | `LREAL`                                       | Input   | Velocity setpoint. Absolute value used when `< 0.0` (default: `100.0`).     |
| acceleration       | `LREAL`                                       | Input   | Acceleration setpoint. Default TO configuration used when `< 0.0`.          |
| deceleration       | `LREAL`                                       | Input   | Deceleration setpoint. Default TO configuration used when `< 0.0`.          |
| jerk               | `LREAL`                                       | Input   | Jerk setpoint. Trapezoidal profile applied when `= 0.0`.                    |
| positionControlled | `BOOL`                                        | Input   | `TRUE` = position-controlled (default); `FALSE` = non-position-controlled.  |
| increment          | `LREAL`                                       | Input   | Distance increment for incremental modes (default: `0.0`).                  |
| mode               | [`JogMode`](../../../enums/shared/JogMode.md) | Input   | Jog mode: `CONTINUOUS` (default), `INCREMENTAL`, or `CONTINUE_INCREMENT`.    |
| inVelocity         | `BOOL`                                        | Output  | Indicates the axis has reached the velocity setpoint.                       |
| busy               | `BOOL`                                        | Output  | The jog job is currently active.                                            |
| commandAborted     | `BOOL`                                        | Output  | The jog job was aborted by another motion command.                          |
| error              | `BOOL`                                        | Output  | Indicates an error occurred during jogging.                                 |
| errorID            | `WORD`                                        | Output  | Error identifier (refer to Siemens Native MC documentation).                |
