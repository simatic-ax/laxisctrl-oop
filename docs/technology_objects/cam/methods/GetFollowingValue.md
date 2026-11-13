# GetFollowingValue

With the method `GetFollowingValue`, you read the following (slave) value as well as its first and second derivatives for a specified leading (master) value from a cam.

## Underlying Instruction and Mechanism

- Native `MC_GetCamFollowingValueCyclic` executed synchronously in the current cycle with `Enable := TRUE`.

## Effects

- Reads the following value and optional derivatives (`FirstDerivative`, `SecondDerivative`) without altering the technology object.
- Returns an `ICamFollowingValue` interface handle.

## Parameters

| Name              | Type                                                                   | Section | Description                                                                 |
| :---------------- | :--------------------------------------------------------------------- | :------ | :-------------------------------------------------------------------------- |
| leadingValue      | `LREAL`                                                                | Input   | Leading value coordinate for which following data is queried.               |
| masterOffset      | `LREAL`                                                                | Input   | Offset applied to leading values for calculation.                           |
| slaveOffset       | `LREAL`                                                                | Input   | Offset applied to following values for calculation.                         |
| masterScaling     | `LREAL`                                                                | Input   | Scaling factor for leading values (default: `1.0`). Value `0.0` prohibited. |
| slaveScaling      | `LREAL`                                                                | Input   | Scaling factor for following values (default: `1.0`). Prohibited: `0.0`.    |
| applicationMode   | [`CamValueApplicationMode`](../../../enums/CamValueApplicationMode.md) | Input   | Mode defining calculation depth (default: `UP_TO_SECOND_DERIVATIVE`).       |
| GetFollowingValue | `ICamFollowingValue`                                                   | Return  | Returns interface handle containing evaluated value and derivatives.        |
