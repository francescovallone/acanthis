# Union

A union is a special validator. Inside a union, you can specify multiple validators. The value is valid if it is valid for at least one of the validators.

## Example

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final schema = union([
	string().min(3),
	number().positive(),
  ]);

  final result = schema.tryParse('Francesco');

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```

## Methods

### or

The or method on other validators to create a union.

```dart

import 'package:acanthis/acanthis.dart';

void main() {
  final schema = string().min(3).or([number().positive()]);
  /// Equal to
  /// final schema = union([
  /// 	string().min(3),
  /// 	number().positive(),
  /// ]);

  final result = schema.tryParse('Francesco');

  if (result.success) {
	print('The schema is valid!');
  } else {
	print('The schema is invalid!');
  }
}
```