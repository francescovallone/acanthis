# Nullable

Nullable types are types that can be `null` in addition to their normal values. This is useful for when you want to represent a value that may or may not be present.

## How it works

The nullable type is a wrapper around another type. It allows the value to be `null` in addition to the normal values of the wrapped type.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final schema = string().nullable();

  final result = schema.tryParse(null);

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```

In this example, the schema is a nullable string. The `tryParse` method is called with `null` as the argument. Since the schema is nullable, the result is successful.

### Default value

You can also specify a default value for the nullable type.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final schema = string().nullable(defaultValue: 'default');

  final result = schema.tryParse(null);

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
  assert(result.value == 'default');
}
```

### And for Maps or Lists?

The nullable type can be used with maps and lists as well.

::: code-group

```dart [nullable_map.dart]

import 'package:acanthis/acanthis.dart';

void main() {
  final schema = jsonObject({
	'name': string().min(3),
	'age': number().positive(),
  }).nullable();

  final result = schema.tryParse(null);

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```

```dart	[nullable_list.dart]

import 'package:acanthis/acanthis.dart';

void main() {
  final schema = string().list().nullable();

  final result = schema.tryParse(null);

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```

::: 

Also you can create lists of nullable types.

```dart

import 'package:acanthis/acanthis.dart';

void main() {
  final schema = string().nullable().list();

  final result = schema.tryParse(null);

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```

And maps with nullable types.

```dart 

import 'package:acanthis/acanthis.dart';

void main() {
  final schema = jsonObject({
	'name': string().min(3).nullable(),
	'age': number().positive(),
  });

  final result = schema.tryParse({
	'name': null,
	'age': 25,
  });

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```