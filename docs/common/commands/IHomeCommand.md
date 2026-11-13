# IHomeCommand

Inheritance: [`ICommand`](ICommand.md) &rarr; `IHomeCommand`

Interface for monitoring asynchronous homing operations initiated on a positioning axis or external encoder (e.g., `HomeAbsEncoder`, `HomeIncEncoder`, or `HomeDirect`).

`IHomeCommand` extends [`ICommand`](ICommand.md) by providing the `ReferenceMarkPosition()` method to retrieve the exact mechanical reference mark coordinate captured upon completion of the homing procedure.

## Example

```iec-st
VAR
    myPosAxis   : PosAxis;
    myHomeCmd   : IHomeCommand;
    refPosition : LREAL;
END_VAR

myHomeCmd := myPosAxis.HomeDirect(
    mode := HomingModeDirect#ACTUAL_POSITION_ABSOLUTE,
    position := 0.0
);

IF NOT myHomeCmd.Busy() THEN
    IF myHomeCmd.Done() THEN
        // Retrieve the exact position at which homing occurred
        refPosition := myHomeCmd.ReferenceMarkPosition();
    ELSIF myHomeCmd.Error() THEN
        ; // Handle homing error via myHomeCmd.ErrorID()
    END_IF;
END_IF;
```

## Reference Mark Position Semantics

The value returned by `ReferenceMarkPosition()` is valid when `Done() = TRUE`:

- **Active Homing:** The homing mark position corresponds to the home position minus the configured home position offset.
- **Passive Homing:** The homing mark position corresponds directly to the configured home position.
- **Direct Homing:** Corresponds to the assigned actual coordinate value.

## Methods

### Inherited from `ICommand`

| Name | Return Type | Description |
| :--- | :---------- | :---------- |
| `Busy()` | `BOOL` | Returns `TRUE` while the homing operation is in progress. |
| `Done()` | `BOOL` | Returns `TRUE` when homing has finished successfully. |
| `Aborted()` | `BOOL` | Returns `TRUE` if the homing job was aborted by another motion command. |
| `Error()` | `BOOL` | Returns `TRUE` if the homing job failed or was rejected. |
| `ErrorID()` | `WORD` | Returns the error ID from the underlying motion control instruction. |

### Defined in `IHomeCommand`

| Name | Return Type | Description |
| :--- | :---------- | :---------- |
| `ReferenceMarkPosition()` | `LREAL` | Returns the position coordinate at which the technology object was homed (valid when `Done() = TRUE`). |
