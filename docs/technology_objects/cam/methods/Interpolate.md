# Interpolate

With the method `Interpolate`, you interpolate a cam. Interpolation computes mathematical transitions and closes gaps between defined interpolation points and segments in the cam.

## Underlying Instruction

- Native `MC_InterpolateCam` executed with rising edge on `Execute`.

## Effects

- Generates the continuous mathematical profile representing following value curves across all defined cam segments and points.
- Once completed (`Done := TRUE`), the cam is valid and ready for camming motion (`MC_CamIn`).
- Returns an `ICommand` handle to track asynchronous execution.

## Parameters

| Name        | Type       | Section | Description                                                                |
| :---------- | :--------- | :------ | :------------------------------------------------------------------------- |
| Interpolate | [`ICommand`](../../../common/commands/ICommand.md) | Return  | Returns the interface to monitor the result of the asynchronous operation. |
