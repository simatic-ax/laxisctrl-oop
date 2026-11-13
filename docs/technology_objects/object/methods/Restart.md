# Restart

With the method `Restart`, you start reinitialization (restart) of technology objects. Upon restart of the technology object, the new configuration data are applied in the technology object data block.

## Underlying Instruction

- Native `MC_Reset` executed with parameter `Restart := TRUE`.

## Effects

- Reinitializes the technology object and applies new configuration values from the TO data block.
- While restart is in progress, the technology object is disabled and cannot execute motion commands.

## Parameters

| Name    | Type                                               | Section | Description                                                                 |
| :------ | :------------------------------------------------- | :------ | :-------------------------------------------------------------------------- |
| Restart | [`ICommand`](../../../common/commands/ICommand.md) | Return  | Returns the interface to monitor the result of the asynchronous operation.  |
