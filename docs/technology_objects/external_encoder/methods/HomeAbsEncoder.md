# HomeAbsEncoder

With the method `HomeAbsEncoder`, you home the position of an external encoder with an absolute sensor on a mechanical reference mark.

## Underlying Instruction

- Native `MC_Home` executed with rising edge on `Execute`.

## Effects

- Assigns the actual position coordinate in the external encoder to a known position mark.
- Sets the external encoder status to homed (`StatusWord.X5 (HomingDone)`).
- Returns an `IHomeCommand` handle providing access to `ReferenceMarkPosition()` in addition to standard `ICommand` methods.

## Parameters

| Name           | Type                                                             | Section | Description                                                                |
| :------------- | :--------------------------------------------------------------- | :------ | :------------------------------------------------------------------------- |
| position       | `LREAL`                                                          | Input   | Coordinate value applied according to selected mode.                       |
| mode           | [`HomingModeAbsEncoder`](../../../enums/HomingModeAbsEncoder.md) | Input   | Homing mode (default: `ADJUSTMENT_SENSOR_ABSOLUTE`).                       |
| HomeAbsEncoder | [`IHomeCommand`](../../../common/commands/IHomeCommand.md)       | Return  | Returns the interface to monitor the result of the asynchronous operation. |
