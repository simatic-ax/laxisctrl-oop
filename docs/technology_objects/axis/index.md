# IAxis

Inheritance: [`IObject`](../object/index.md) &rarr; `IAxis`

Base interface for all axis technology objects within `Simatic.Ax.LAxisCtrl.Oop`. It represents the foundational contract for any controllable motion axis. Derived interfaces include `ISpeedAxis`, `IPosAxis`, `ISyncAxis`, and `ISyncAxisAdvanced`.

## Methods

### Inherited from `IObject`

See [`IObject`](../object/index.md) for detailed descriptions.

| Name | Description |
| :--- | :---------- |
| [`ResetAlarms()`](../object/methods/ResetAlarms.md) | Acknowledges all acknowledgeable technology alarms on the attached axis and attached drive. Resets "Error" and "Warning" bits in the TO data block. |
| [`Restart()`](../object/methods/Restart.md) | Initiates reinitialization (restart) of the attached axis to apply updated configuration data. |
| [`GetType()`](../object/methods/GetType.md) | Returns the resolved type identifier (`TO_Type` enum from `Siemens.S7.MotionControl`) of the attached axis. |

### Defined in `IAxis`

| Name | Description |
| :--- | :---------- |
| [`PowerOn()`](methods/PowerOn.md) | Enables the technology object and, if configured, powers on the associated drive in position-controlled mode. |
| [`PowerOff()`](methods/PowerOff.md) | Disables the technology object and switches off the associated drive using emergency stop deceleration. |
