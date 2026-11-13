# GetErrors

With the method `GetErrors`, you split the `ErrorWord` of this external encoder technology object into individual status bits.

## Underlying Mechanism

- Calls `GetExternalEncoderErrors(_externalEncoderRef^)`.

## Effects

- Reads and evaluates the current error word of the external encoder without altering its state.

## Parameters

| Name      | Type                    | Section | Description                                                      |
| :-------- | :---------------------- | :------ | :--------------------------------------------------------------- |
| GetErrors | `ExternalEncoderErrors` | Return  | Structure containing individual boolean flags for encoder errors.|
