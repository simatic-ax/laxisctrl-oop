# GetWarnings

With the method `GetWarnings`, you split the `WarningWord` of this cam technology object into individual status bits.

## Underlying Mechanism

- Inspects `GetType()` and calls the corresponding warning reader function:
  - `TO_Type#Cam`: `GetCamWarnings(GetCamRef()^)`
  - `TO_Type#Cam_10k`: `GetCamWarnings(GetCam10kRef()^)`
  - `TO_Type#Cam_600Seg`: `GetCamWarnings(GetCam600SegRef()^)`
  - `TO_Type#Cam_6kSeg`: `GetCamWarnings(GetCam6kSegRef()^)`

## Effects

- Reads and evaluates the current warning word without altering the state of the cam.

## Parameters

| Name        | Type          | Section | Description                                                    |
| :---------- | :------------ | :------ | :------------------------------------------------------------- |
| GetWarnings | `CamWarnings` | Return  | Structure containing individual boolean flags for cam warnings.|
