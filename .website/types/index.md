# Acanthis Type

AcanthisType is the base class for all the types in Acanthis. It provides the following methods:

## Methods

### parse

The parse method is used to parse a value. If the parsing is unsuccessful, it will throw an exception.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final stringType = string();

  final result = stringType.parse('Acanthis');

  print(result); // [AcanthisParseResult]
}
```

::: warning
If the chain of validators contains an async validator, the parse method will throw an exception.
:::

### tryParse

The tryParse method is used to parse a value. If the parsing is unsuccessful, it will return a `AcanthisParseResult` object.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final stringType = string();

  final result = stringType.tryParse('Acanthis');

  print(result); // [AcanthisParseResult]
}
```

::: warning
If the chain of validators contains an async validator, the tryParse method will throw an exception.
:::

### parseAsync

The parseAsync method is used to parse a value asynchronously. If the parsing is unsuccessful, it will throw an exception.

```dart
import 'package:acanthis/acanthis.dart';

void main() async {
  final stringType = string();

  final result = await stringType.parseAsync('Acanthis');

  print(result); // [AcanthisParseResult]
}
```

### tryParseAsync

The tryParseAsync method is used to parse a value asynchronously. If the parsing is unsuccessful, it will return a `AcanthisParseResult` object.

```dart
import 'package:acanthis/acanthis.dart';

void main() async {
  final stringType = string();

  final result = await stringType.tryParseAsync('Acanthis');

  print(result); // [AcanthisParseResult]
}
```

### refine

The refine method is used to add a custom check to the type.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final stringType = string().refine(
      onCheck: (value) async {
        return value.length > 3;
      },
      name: 'asyncCheck',
      error: 'Value length must be greater than 3',
    );

  final result = stringType.tryParse('Acanthis');

  print(result); // [AcanthisParseResult]
}
```

### refineAsync

The refineAsync method is used to add a custom check to the type asynchronously.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final stringType = string().refineAsync(
      onCheck: (value) async {
        return value.length > 3;
      },
      name: 'asyncCheck',
      error: 'Value length must be greater than 3',
    );

  final result = stringType.tryParse('Acanthis');

  print(result); // [AcanthisParseResult]
}
```

### pipe

The pipe method is used to control the flow of the parsing process. It allows you to add custom transformations and validation that requires you to go from one type to another.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
    final stringType = string().pipe(
        date().min(DateTime.parse('2021-10-01')),
        transform: (value) => DateTime.parse(value),
    );

    final result = stringType.tryParse('2021-10-10');

    print(result); // [AcanthisParseResult]
}
```

### nullable

The nullable method is used to allow the value to be null.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final stringType = string().nullable();

  final result = stringType.tryParse(null);

  print(result); // [AcanthisParseResult]
}
```

::: warning
Some types override the nullable method to allow for more specific behavior. You will find more information in the specific type documentation.
:::

### transform

The transform method is used to transform the value of the type.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final stringType = string().transform((value) => value.toUpperCase());

  final result = stringType.tryParse('acanthis');

  print(result.value); // [ACANTHIS]
}
```