# GetAxisRef

With the method `GetAxisRef`, you get the reference to the attached axis (`TO_Axis`), which serves as the base type for potential leading axis assignments.

## Underlying Mechanism

- Returns the internal `_axisRef : REF_TO TO_Axis`.

## Effects

- Grants access to the base `TO_Axis` data block, commonly required when configuring leading/master axis relationships.

## Parameters

| Name       | Type             | Section | Description                                                     |
| :--------- | :--------------- | :------ | :-------------------------------------------------------------- |
| GetAxisRef | `REF_TO TO_Axis` | Return  | Returns the reference to the attached `TO_Axis` data block.     |
