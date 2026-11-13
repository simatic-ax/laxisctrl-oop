# HomeDirect

With the method `HomeDirect`, you directly set or shift the coordinate system of the external encoder without mechanical homing motion.

## Underlying Instruction

- Native `MC_Home` executed with rising edge on `Execute`.

## Effects

- Directly sets the external encoder actual coordinate to `position` (absolute) or applies an offset (relative).
- Sets the external encoder status to homed (`StatusWord.X5 (HomingDone)`).
- Returns an `IHomeCommand` handle providing access to `ReferenceMarkPosition()` in addition to standard `ICommand` methods.

## Parameters

| Name       | Type                                                       | Section | Description                                                                |
| :--------- | :--------------------------------------------------------- | :------ | :------------------------------------------------------------------------- |
| position   | `LREAL`                                                    | Input   | Coordinate value or offset applied to the external encoder.                |
| mode       | [`HomingModeDirect`](../../../enums/HomingModeDirect.md)   | Input   | Direct homing mode (default: `ACTUAL_POSITION_ABSOLUTE`).                  |
| HomeDirect | [`IHomeCommand`](../../../common/commands/IHomeCommand.md) | Return  | Returns the interface to monitor the result of the asynchronous operation. |
