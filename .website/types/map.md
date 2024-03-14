# Map

The map validator is used to validate a map. Usally should be used to validate JSON objects or similar.

You can use the class `AcanthisMap<V>` to create a map schema or the function `object` to create a map schema suitable for a json object.


## Example

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final schema = object({
	'name': string().min(3),
	'age': number().positive(),
  });

  final result = schema.tryParse({
	'name': 'Francesco',
	'age': 24,
  });

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

### passthrough

The passthrough method is used to allow passthrough of unknown keys. This is useful when you want to validate a map, but you don't know all the keys that are present in the map.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final schema = object({
	'name': string().min(3),
	'age': number().positive(),
  }).passthrough();

  final result = schema.tryParse({
	'name': 'Francesco',
	'age': 24,
	'unknown': 'key',
  });

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```

### extend

The extend method is used to extend the schema with another schema. This is useful when you want to validate a map, but you want to validate some keys with a different schema.

```dart

import 'package:acanthis/acanthis.dart';

void main() {
  final schema = object({
	'name': string().min(3),
	'age': number().positive(),
  }).extend({
	'unknown': string(),
  });

  final result = schema.tryParse({
	'name': 'Francesco',
	'age': 24,
	'unknown': 'key',
  });

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```

### merge

The merge method is used to merge the schema with another schema. This is useful when you want to validate a map, but you want to validate some keys with a different schema.

```dart

import 'package:acanthis/acanthis.dart';

void main() {
  final schema = object({
	'name': string().min(3),
	'age': number().positive(),
  }).merge({
	'unknown': string(),
  });

  final result = schema.tryParse({
	'name': 'Francesco',
	'age': 24,
	'unknown': 'key',
  });

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```

::: warning
If the key is present in both schemas, the second schema will override the first schema.
:::

### pick

The pick method is used to pick only the entries in the schema that are present in a list of keys.

```dart

import 'package:acanthis/acanthis.dart';

void main() {
  final schema = object({
	'name': string().min(3),
	'age': number().positive(),
  }).pick(['name']);

  final result = schema.tryParse({
	'name': 'Francesco',
  });

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```

### omit
The omit method is used to omit the entries in the schema that are present in a list of keys.

```dart

import 'package:acanthis/acanthis.dart';

void main() {
  final schema = object({
	'name': string().min(3),
	'age': number().positive(),
  }).omit(['age']);

  final result = schema.tryParse({
	'name': 'Francesco',
  });

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```

### list

The list method is used to validate a list of maps.

For the list validations methods, you check the [List](/types/list) page.


```dart

import 'package:acanthis/acanthis.dart';

void main() {
  final schema = object({
	'name': string().min(3),
	'age': number().positive(),
  }).list();

  final result = schema.tryParse([
	{
	  'name': 'Francesco',
	  'age': 24,
	},
	{
	  'name': 'Francesco',
	  'age': 24,
	},
  ]);

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```