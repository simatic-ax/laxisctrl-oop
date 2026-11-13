# PowerOn

With the method `PowerOn`, a positioning or synchronous axis is enabled and, if configured, an associated drive is switched on. By default, position control is enabled.

## Underlying Instruction

- Native `MC_Power` executed with:
  - `Enable := TRUE`
  - `StartMode := 1` (when `positionControlled := TRUE`) or `0` (when `FALSE`)
  - `StopMode := PowerOffMode#EMERGENCY_STOP`

## Effects

- Enables the technology object and powers on the connected drive.
- Activates position control when `positionControlled := TRUE`.
- Prepares the axis to execute positioning or velocity motion commands once power is confirmed.

## Parameters

| Name               | Type       | Section | Description                                                                 |
| :----------------- | :--------- | :------ | :-------------------------------------------------------------------------- |
| positionControlled | `BOOL`     | Input   | `TRUE` = position-controlled (default); `FALSE` = non-position-controlled.  |
| PowerOn            | [`ICommand`](../../../common/commands/ICommand.md) | Return  | Returns the interface to monitor the result of the asynchronous operation.  |
