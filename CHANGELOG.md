## 0.1.1

### Refactor

- The function `jsonObject` has been renamed as `object`.

### Docs

- Add explicit information about the parse result object `AcanthisParseResult`.

## 0.1.0

### Features

- Add the `nullable` validator.
- Add the `union` validator.
- Add the `boolean` validator.
- Add transformation functions for all the validators except `nullable`, `boolean` and `union`.
- Add tests for all the validators (100% coverage 🎉).
- Add documentation for all the validators.

### Fixes

- [#1] Fix the `string().email()` validator that will now use the `email_validator` package.

## 0.0.1

- Initial version.
