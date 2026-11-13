# HomeIncEncoder

With the method `HomeIncEncoder`, you home the position of an external encoder with an incremental sensor on a mechanical reference mark.

## Underlying Instruction

- Native `MC_Home` executed with rising edge on `Execute`.

## Effects

- Synchronizes the external encoder actual coordinate with a reference mark.
- Sets the external encoder status to homed (`StatusWord.X5 (HomingDone)`).
- Returns an `IHomeCommand` handle providing access to `ReferenceMarkPosition()` in addition to standard `ICommand` methods.

## Parameters

| Name           | Type                                                             | Section | Description                                                                |
| :------------- | :--------------------------------------------------------------- | :------ | :------------------------------------------------------------------------- |
| position       | `LREAL`                                                          | Input   | Coordinate value applied according to selected mode.                       |
| mode           | [`HomingModeIncEncoder`](../../../enums/HomingModeIncEncoder.md) | Input   | Homing mode (default: `PASSIVE_WITH_POSITION_PARAMETER`).                  |
| HomeIncEncoder | [`IHomeCommand`](../../../common/commands/IHomeCommand.md)       | Return  | Returns the interface to monitor the result of the asynchronous operation. |
