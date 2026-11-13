# SetTorqueLimit

With the method `SetTorqueLimit`, you activate and assign parameters for force/torque limiting on the drive assigned to the technology object.

## Underlying Instruction

- Native `MC_TorqueLimiting` executed with:
  - `Enable := TRUE`
  - `Limit := limit`
  - `Mode := DINT#0` (standard torque limiting for SpeedAxis)

## Effects

- Limits the motor output torque or force to the specified `limit`.
- Sets output `inLimitation := TRUE` when the drive operates at or above the torque limitation threshold (default 90%).
- Remains active until deactivated by [`ResetTorqueLimit`](ResetTorqueLimit.md).

## Parameters

| Name           | Type    | Section | Description                                                                                    |
| :------------- | :------ | :------ | :--------------------------------------------------------------------------------------------- |
| limit          | `LREAL` | Input   | Torque or force limit. Permissible values: ±1.0E12 (default: `-1.0`).                          |
| inLimitation   | `BOOL`  | Output  | Indicates the drive operates at least at the threshold value (default 90%) of the limitation.  |
| SetTorqueLimit | `WORD`  | Return  | Returns the error ID if an error occurred, or `16#0000` on success.                            |
