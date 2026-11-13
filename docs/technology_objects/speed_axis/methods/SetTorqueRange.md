# SetTorqueRange

With the method `SetTorqueRange`, you specify upper and lower torque or force limits to the drive assigned to the technology object (transferred via telegram 750).

## Underlying Instruction

- Native `MC_TorqueRange` executed with `Enable := TRUE`.

## Effects

- Limits the drive torque or force between the configured `lowerLimit` and `upperLimit`.
- Remains active until deactivated by [`ResetTorqueRange`](ResetTorqueRange.md).

## Parameters

| Name           | Type    | Section | Description                                                                |
| :------------- | :------ | :------ | :------------------------------------------------------------------------- |
| upperLimit     | `LREAL` | Input   | Upper torque or force limit (default: `1.0E12`).                           |
| lowerLimit     | `LREAL` | Input   | Lower torque or force limit (default: `-1.0E12`).                          |
| SetTorqueRange | `WORD`  | Return  | Returns the error ID if an error occurred, or `16#0000` on success.        |
