# HomeIncEncoder

With the method `HomeIncEncoder`, you home the position of a technology object equipped with an incremental encoder on a mechanical reference mark or fixed stop.

## Underlying Instruction

- For standard homing modes: Native `MC_Home` executed with rising edge on `Execute`.
- For fixed stop homing modes (`ACTIVE_ON_FIXED_STOP`, `ACTIVE_ON_FIXED_STOP_MOVE_OUT_OF_CLAMPING`, `ACTIVE_ON_FIXED_STOP_MOVE_TO_TARGET_POSITION`): Coordinated execution through an internal `HomeOnFixedStopCommand` combining `MC_MoveVelocity`, `MC_TorqueLimiting`, and `MC_Home`.

## Effects

- Synchronizes the axis actual position value with the mechanical position mark once detected.
- Sets the technology object status to homed (`StatusWord.X5 (HomingDone)`).
- Returns an `IHomeCommand` handle providing access to `ReferenceMarkPosition()` in addition to standard `ICommand` methods.

## Parameters

| Name                    | Type                                                             | Section | Description                                                                |
| :---------------------- | :--------------------------------------------------------------- | :------ | :------------------------------------------------------------------------- |
| position                | `LREAL`                                                          | Input   | Homing position coordinate applied according to the chosen mode.           |
| mode                    | [`HomingModeIncEncoder`](../../../enums/HomingModeIncEncoder.md) | Input   | Homing mode (default: `PASSIVE_WITH_POSITION_PARAMETER`).                  |
| fixedStopTorqueLimit    | `LREAL`                                                          | Input   | Clamping torque limit for fixed-stop homing modes (default: `0.0`).        |
| fixedStopTargetPosition | `LREAL`                                                          | Input   | Target position for `ACTIVE_ON_FIXED_STOP_MOVE_TO_TARGET_POSITION` mode.   |
| HomeIncEncoder          | [`IHomeCommand`](../../../common/commands/IHomeCommand.md)       | Return  | Returns the interface to monitor the result of the asynchronous operation. |
