# List

The list method is used to validate a list of objects that shares the same schema.

::: info
After the validation of the objects in the list, the list itself is validated.
:::

```dart

import 'package:acanthis/acanthis.dart';

void main() {
  final list = string().min(3).list();

  final result = list.tryParse(['Francesco', '255']);

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

### min

The min method is used to validate the minimum length of a list.

```dart

import 'package:acanthis/acanthis.dart';

void main() {
  final list = string().min(3).list().min(2);

  final result = list.tryParse(['Francesco', '255']);

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```

### max

The max method is used to validate the maximum length of a list.

```dart

import 'package:acanthis/acanthis.dart';

void main() {
  final list = string().min(3).list().max(2);

  final result = list.tryParse(['Francesco', '255']);

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```

### length

The length method is used to validate the exact length of a list.

```dart

import 'package:acanthis/acanthis.dart';

void main() {
  final list = string().min(3).list().length(2);

  final result = list.tryParse(['Francesco', '255']);

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```

### unique

The unique method is used to validate that a list contains unique elements.

```dart

import 'package:acanthis/acanthis.dart';

void main() {
  final list = string().min(3).list().unique();

  final result = list.tryParse(['Francesco', '255']);

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```

### anyOf

The anyOf method is used to validate that a list contains at least one of the elements in the list.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final list = string().min(3).list().anyOf([255]);

  final result = list.tryParse(['Francesco', 255]);

  if (result.success) {
  print('The schema is valid!');
  } else {
  print('The schema is invalid!');
  }
}
```

### everyOf

The everyOf method is used to validate that a list contains all the elements in the list.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final list = string().min(3).list().everyOf([255, 'Francesco']);

  final result = list.tryParse(['Francesco', 255]);

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}
```