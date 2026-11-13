# IMoveCommand

Inheritance: [`ICommand`](ICommand.md) &rarr; `IMoveCommand`

Interface for monitoring asynchronous motion control operations initiated by `MoveAbsolute` and `MoveRelative`.

`IMoveCommand` extends [`ICommand`](ICommand.md) according to PLCopen specifications by adding the `Active()` status method, which indicates whether the underlying function block currently has active control over the axis and is generating motion setpoints.

## Example

```iec-st
VAR
    myPosAxis    : PosAxis;
    myMoveAbsCmd : IMoveCommand;
END_VAR

myMoveAbsCmd := myPosAxis.MoveAbsolute(
    position := 150.0,
    velocity := 100.0,
    bufferMode := MoveBufferMode#APPEND_MOTION
);

// Check if motion setpoints are actively being generated
IF myMoveAbsCmd.Busy() THEN
    IF myMoveAbsCmd.Active() THEN
        ; // FB currently controls the axis motion setpoints
    ELSE
        ; // Job is waiting (e.g. buffered behind a previous move command)
    END_IF;
END_IF;
```

## Active State Semantics

- `Active() = TRUE`: The function block has active control over the axis; motion setpoints are currently being calculated and transmitted.
- `Active() = FALSE` with `Busy() = TRUE`: The command has been registered and is pending, but is currently waiting in the buffer because a preceding motion job has not yet completed.

## Methods

### Inherited from `ICommand`

| Name | Return Type | Description |
| :--- | :---------- | :---------- |
| `Busy()` | `BOOL` | Returns `TRUE` while the command is running or buffered. |
| `Done()` | `BOOL` | Returns `TRUE` when the target position has been reached. |
| `Aborted()` | `BOOL` | Returns `TRUE` if the motion was aborted by another job before reaching the target. |
| `Error()` | `BOOL` | Returns `TRUE` if an error occurred during execution. |
| `ErrorID()` | `WORD` | Returns the error ID from the underlying motion control instruction. |

### Defined in `IMoveCommand`

| Name | Return Type | Description |
| :--- | :---------- | :---------- |
| `Active()` | `BOOL` | Returns `TRUE` when the function block actively has control over the axis and is generating setpoints. |
