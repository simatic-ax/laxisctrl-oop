# PowerOff

With the method `PowerOff`, a technology object is disabled and, if configured, an associated drive is switched off using emergency stop deceleration.

## Underlying Instruction

- Native `MC_Power` executed with:
  - `Enable := FALSE`
  - `StartMode := DINT#1` (`positionControlled := TRUE`)
  - `StopMode := PowerOffMode#EMERGENCY_STOP`

## Effects

- Decelerates the axis to standstill according to emergency stop configuration and disables the technology object.
- Removes drive enable and position control.
- Any active motion commands will be aborted.

## Parameters

| Name     | Type       | Section | Description |
| :------- | :--------- | :------ | :---------- |
| PowerOff | [`ICommand`](../../../common/commands/ICommand.md) | Return  | Returns the interface to monitor the result of the asynchronous operation.  |
