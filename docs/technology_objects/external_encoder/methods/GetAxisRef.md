# GetAxisRef

With the method `GetAxisRef`, you get the reference to the attached axis base object (`TO_Axis`), which allows using the external encoder as a leading/master axis.

## Underlying Mechanism

- Returns the internal `_axisRef : REF_TO TO_Axis`.

## Effects

- Grants access to the base `TO_Axis` data block, commonly required when configuring synchronous relationships with following axes.

## Parameters

| Name       | Type             | Section | Description                                                 |
| :--------- | :--------------- | :------ | :---------------------------------------------------------- |
| GetAxisRef | `REF_TO TO_Axis` | Return  | Returns the reference to the attached `TO_Axis` data block. |
