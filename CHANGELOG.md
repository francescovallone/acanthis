# Changelog

## 0.1.3

### Features

- Add the `optionals` function to the `object` validator.

### Docs

- Add information about `optionals` in the `object` validator.

## 0.1.2

### Features

- Add the `addFieldDependency` function to the `object` validator.

### Docs

- Add information about `addFieldDependency` in the `object` validator.
- Remove the `Operations` section from the documentation.

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
