# ILeadingAxis

Interface representing a leading axis (master axis) for synchronous motion operations within `Simatic.Ax.LAxisCtrl.Oop`.

`ILeadingAxis` is a pure virtual role interface. It represents the capability of a technology object to provide its setpoint or actual position and velocity as a master value for synchronous operations.

## Architecture and Role

In Siemens Motion Control (S7-1500 and S7-1500T), synchronous operations—such as electronic gearing (`MC_GearIn`, `MC_GearInPos`, `MC_GearInVelocity`) or camming (`MC_CamIn`)—require a reference to a leading technology object (`master : TO_Axis`). Leading axis capable technology objects are from type `TO_ExternalEncoder`, `TO_PositioningAxis` and `TO_SynchronousAxis` natively.

Rather than forcing synchronous methods to accept only a specific concrete axis type, `ILeadingAxis` abstracts this capability. Any technology object that can act as a master implements `ILeadingAxis`:

- [`IPosAxis`](../technology_objects/pos_axis/index.md) / `PosAxis` (`TO_PositioningAxis`)
- [`ISyncAxis`](../technology_objects/synchronous_axis/index.md) / `SyncAxis` (`TO_SynchronousAxis`)
- [`ISyncAxisAdvanced`](../technology_objects/synchronous_axis_advanced/index.md) / `SyncAxisAdvanced` (`TO_SynchronousAxis`)
- [`IExtEncoder`](../technology_objects/external_encoder/index.md) / `ExtEncoder` (`TO_ExternalEncoder`)

## Methods

| Name | Return Type | Description |
| :--- | :---------- | :---------- |
| `GetAxisRef()` | `REF_TO TO_Axis` | Returns the reference to the underlying native `TO_Axis` data block, serving as the master base reference for native motion control instructions. |

### Method Details

#### `GetAxisRef()`

- **Returns**: A reference (`REF_TO TO_Axis`) to the attached technology object data block.
- **Usage**: Invoked internally by synchronous commands (e.g. `GearInCommand`, `CamInCommand`, `PhasingAbsoluteCommand`) to pass the native axis reference to the `master` input of the underlying Siemens instruction (`_gearIn.master := leadingAxis.GetAxisRef()^`).
- **Prerequisite**: The technology object must be attached (via `Attach()`) before `GetAxisRef()` is called; otherwise, the returned reference is `NULL`.
