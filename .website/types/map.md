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

### addFieldDependency

The addFieldDependency method is used to add a dependency between two fields. It requires three parameters: the first is the field that depends on the second, the second is the field that the first depends on, and the third is a function that takes the value of the first field and the value of the second field and returns a boolean.

```dart

import 'package:acanthis/acanthis.dart';

void main() {
  final schema = object({
	'name': string().min(3),
	'age': number().positive(),
  }).addFieldDependency(
	dependent: 'age',
	dependendsOn: 'name',
	dependency: (age, name) => name.length > age,
  );

  final result = schema.tryParse({
	'name': 'Francesco',
	'age': 32,
  });
	
  /// Since this schema is invalid, the result will be false
  /// and the error will be:
  /// {'name': {'dependency': 'Dependency not met: age->name'}}
}
```

### optionals

The optionals method is used to make some of the fields optional. It requires a list of strings that are the keys of the fields that should be optional.

::: info
The fields that are not present in the list of optional fields are required.
The fields present in the list are valid only for the current layer of a multi-layered object.
:::

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final schema = object({
    'name': string().min(3),
    'age': number().positive(),
  }).optionals(['age']);

  final result = schema.tryParse({
    'name': 'Francesco',
  });

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}

/// The schema is valid!
```

### partial

The partial method is used to make the first-level fields nullable.

::: warning
Even if a field is nullable, it still needs to be present in the map.
:::

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final schema = object({
    'name': string().min(3),
    'age': number().positive(),
  }).partial();

  final result = schema.tryParse({
    'name': 'Francesco',
    'age': null,
  });

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}
```

You can also set the `deep` parameter to `true` to make all the fields in the map nullable.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final schema = object({
    'name': string().min(3),
    'age': number().positive(),
    'address': object({
      'street': string().min(3),
      'city': string().min(3),
    }),
  }).partial(deep: true);

  final result = schema.tryParse({
    'name': 'Francesco',
    'age': null,
    'address': {
      'street': 'Main St.',
      'city': null,
    },
  });

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}
```

## Recursive schemas

You can create recursive schemas by using the `lazy` method.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final schema = object({
    'name': string().min(3),
    'age': number().positive(),
    'children': lazy((parent) => parent.list()),
  });

  final result = schema.tryParse({
    'name': 'Francesco',
    'age': 32,
    'children': [
      {
        'name': 'Alice',
        'age': 5,
        'children': [],
      },
      {
        'name': 'Bob',
        'age': 7,
        'children': [
          {
            'name': 'Charlie',
            'age': 3,
            'children': [],
          },
        ],
      },
    ],
  });

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}
```