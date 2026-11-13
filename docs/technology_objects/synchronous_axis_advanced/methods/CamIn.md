# CamIn

With the method `CamIn`, you start a camming operation between a leading axis and a following axis. The relationship of both axes is governed by the attached cam technology object.

## Underlying Instruction

- Native `MC_CamIn` executed with rising edge on `Execute`.
- Connects `followingAxis` with `leadingAxis.GetAxisRef()` and `cam.GetCamBaseRef()`.

## Effects

- Synchronizes the following axis to the leading axis according to the cam profile curve.
- Returns an [`ICamInCommand`](../../../common/commands/ICamInCommand.md) interface handle providing `EndOfProfile() : BOOL` in addition to standard `ICommand` methods.

## Parameters

| Name                 | Type                                                              | Section | Description                                                                 |
| :------------------- | :---------------------------------------------------------------- | :------ | :-------------------------------------------------------------------------- |
| leadingAxis          | `ILeadingAxis`                                                    | Input   | Leading axis interface object providing `GetAxisRef()`.                     |
| cam                  | `ICamBase`                                                        | Input   | Cam interface object providing `GetCamBaseRef()`.                           |
| leadingOffset        | `LREAL`                                                           | Input   | Offset applied to leading values of the cam.                                |
| followingOffset      | `LREAL`                                                           | Input   | Offset applied to following values of the cam.                              |
| leadingScaling       | `LREAL`                                                           | Input   | Scaling factor for leading values (default: `1.0`).                         |
| followingScaling     | `LREAL`                                                           | Input   | Scaling factor for following values (default: `1.0`).                       |
| leadingSyncPosition  | `LREAL`                                                           | Input   | Synchronous position coordinate of leading axis within the cam profile.     |
| syncProfileReference | [`CamInProfile`](../../../enums/shared/CamInProfile.md)           | Input   | Profile for synchronization (default: `IN_ADVANCE_BY_LEADING_VALUE_DIST`).  |
| leadingStartDistance | `LREAL`                                                           | Input   | Distance of the leading axis during synchronization.                        |
| velocity             | `LREAL`                                                           | Input   | Velocity setpoint for dynamics profile. Default TO used if `< 0.0`.         |
| acceleration         | `LREAL`                                                           | Input   | Acceleration setpoint. Default TO configuration used when `< 0.0`.          |
| deceleration         | `LREAL`                                                           | Input   | Deceleration setpoint. Default TO configuration used when `< 0.0`.          |
| jerk                 | `LREAL`                                                           | Input   | Jerk setpoint. Trapezoidal profile applied when `= 0.0`.                    |
| applicationMode      | [`CamApplicationMode`](../../../enums/shared/CamApplicationMode.md) | Input   | Application mode defining cyclic/non-cyclic cam engagement.                 |
| syncDirection        | [`DirectionModulo`](../../../enums/shared/DirectionModulo.md)     | Input   | Direction of synchronization for modulo axes (default: `SHORTEST_DISTANCE`).|
| CamIn                | [`ICamInCommand`](../../../common/commands/ICamInCommand.md)      | Return  | Returns the interface to monitor the result of the asynchronous operation.  |
