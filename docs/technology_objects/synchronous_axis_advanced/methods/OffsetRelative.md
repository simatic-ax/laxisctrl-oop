# OffsetRelative

With the method `OffsetRelative`, you shift the following value relative to the current position of the following axis during synchronous operation.

## Underlying Instruction

- Native `MC_OffsetRelative` executed with rising edge on `Execute`.

## Effects

- Applies an incremental `offset` directly to the following axis setpoint coordinate during active synchronization.
- Overlay occurs without interrupting or decoupling the synchronous operation.
- Returns an `ICommand` handle to track execution.

## Parameters

| Name             | Type                                                                        | Section | Description                                                                 |
| :--------------- | :-------------------------------------------------------------------------- | :------ | :-------------------------------------------------------------------------- |
| offset           | `LREAL`                                                                     | Input   | Relative offset distance to apply to the following axis.                    |
| profileReference | [`OffsetProfile`](../../../enums/shared/OffsetProfile.md)                   | Input   | Profile for offset calculation (default: `LEADING_VALUE_DISTANCE`).         |
| offsetDistance   | `LREAL`                                                                     | Input   | Leading value distance over which offset is applied.                        |
| startPosition    | `LREAL`                                                                     | Input   | Leading value position at which offset execution begins.                    |
| direction        | [`DirectionPhasingOffset`](../../../enums/shared/DirectionPhasingOffset.md) | Input   | Direction of leading value distance (default: `CURRENT`).                   |
| OffsetRelative   | `ICommand`                                                                  | Return  | Returns the interface to monitor the result of the asynchronous operation.  |
