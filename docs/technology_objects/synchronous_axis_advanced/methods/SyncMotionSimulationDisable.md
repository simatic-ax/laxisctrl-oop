# SyncMotionSimulationDisable

With the method `SyncMotionSimulationDisable`, you disable synchronous operation simulation on a following axis, returning to real motion output.

## Underlying Instruction

- Native `MC_SynchronizedMotionSimulation` executed with `Enable := FALSE`.

## Effects

- Disables simulation mode, restoring regular setpoint output processing for synchronous operation.
- Returns an `ICommand` handle to track completion.

## Parameters

| Name                        | Type       | Section | Description                                                                 |
| :-------------------------- | :--------- | :------ | :-------------------------------------------------------------------------- |
| SyncMotionSimulationDisable | [`ICommand`](../../../common/commands/ICommand.md) | Return  | Returns the interface to monitor the result of the asynchronous operation.  |
