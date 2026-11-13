# GetSpeedAxisRef

With the method `GetSpeedAxisRef`, you get the reference to the attached speed axis technology object (`TO_SpeedAxis`).

## Underlying Mechanism

- Returns the internal `_speedAxisRef : REF_TO TO_SpeedAxis`.

## Effects

- Grants direct access to the underlying native technology object data block without modifying its state.

## Parameters

| Name            | Type                 | Section | Description                                                        |
| :-------------- | :------------------- | :------ | :----------------------------------------------------------------- |
| GetSpeedAxisRef | `REF_TO TO_SpeedAxis`| Return  | Returns the reference to the attached `TO_SpeedAxis` data block.   |
