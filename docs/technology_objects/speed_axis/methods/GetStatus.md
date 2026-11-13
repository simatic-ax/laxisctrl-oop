# GetStatus

With the method `GetStatus`, you split the variables `StatusWord` and `StatusWord2` of this axis technology object into individual status bits.

## Underlying Mechanism

- Calls `GetAxisStatus(_speedAxisRef^)`.

## Effects

- Reads and evaluates the current status words without altering the state of the technology object.

## Parameters

| Name      | Type         | Section | Description                                                    |
| :-------- | :----------- | :------ | :------------------------------------------------------------- |
| GetStatus | `AxisStatus` | Return  | Structure containing individual boolean flags for axis status. |
