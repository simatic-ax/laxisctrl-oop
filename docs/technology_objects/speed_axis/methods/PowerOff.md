# PowerOff

With the method `PowerOff`, a technology object is disabled and, if necessary, an associated drive is switched off according to the specified deceleration mode.

## Underlying Instruction

- Native `MC_Power` executed with:
  - `Enable := FALSE`
  - `StartMode := DINT#1` (`positionControlled := TRUE`)
  - `StopMode := mode`

## Effects

- Decelerates the axis to standstill in accordance with the specified `mode` and disables the technology object.
- Removes drive enable and position control.
- Any active motion jobs on the axis will be aborted.

## Parameters

| Name     | Type                                                     | Section | Description                                                                |
| :------- | :------------------------------------------------------- | :------ | :------------------------------------------------------------------------- |
| mode     | [`PowerOffMode`](../../../enums/shared/PowerOffMode.md)  | Input   | Deceleration mode when powering off (default: `EMERGENCY_STOP`).           |
| PowerOff | [`ICommand`](../../../common/commands/ICommand.md)       | Return  | Returns the interface to monitor the result of the asynchronous operation. |
