# GetWarnings

With the method `GetWarnings`, you split the `WarningWord` of this axis technology object into individual status bits.

## Underlying Mechanism

- Calls `GetAxisWarnings(_speedAxisRef^)`.

## Effects

- Reads and evaluates the current warning word without altering the state of the technology object.

## Parameters

| Name        | Type           | Section | Description                                                      |
| :---------- | :------------- | :------ | :--------------------------------------------------------------- |
| GetWarnings | `AxisWarnings` | Return  | Structure containing individual boolean flags for axis warnings. |
