# ICamInCommand

Inheritance: [`ICommand`](ICommand.md) &rarr; `ICamInCommand`

Interface for monitoring asynchronous cam synchronization operations initiated by `CamIn` on an advanced synchronous axis (`SyncAxisAdvanced`).

`ICamInCommand` extends [`ICommand`](ICommand.md) by providing the `EndOfProfile()` method to detect when a non-cyclic cam operation reaches the end of the defined cam curve.

## Example

```iec-st
VAR
    mySyncAxis : SyncAxisAdvanced;
    myMaster   : PosAxis;
    myCam      : Cam;
    myCamInCmd : ICamInCommand;
END_VAR

myCamInCmd := mySyncAxis.CamIn(
    leadingAxis := myMaster,
    cam := myCam,
    applicationMode := CamApplicationMode#ONCE
);

IF myCamInCmd.Busy() THEN
    IF myCamInCmd.EndOfProfile() THEN
        ; // Non-cyclic cam has reached the end of the profile
    END_IF;
END_IF;
```

## End of Profile Semantics and Command Freezing

- `EndOfProfile()`: In native `MC_CamIn`, `EndOfProfile` signals that a non-cyclic cam curve has reached its endpoint or that a cyclic cam has completed a period.
- **Important Lifecycle Note:** In accordance with the library's command model, `CamIn` considers its synchronization phase complete as soon as synchronous lock is achieved (`InSync = TRUE`), which immediately transitions the command to **`Done = TRUE`** and causes `Busy()` to become `FALSE`.
- Because the native MC instruction is only called while `IsBusy()` is `TRUE`, the underlying `MC_CamIn` is **no longer executed through this command handle once `Done = TRUE`**.
- As a consequence, if `EndOfProfile` occurs *after* the initial synchronization lock has already been established, calling `myCamInCmd.EndOfProfile()` will not receive further updates and will remain `FALSE`.
- To monitor profile completion and active synchronism continuously after synchronization has been established, evaluate the technology object status directly via `syncAxis.GetStatus()` or via the underlying technology object variables (e.g. `<TO_SynchronousAxis>.StatusSynchronizedMotion.InSync`).

## Methods

### Inherited from `ICommand`

| Name | Return Type | Description |
| :--- | :---------- | :---------- |
| `Busy()` | `BOOL` | Returns `TRUE` while cam synchronization is active or running. |
| `Done()` | `BOOL` | Returns `TRUE` when synchronization has been achieved or completed. |
| `Aborted()` | `BOOL` | Returns `TRUE` if camming was aborted by another synchronous or motion job. |
| `Error()` | `BOOL` | Returns `TRUE` if an error occurred during camming. |
| `ErrorID()` | `WORD` | Returns the error ID from the underlying motion control instruction. |

### Defined in `ICamInCommand`

| Name | Return Type | Description |
| :--- | :---------- | :---------- |
| `EndOfProfile()` | `BOOL` | Returns `TRUE` when the end of the cam profile has been reached. |
