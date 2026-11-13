# ICommand

Represents the status of an asynchronous motion command that may execute over multiple program cycles.

All asynchronous motion methods throughout the library return an interface implementing `ICommand` (such as `PowerOn`, `PowerOff`, `MoveVelocity`, `Halt`, `Stop`, `Restart`, `ResetAlarms`, etc.) or an extended command interface (such as [`IMoveCommand`](IMoveCommand.md), [`IHomeCommand`](IHomeCommand.md), or [`ICamInCommand`](ICamInCommand.md)).

## Example

```iec-st
VAR
    myPosAxis    : PosAxis;
    myMoveAbsCmd : IMoveCommand;
END_VAR

// Trigger command
myMoveAbsCmd := myPosAxis.MoveAbsolute(position := 100.0, velocity := 50.0);

// Periodically check status
IF NOT myMoveAbsCmd.Busy() THEN
    IF myMoveAbsCmd.Done() THEN
        ; // Command completed successfully
    ELSIF myMoveAbsCmd.Error() THEN
        ; // Command failed, evaluate myMoveAbsCmd.ErrorID()
    ELSIF myMoveAbsCmd.Aborted() THEN
        ; // Command was preempted or aborted by another command
    END_IF;
END_IF;
```

## Lifecycle and Exclusiveness

The lifecycle of an asynchronous command is monitored via boolean getters:

- `Busy()` returns `TRUE` while the operation is actively executing.
- Once completed, the command transitions to one of three mutually exclusive terminal states:
  - `Done()` &mdash; The requested operation has completed successfully.
  - `Aborted()` &mdash; The command was preempted or cancelled by another command while it was busy.
  - `Error()` &mdash; An error occurred during execution; detailed diagnostics can be obtained from `ErrorID()`.

### State Evaluation Recommendation

Because internal command evaluation updates state cyclically, evaluate non-busy states hierarchically:

```iec-st
IF NOT cmd.Busy() THEN
    IF cmd.Done() THEN
        ; // Command successfully completed
    ELSIF cmd.Error() THEN
        ; // Error occurred, check cmd.ErrorID()
    ELSIF cmd.Aborted() THEN
        ; // Command was aborted by another job
    END_IF;
ELSE
    ; // Operation in progress
END_IF;
```

> **Warning:** Do not evaluate `Busy()` and `Done()` independently in the same cycle with separate `IF` statements, as a command might complete between queries during the cycle.

### The Up-To-Dateness of Command State

In the OOP command architecture, queries to `Busy()`, `Done()`, `Aborted()`, `Error()`, and `ErrorID()` the underlying native PLCopen instruction is **only executed while the `Busy` output of the instruction returns `TRUE`**.

As soon as a command reaches its target state and flags completion, the internal state is **frozen** and the underlying instruction is no longer executed through that command handle:

#### Target State Mapping (`Done = TRUE`)

- **Positioning Operations** (`MoveAbsolute`, `MoveRelative`): `Done` becomes `TRUE` when the axis reaches the target position.
- **Continuous Velocity Operations** (`MoveVelocity`): `Done` is mapped to reaching the setpoint velocity (corresponds to `InVelocity` of native `MC_MoveVelocity`).
- **Synchronous Operations** (`GearInRelative`, `GearInAbsolute`, `GearInVelocity`, `CamIn`):
  - In native Motion Control, `MC_GearIn`, `MC_GearInPos`, `MC_GearInVelocity`, and `MC_CamIn` maintain active execution (`Busy = TRUE`) for the entire duration that the axis is coupled.
  - In this library, the synchronization commands define completion as reaching synchronous lock:
    - For `GearInRelative`: `Done()` becomes `TRUE` when both outputs `InGear` and `Busy` of the native MC instruction becomes `TRUE`
    - For `GearInAbsolute`, `GearInVelocity`, and `CamIn`: `Done()` becomes `TRUE` when both outputs `InSync` and `Busy` of the native MC instruction becomes `TRUE`
  - Consequently, once the slave axis is synchronized to the leading axis (`InGear` or `InSync`), the OOP command transitions to **`Done = TRUE`**.

#### Instruction Execution Stops

Once the `Done` output of an instruction becomes `TRUE`, subsequent calls to any method on that `ICommand` instance will **no longer invoke `Execute()` on the native instruction**.

#### Consequences for Subsequent Errors & Aborts

1. **Errors Occurring After Completion Cannot Be Fetched**:
   - Because the native instruction is no longer invoked once `Done` is flagged, **any errors or drive trips occurring while the axis is running continuously or synchronously cannot be detected via the command instance**.
   - If an axis moving at setpoint velocity trips, or if a synchronous slave loses synchronization (e.g. following error tolerance exceeded, communication breakdown to leading axis, or leading axis emergency stop), querying `cmd.Error()` on the finished `GearIn` or `MoveVelocity` command will still return `FALSE`, and `cmd.ErrorID()` remains `16#0000`.
2. **Commands Do Not Retroactively Abort**:
   - `Aborted()` can only become `TRUE` while the command is actively `Busy` (during the ramp-up or synchronization phase).
   - Once `Done = TRUE`:
     - Overriding a continuous velocity motion with another job does **not** set `MoveVelocity` to `Aborted`.
     - Desynchronizing a coupled axis via `GearOut`, `CamOut`, `Halt`, or `Stop` does **not** transition the original `GearIn` or `CamIn` command handle to `Aborted = TRUE`. It remains frozen with `Done = TRUE`.

#### How to Monitor Ongoing Motion and Synchronous Operation

Because command handles only supervise the *transition phase* until target velocity, position, or synchronism is established:

- **For continuous speed axes**: Monitor axis health and motion state using `axis.GetStatus()`, `axis.GetErrors()`, and `axis.GetWarnings()`.
- **For synchronous axes**: Once `cmd.Done()` confirms coupling (`InGear` / `InSync`), monitor the ongoing synchronous relationship and drive health using:
  - `syncAxis.GetStatus()` (decoding `StatusWord` and `StatusWord2` flags such as synchronous operation active).
  - `syncAxis.GetErrors()` and `syncAxis.GetWarnings()` to catch synchronism failures, tolerance violations, and drive faults.
  - The technology object data block directly (e.g., `<Axis>.StatusSynchronizedMotion.InSync`).

## Methods

| Name | Return Type | Description |
| :--- | :---------- | :---------- |
| `Busy()` | `BOOL` | Returns `TRUE` while the command is running. |
| `Done()` | `BOOL` | Returns `TRUE` when the command has completed successfully. |
| `Aborted()` | `BOOL` | Returns `TRUE` if the command was aborted by another command while busy. |
| `Error()` | `BOOL` | Returns `TRUE` if an error occurred while executing the command. |
| `ErrorID()` | `WORD` | Returns the error ID from the underlying motion control instruction. |
