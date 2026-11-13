# GetStatus

With the method `GetStatus`, you split the `StatusWord` of this external encoder technology object into individual status bits.

## Underlying Mechanism

- Calls `GetExternalEncoderStatus(_externalEncoderRef^)`.

## Effects

- Reads and evaluates the current status word of the external encoder without altering its state.

## Parameters

| Name      | Type                    | Section | Description                                                      |
| :-------- | :---------------------- | :------ | :--------------------------------------------------------------- |
| GetStatus | `ExternalEncoderStatus` | Return  | Structure containing individual boolean flags for encoder status.|
