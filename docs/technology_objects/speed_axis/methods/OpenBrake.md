# OpenBrake

With the method `OpenBrake`, you unconditionally open the motor holding brake (e.g. for commissioning or service purposes when the axis is not enabled).

## Underlying Instruction

- Native `MC_SetAxisSTW` executed with:
  - `STW1 := WORD#2#0001_0000_0000_0000` (Bit 12)
  - `STW1BitMask := WORD#2#0001_0000_0000_0000`

## Effects

- Asserts bit 12 in drive control word 1 (STW1), signaling the drive to open the motor holding brake.
- Returns an `ICommand` handle to monitor command completion.

## Parameters

| Name      | Type       | Section | Description                                                                |
| :-------- | :--------- | :------ | :------------------------------------------------------------------------- |
| OpenBrake | [`ICommand`](../../../common/commands/ICommand.md) | Return  | Returns the interface to monitor the result of the asynchronous operation. |
