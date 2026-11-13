# GetCamBaseRef

With the method `GetCamBaseRef`, you get the reference to the attached base cam technology object (`TO_CamBase`).

## Underlying Mechanism

- Returns the internal `_camBaseRef : REF_TO TO_CamBase` stored in `CamBaseImpl`.

## Effects

- Grants direct access to the base `TO_CamBase` data block, serving as the common base type across all cam variants.

## Parameters

| Name          | Type                 | Section | Description                                                     |
| :------------ | :------------------- | :------ | :-------------------------------------------------------------- |
| GetCamBaseRef | `REF_TO TO_CamBase`  | Return  | Returns the reference to the attached `TO_CamBase` data block.  |
