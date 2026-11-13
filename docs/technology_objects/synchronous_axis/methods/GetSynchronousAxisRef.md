# GetSynchronousAxisRef

With the method `GetSynchronousAxisRef`, you get the reference to the attached synchronous axis technology object (`TO_SynchronousAxis`).

## Underlying Mechanism

- Returns the internal `_synchronousAxisRef : REF_TO TO_SynchronousAxis`.

## Effects

- Grants direct access to the underlying native `TO_SynchronousAxis` data block without altering its state.

## Parameters

| Name                  | Type                       | Section | Description                                                               |
| :-------------------- | :------------------------- | :------ | :------------------------------------------------------------------------ |
| GetSynchronousAxisRef | `REF_TO TO_SynchronousAxis`| Return  | Returns the reference to the attached `TO_SynchronousAxis` data block.    |
