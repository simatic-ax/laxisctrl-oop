# CloseBrake

With the method `CloseBrake`, you unconditionally close the motor holding brake.

## Underlying Instruction

- Native `MC_SetAxisSTW` executed with:
  - `STW1 := WORD#2#0000_0000_0000_0000`
  - `STW1BitMask := WORD#2#0001_0000_0000_0000` (Bit 12)

## Effects

- Clears bit 12 in drive control word 1 (STW1), instructing the drive to engage the holding brake.
- Returns an `ICommand` handle to monitor command completion.

## Parameters

| Name       | Type       | Section | Description                                                                |
| :--------- | :--------- | :------ | :------------------------------------------------------------------------- |
| CloseBrake | [`ICommand`](../../../common/commands/ICommand.md) | Return  | Returns the interface to monitor the result of the asynchronous operation. |
