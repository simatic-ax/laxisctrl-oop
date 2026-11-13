# GetCam6kSegRef

With the method `GetCam6kSegRef`, you get the reference to the attached 6,000-segment cam technology object (`TO_Cam_6kSeg`).

## Underlying Mechanism

- Checks if `GetType() = TO_Type#Cam_6kSeg`. If matched, returns `_cam6kSegRef : REF_TO TO_Cam_6kSeg`; otherwise returns `NULL`.

## Effects

- Grants direct access to the `TO_Cam_6kSeg` data block without altering its state.

## Parameters

| Name           | Type                  | Section | Description                                                              |
| :------------- | :-------------------- | :------ | :----------------------------------------------------------------------- |
| GetCam6kSegRef | `REF_TO TO_Cam_6kSeg` | Return  | Returns reference to attached `TO_Cam_6kSeg` block, or `NULL` if not it. |
