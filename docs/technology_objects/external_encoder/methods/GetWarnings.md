# GetWarnings

With the method `GetWarnings`, you split the `WarningWord` of this external encoder technology object into individual status bits.

## Underlying Mechanism

- Calls `GetExternalEncoderWarnings(_externalEncoderRef^)`.

## Effects

- Reads and evaluates the current warning word of the external encoder without altering its state.

## Parameters

| Name        | Type                      | Section | Description                                                        |
| :---------- | :------------------------ | :------ | :----------------------------------------------------------------- |
| GetWarnings | `ExternalEncoderWarnings` | Return  | Structure containing individual boolean flags for encoder warnings.|
