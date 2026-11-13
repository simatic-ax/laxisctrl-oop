# GetErrors

With the method `GetErrors`, you split the `ErrorWord` of this axis technology object into individual status bits.

## Underlying Mechanism

- Calls `GetAxisErrors(_speedAxisRef^)`.

## Effects

- Reads and evaluates the current error word without altering the state of the technology object.

## Parameters

| Name      | Type         | Section | Description                                                    |
| :-------- | :----------- | :------ | :------------------------------------------------------------- |
| GetErrors | `AxisErrors` | Return  | Structure containing individual boolean flags for axis errors. |
