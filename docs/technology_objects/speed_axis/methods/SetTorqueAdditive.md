# SetTorqueAdditive

With the method `SetTorqueAdditive`, you specify an additive torque for the drive to which the technology object is assigned (transferred via telegram 750). With a linear motor, this specifies an additive force.

## Underlying Instruction

- Native `MC_TorqueAdditive` executed with `Enable := TRUE`.

## Effects

- Adds the specified torque or force setpoint value to the drive control value.
- Remains active until deactivated by [`ResetTorqueAdditive`](ResetTorqueAdditive.md).

## Parameters

| Name              | Type    | Section | Description                                                                |
| :---------------- | :------ | :------ | :------------------------------------------------------------------------- |
| value             | `LREAL` | Input   | Additive torque (rotary) or additive force (linear). Range: ±1.0E12.       |
| SetTorqueAdditive | `WORD`  | Return  | Returns the error ID if an error occurred, or `16#0000` on success.        |
