# ResetAlarms

With the method `ResetAlarms`, you acknowledge all technology alarms that can be acknowledged in the user program. Acknowledgment also resets the "Error" and "Warning" bits in the technology object data block.

An acknowledgment of alarms in the drive is also possible without a pending error at the technology object.

## Underlying Instruction

- Native `MC_Reset` executed with parameter `Restart := FALSE`.

## Effects

- Acknowledges all acknowledgeable technology alarms on the attached technology object.
- Acknowledges alarms in the associated drive even if no alarm is pending at the technology object.
- Resets the `Error` and `Warning` bits in the technology object data block.

## Parameters

| Name        | Type                                               | Section | Description                                                                 |
| :---------- | :------------------------------------------------- | :------ | :-------------------------------------------------------------------------- |
| ResetAlarms | [`ICommand`](../../../common/commands/ICommand.md) | Return  | Returns the interface to monitor the result of the asynchronous operation.  |
