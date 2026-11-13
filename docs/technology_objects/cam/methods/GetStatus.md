# GetStatus

With the method `GetStatus`, you split the `StatusWord` of this cam technology object into individual status bits.

## Underlying Mechanism

- Inspects `GetType()` and calls the corresponding status reader function:
  - `TO_Type#Cam`: `GetCamStatus(GetCamRef()^)`
  - `TO_Type#Cam_10k`: `GetCamStatus(GetCam10kRef()^)`
  - `TO_Type#Cam_600Seg`: `GetCamStatus(GetCam600SegRef()^)`
  - `TO_Type#Cam_6kSeg`: `GetCamStatus(GetCam6kSegRef()^)`

## Effects

- Reads and evaluates the current status word without altering the state of the cam.

## Parameters

| Name      | Type        | Section | Description                                                  |
| :-------- | :---------- | :------ | :----------------------------------------------------------- |
| GetStatus | `CamStatus` | Return  | Structure containing individual boolean flags for cam status.|
