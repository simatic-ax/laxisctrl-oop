# GetCamRef

With the method `GetCamRef`, you get the reference to the attached standard cam technology object (`TO_Cam`, supporting up to 1,000 points and 50 segments).

## Underlying Mechanism

- Checks if `GetType() = TO_Type#Cam`. If matched, returns `_camRef : REF_TO TO_Cam`; otherwise returns `NULL`.

## Effects

- Grants direct access to the `TO_Cam` data block without altering its state.

## Parameters

| Name      | Type            | Section | Description                                                                     |
| :-------- | :-------------- | :------ | :------------------------------------------------------------------------------ |
| GetCamRef | `REF_TO TO_Cam` | Return  | Returns reference to attached `TO_Cam` data block, or `NULL` if not a `TO_Cam`. |



