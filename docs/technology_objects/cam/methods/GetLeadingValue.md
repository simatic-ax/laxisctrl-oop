# GetLeadingValue

With the method `GetLeadingValue`, you read the leading (master) value that corresponds to a specified following (slave) value from a cam.

## Underlying Instruction and Mechanism

- Native `MC_GetCamLeadingValue`.
- The implementation calls `ExecuteUntilDone()` cyclically within the same execution cycle, turning this operation into an immediate synchronous lookup.

## Effects

- Computes and returns the leading position corresponding to `followingValue`.
- Returns an `ICamValue` interface providing `Valid()`, `Value()`, and `ErrorID()`.

## Parameters

| Name                 | Type                                                       | Section | Description                                                                 |
| :------------------- | :--------------------------------------------------------- | :------ | :-------------------------------------------------------------------------- |
| followingValue       | `LREAL`                                                    | Input   | Following value for which the leading value is searched.                    |
| approachLeadingValue | `LREAL`                                                    | Input   | Approximation value used to disambiguate non-unique following values.       |
| approachDirection    | [`ApproachDirection`](../../../enums/ApproachDirection.md) | Input   | Direction to search for leading value (default: `NEAREST_VALUE`).           |
| masterOffset         | `LREAL`                                                    | Input   | Offset added to leading values for the calculation.                         |
| slaveOffset          | `LREAL`                                                    | Input   | Offset added to following values for calculation.                           |
| masterScaling        | `LREAL`                                                    | Input   | Scaling factor for leading values (default: `1.0`). Value `0.0` prohibited. |
| slaveScaling         | `LREAL`                                                    | Input   | Scaling factor for following values (default: `1.0`). Prohibited: `0.0`.    |
| GetLeadingValue      | `ICamValue`                                                | Return  | Returns interface handle containing `Valid()`, `Value()`, and `ErrorID()`.  |
