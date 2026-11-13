# GetType

With the method `GetType`, you determine the specific type of the technology object that is attached.

## Underlying Mechanism

- Returns the internal `_resolvedType` property (`TO_Type`), which is resolved and stored during the `Attach` operation (e.g. from the provided `DB_ANY` or concrete `TO_*` reference).

## Effects

- Reads and returns the resolved `TO_Type` without modifying the state of the technology object.

## Parameters

| Name     | Type        | Section | Description                                                                 |
| :------- | :---------- | :------ | :-------------------------------------------------------------------------- |
| GetType  | `TO_Type`   | Return  | Returns the resolved type identifier (`TO_Type`) of the technology object.  |

### Return Values (`TO_Type`)

| Enum Value         | Description                                                |
| :----------------- | :--------------------------------------------------------- |
| `SpeedAxis`        | Speed axis technology object (`TO_SpeedAxis`).             |
| `PositioningAxis`  | Positioning axis technology object (`TO_PositioningAxis`). |
| `SynchronousAxis`  | Synchronous axis technology object (`TO_SynchronousAxis`). |
| `ExternalEncoder`  | External encoder technology object (`TO_ExternalEncoder`). |
| `Cam`              | Basic cam technology object (`TO_Cam`).                    |
| `Cam_10k`          | Cam with up to 10,000 points (`TO_Cam_10k`).               |
| `Cam_600Seg`       | Cam with up to 600 polynomial segments (`TO_Cam_600Seg`).  |
| `Cam_6kSeg`        | Cam with up to 6,000 polynomial segments (`TO_Cam_6kSeg`). |
| `Unknown`          | Default unassigned or unrecognized technology object type. |
