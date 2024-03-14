# Boolean

A boolean validator is used to validate a boolean value.

## Example

```dart

import 'package:acanthis/acanthis.dart';

void main() {
  final result = boolean().tryParse(true);

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```

::: tip
The AcanthisParseResult object, that is returned by the `parse` and `tryParse` method is described [here](/introduction.html#acanthisparseresult).
:::

## Methods

### isTrue

The isTrue method is used to validate that a boolean is true.

```dart

import 'package:acanthis/acanthis.dart';

void main() {
  final result = boolean().isTrue().tryParse(true);

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```

### isFalse

The isFalse method is used to validate that a boolean is false.

```dart

import 'package:acanthis/acanthis.dart';

void main() {
  final result = boolean().isFalse().tryParse(false);

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```