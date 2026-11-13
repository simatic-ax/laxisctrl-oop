# GetCam10KRef

With the method `GetCam10KRef`, you get the reference to the attached 10k-point cam technology object (`TO_Cam_10k`, supporting up to 10,000 points).

## Underlying Mechanism

- Checks if `GetType() = TO_Type#Cam_10k`. If matched, returns `_cam10kRef : REF_TO TO_Cam_10k`; otherwise returns `NULL`.

## Effects

- Grants direct access to the `TO_Cam_10k` data block without altering its state.

## Parameters

| Name         | Type                | Section | Description                                                                        |
| :----------- | :------------------ | :------ | :--------------------------------------------------------------------------------- |
| GetCam10KRef | `REF_TO TO_Cam_10k` | Return  | Returns reference to attached `TO_Cam_10k` block, or `NULL` if not a `TO_Cam_10k`. |
