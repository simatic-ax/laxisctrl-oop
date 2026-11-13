# UnlockStop

With the method `UnlockStop`, you cancel an active stopping state on the technology object, releasing the axis to accept new motion jobs.

## Underlying Mechanism

- Calls `_stopCmd.Cancel()`, which sets `MC_Stop.Execute := FALSE` and executes the block.

## Effects

- Cancels the lock placed on the technology object by a prior call to [`Stop`](Stop.md).
- Allows new motion commands to be initiated once the stop command has reset.

## Parameters

| Name       | Type       | Section | Description                                                                |
| :--------- | :--------- | :------ | :------------------------------------------------------------------------- |
| UnlockStop | [`ICommand`](../../../common/commands/ICommand.md) | Return  | Returns the interface to monitor the result of the asynchronous operation. |
