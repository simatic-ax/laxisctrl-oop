# AbortPassiveHoming

With the method `AbortPassiveHoming`, you abort an active passive homing job on the technology object.

## Underlying Instruction

- Native `MC_Home` executed with `Mode := 9` (abort passive homing).

## Effects

- Cancels an in-progress passive homing operation.
- Does not modify the axis homed status or current coordinate values.

## Parameters

| Name               | Type       | Section | Description                                                                 |
| :----------------- | :--------- | :------ | :-------------------------------------------------------------------------- |
| AbortPassiveHoming | [`ICommand`](../../../common/commands/ICommand.md) | Return  | Returns the interface to monitor the result of the asynchronous operation.  |
