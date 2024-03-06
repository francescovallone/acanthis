# String

The string method is used to validate a string.

You can also use the class `AcanthisString` to create a string schema.

## Example

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final name = string().min(3);

  final result = name.tryParse('Francesco');

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```

## Methods

### email

The email method is used to validate an email.

```dart

import 'package:acanthis/acanthis.dart';

void main() {
  final email = string().email();

  final result = email.tryParse('test@test.com');

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```

::: info
The email method uses a regular expression to validate the email. The regular expression is the following:
```txt
^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$
```
:::

### min

The min method is used to validate the minimum length of a string.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final name = string().min(3);

  final result = name.tryParse('Francesco');

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```

### max

The max method is used to validate the maximum length of a string.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final name = string().max(3);

  final result = name.tryParse('Fra');

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```

### length

The length method is used to validate the exact length of a string.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final name = string().length(3);

  final result = name.tryParse('Fra');

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```

### pattern

The pattern method is used to validate a string using a regular expression.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final name = string().pattern(RegExp(r'^[a-zA-Z]+$'));

  final result = name.tryParse('Francesco');

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```

### required

The required method is used to validate that a string is not empty.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final name = string().required();

  final result = name.tryParse('Francesco');

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```

### contains

The contains method is used to validate that a string contains a substring.

```dart

import 'package:acanthis/acanthis.dart';

void main() {
  final name = string().contains('Francesco');

  final result = name.tryParse('Francesco');

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```

### startsWith

The startsWith method is used to validate that a string starts with a substring.

```dart

import 'package:acanthis/acanthis.dart';

void main() {
  final name = string().startsWith('Fra');

  final result = name.tryParse('Francesco');

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```

### endsWith

The endsWith method is used to validate that a string ends with a substring.

```dart

import 'package:acanthis/acanthis.dart';

void main() {
  final name = string().endsWith('co');

  final result = name.tryParse('Francesco');

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```

### list

The list method is used to validate a list of `String` objects.

For the list validations methods, you check the [List](/types/list) page.


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
