# IObject

Base interface for all motion technology objects within `Simatic.Ax.LAxisCtrl.Oop`.

All high-level technology objects (axes, external encoders, cams) implement `IObject` directly or via derived interfaces (`IAxis`, `ISpeedAxis`, `IPosAxis`, `ISyncAxis`, `ISyncAxisAdvanced`, `ICam`, `ICamBase`, `IExtEncoder`).

## Methods

| Name | Description |
| :--- | :---------- |
| [`ResetAlarms()`](methods/ResetAlarms.md) | Acknowledges all acknowledgeable technology alarms on the attached technology object and attached drive. Resets "Error" and "Warning" bits in the TO data block. |
| [`Restart()`](methods/Restart.md) | Initiates reinitialization (restart) of the attached technology object to apply updated configuration data. |
| [`GetType()`](methods/GetType.md) | Returns the resolved type identifier (`TO_Type` enum from `Siemens.S7.MotionControl`) of the attached technology object. |
