# GetErrors

With the method `GetErrors`, you split the `ErrorWord` of this cam technology object into individual status bits.

## Underlying Mechanism

- Inspects `GetType()` and calls the corresponding error reader function:
  - `TO_Type#Cam`: `GetCamErrors(GetCamRef()^)`
  - `TO_Type#Cam_10k`: `GetCamErrors(GetCam10kRef()^)`
  - `TO_Type#Cam_600Seg`: `GetCamErrors(GetCam600SegRef()^)`
  - `TO_Type#Cam_6kSeg`: `GetCamErrors(GetCam6kSegRef()^)`

## Effects

- Reads and evaluates the current error word without altering the state of the cam.

## Parameters

| Name      | Type        | Section | Description                                                  |
| :-------- | :---------- | :------ | :----------------------------------------------------------- |
| GetErrors | `CamErrors` | Return  | Structure containing individual boolean flags for cam errors.|
