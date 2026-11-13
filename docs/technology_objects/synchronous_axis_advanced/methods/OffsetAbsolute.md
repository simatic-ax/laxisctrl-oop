# OffsetAbsolute

With the method `OffsetAbsolute`, you shift the following value to an absolute position offset on the following axis during synchronous operation.

## Underlying Instruction

- Native `MC_OffsetAbsolute` executed with rising edge on `Execute`.

## Effects

- Applies an absolute `offset` to the following axis setpoint coordinate during active synchronization.
- Overlay occurs without interrupting or decoupling the synchronous operation.
- Returns an `ICommand` handle to track execution.

## Parameters

| Name             | Type                                                                        | Section | Description                                                                 |
| :--------------- | :-------------------------------------------------------------------------- | :------ | :-------------------------------------------------------------------------- |
| offset           | `LREAL`                                                                     | Input   | Absolute offset coordinate to establish on the following axis.              |
| profileReference | [`OffsetProfile`](../../../enums/shared/OffsetProfile.md)                   | Input   | Profile for offset calculation (default: `LEADING_VALUE_DISTANCE`).         |
| offsetDistance   | `LREAL`                                                                     | Input   | Leading value distance over which offset is applied.                        |
| startPosition    | `LREAL`                                                                     | Input   | Leading value position at which offset execution begins.                    |
| direction        | [`DirectionPhasingOffset`](../../../enums/shared/DirectionPhasingOffset.md) | Input   | Direction of leading value distance (default: `CURRENT`).                   |
| OffsetAbsolute   | [`ICommand`](../../../common/commands/ICommand.md)                          | Return  | Returns the interface to monitor the result of the asynchronous operation.  |
