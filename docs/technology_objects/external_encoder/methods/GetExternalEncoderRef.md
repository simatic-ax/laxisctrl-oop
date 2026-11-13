# GetExternalEncoderRef

With the method `GetExternalEncoderRef`, you get the reference to the attached external encoder technology object (`TO_ExternalEncoder`).

## Underlying Mechanism

- Returns the internal `_externalEncoderRef : REF_TO TO_ExternalEncoder`.

## Effects

- Grants direct access to the underlying native external encoder technology object data block without modifying its state.

## Parameters

| Name                  | Type                         | Section | Description                                                               |
| :-------------------- | :--------------------------- | :------ | :------------------------------------------------------------------------ |
| GetExternalEncoderRef | `REF_TO TO_ExternalEncoder`  | Return  | Returns the reference to the attached `TO_ExternalEncoder` data block.    |
