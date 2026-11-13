# HomeDirect

With the method `HomeDirect`, you directly set or shift the coordinate system of the technology object without mechanical homing motion.

## Underlying Instruction

- Native `MC_Home` executed with rising edge on `Execute`.

## Effects

- Sets the axis actual coordinate to the specified `position` value directly (absolute) or shifts the coordinate system by the specified offset (relative).
- Sets the technology object status to homed (`StatusWord.X5 (HomingDone)`).
- Returns an `IHomeCommand` handle providing access to `ReferenceMarkPosition()` in addition to standard `ICommand` methods.

## Parameters

| Name       | Type                                                       | Section | Description                                                                 |
| :--------- | :--------------------------------------------------------- | :------ | :-------------------------------------------------------------------------- |
| position   | `LREAL`                                                    | Input   | Coordinate value or offset applied to the technology object.                |
| mode       | [`HomingModeDirect`](../../../enums/HomingModeDirect.md)   | Input   | Direct homing mode (default: `ACTUAL_POSITION_ABSOLUTE`).                   |
| HomeDirect | [`IHomeCommand`](../../../common/commands/IHomeCommand.md) | Return  | Returns the interface to monitor the result of the asynchronous operation.  |
