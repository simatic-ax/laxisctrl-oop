# GetPositioningAxisRef

With the method `GetPositioningAxisRef`, you get the reference to the attached positioning axis technology object (`TO_PositioningAxis`).

## Underlying Mechanism

- Returns the internal `_positioningAxisRef : REF_TO TO_PositioningAxis`.

## Effects

- Grants direct access to the underlying native positioning axis technology object data block without modifying its state.

## Parameters

| Name                  | Type                       | Section | Description                                                              |
| :-------------------- | :------------------------- | :------ | :----------------------------------------------------------------------- |
| GetPositioningAxisRef | `REF_TO TO_PositioningAxis`| Return  | Returns the reference to the attached `TO_PositioningAxis` data block.   |
