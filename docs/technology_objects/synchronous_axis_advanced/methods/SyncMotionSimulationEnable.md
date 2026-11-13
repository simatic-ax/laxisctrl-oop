# SyncMotionSimulationEnable

With the method `SyncMotionSimulationEnable`, you enable simulation of active synchronous operation on a following axis.

## Underlying Instruction

- Native `MC_SynchronizedMotionSimulation` executed with `Enable := TRUE`.

## Effects

- Places synchronous operation on the following axis into simulation mode.
- Synchronous calculations are executed, but setpoint outputs to the drive are suppressed or simulated.
- Returns an `ICommand` handle to track completion.

## Parameters

| Name                        | Type       | Section | Description                                                                 |
| :-------------------------- | :--------- | :------ | :-------------------------------------------------------------------------- |
| SyncMotionSimulationEnable  | [`ICommand`](../../../common/commands/ICommand.md) | Return  | Returns the interface to monitor the result of the asynchronous operation.  |
