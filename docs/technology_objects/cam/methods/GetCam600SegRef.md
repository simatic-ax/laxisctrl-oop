# GetCam600SegRef

With the method `GetCam600SegRef`, you get the reference to the attached 600-segment cam technology object (`TO_Cam_600Seg`).

## Underlying Mechanism

- Checks if `GetType() = TO_Type#Cam_600Seg`. If matched, returns `_cam600SegRef : REF_TO TO_Cam_600Seg`; otherwise returns `NULL`.

## Effects

- Grants direct access to the `TO_Cam_600Seg` data block without altering its state.

## Parameters

| Name            | Type                   | Section | Description                                                               |
| :-------------- | :--------------------- | :------ | :------------------------------------------------------------------------ |
| GetCam600SegRef | `REF_TO TO_Cam_600Seg` | Return  | Returns reference to attached `TO_Cam_600Seg` block, or `NULL` if not it. |
