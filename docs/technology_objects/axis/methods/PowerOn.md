# PowerOn

With the method `PowerOn`, a technology object is enabled and, if configured, an associated drive is switched on in position-controlled mode.

## Underlying Instruction

- Native `MC_Power` executed with:
  - `Enable := TRUE`
  - `StartMode := DINT#1` (`positionControlled := TRUE`)
  - `StopMode := PowerOffMode#EMERGENCY_STOP`

## Effects

- Enables the technology object and powers on the connected drive.
- Enables position control on the axis.
- Prepares the axis to execute motion commands once power is confirmed.

## Parameters

| Name    | Type       | Section | Description                                                                 |
| :------ | :--------- | :------ | :-------------------------------------------------------------------------- |
| PowerOn | [`ICommand`](../../../common/commands/ICommand.md) | Return  | Returns the interface to monitor the result of the asynchronous operation.  |
