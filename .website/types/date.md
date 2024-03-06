# Date

The date method is used to validate a DateTime object.

You can also use the class `AcanthisDate` to create a date schema.

## Example

```dart

import 'package:acanthis/acanthis.dart';

void main() {
  final date = date().max(DateTime.now());

  final result = date.tryParse(DateTime.now());

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```

## Methods

### max

The max method is used to validate the maximum date of a DateTime object.

```dart

import 'package:acanthis/acanthis.dart';

void main() {
  final date = date().max(DateTime.now());

  final result = date.tryParse(DateTime.now());

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```

### min

The min method is used to validate the minimum date of a DateTime object.

```dart

import 'package:acanthis/acanthis.dart';

void main() {
  final date = date().min(DateTime.now());

  final result = date.tryParse(DateTime.now());

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```

### list

The list method is used to validate a list of `DateTime` objects.

For the list validations methods, you check the [List](/types/list) page.

```dart

import 'package:acanthis/acanthis.dart';

void main() {
  final date = date().list();

  final result = date.tryParse([DateTime.now(), DateTime.now()]);

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```