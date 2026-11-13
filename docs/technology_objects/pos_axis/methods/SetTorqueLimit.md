# SetTorqueLimit

With the method `SetTorqueLimit`, you activate and assign parameters for force/torque limiting and fixed stop detection on the drive assigned to the positioning axis.

## Underlying Instruction

- Native `MC_TorqueLimiting` executed with:
  - `Enable := TRUE`
  - `Limit := limit`
  - `Mode := mode` (`TORQUE_LIMITING` or `FIXED_STOP_DETECTION`)

## Effects

- Limits the drive torque or force to `limit`.
- Sets output `inLimitation := TRUE` when the drive operates at or above the torque limitation threshold (default 90%).
- For `mode := FIXED_STOP_DETECTION`, sets output `inClamping := TRUE` when the fixed stop position is reached and clamping force is maintained.
- Remains active until deactivated by [`ResetTorqueLimit`](../../speed_axis/methods/ResetTorqueLimit.md).

## Parameters

| Name           | Type                                                                | Section | Description                                                                 |
| :------------- | :------------------------------------------------------------------ | :------ | :-------------------------------------------------------------------------- |
| mode           | [`TorqueLimitingMode`](../../../enums/shared/TorqueLimitingMode.md) | Input   | Mode: `TORQUE_LIMITING` (default) or `FIXED_STOP_DETECTION`.                |
| limit          | `LREAL`                                                             | Input   | Torque or force limit. Permissible values: -1.0E12 to 1.0E12 (default: -1). |
| inLimitation   | `BOOL`                                                              | Output  | Drive operates at or above the threshold value of torque limitation.        |
| inClamping     | `BOOL`                                                              | Output  | Indicates the drive is kept at the fixed stop clamping position.            |
| SetTorqueLimit | `WORD`                                                              | Return  | Returns the error ID if an error occurred, or `16#0000` on success.         |
