# SetLeadingValueAdditive

With the method `SetLeadingValueAdditive`, you specify an additive leading value cyclically in addition to the active leading value of a following axis. Changes take effect immediately without dynamic limiting.

## Underlying Instruction

- Native `MC_LeadingValueAdditive` executed with `Enable := TRUE`.

## Effects

- Overlays cyclical additive position, velocity, and acceleration values onto the effective leading value input.
- **Important**: Values take effect without considering the axis dynamic limits. Position differences must be provided iteratively to prevent step setpoint jumps.
- Remains active until deactivated by [`ResetLeadingValueAdditive`](ResetLeadingValueAdditive.md).

## Parameters

| Name                    | Type    | Section | Description                                                      |
| :---------------------- | :------ | :------ | :--------------------------------------------------------------- |
| position                | `LREAL` | Input   | Cyclical additive position value (iterative difference).         |
| velocity                | `LREAL` | Input   | Cyclical additive velocity value.                                |
| acceleration            | `LREAL` | Input   | Cyclical additive acceleration value.                            |
| SetLeadingValueAdditive | `WORD`  | Return  | Returns error ID if an error occurred, or `16#0000` on success.  |
