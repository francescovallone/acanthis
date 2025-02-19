# String

The string method is used to validate a string.

You can also use the class `AcanthisString` to create a string schema.

## Example

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final name = string().min(3);

  final result = name.tryParse('Acanthis');

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}
```

::: tip
The AcanthisParseResult object is described [here](/introduction.html#acanthisparseresult).
:::

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
The email method uses the `email_validator` package to validate the email.
:::

### min

The min method is used to validate the minimum length of a string.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final name = string().min(3);

  final result = name.tryParse('Acanthis');

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

  final result = name.tryParse('Aca');

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

  final result = name.tryParse('Aca');

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

  final result = name.tryParse('Acanthis');

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

  final result = name.tryParse('Acanthis');

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
  final name = string().contains('this');

  final result = name.tryParse('Acanthis');

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
  final name = string().startsWith('Aca');

  final result = name.tryParse('Acanthis');

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
  final name = string().endsWith('is');

  final result = name.tryParse('Acanthis');

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}
```

### cuid

The cuid method is used to validate a CUID.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final cuid = string().cuid();

  final result = cuid.tryParse('cjbh6z5p30000j5h6v7v6v6v6v');

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}
```

### cuid2

The cuid2 method is used to validate a CUID.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final cuid2 = string().cuid2();

  final result = cuid2.tryParse('cjbh6z5p30000j5h6v7v6v6v6v');

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}
```

### uuid

The uuid method is used to validate a UUID.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final uuid = string().uuid();

  final result = uuid.tryParse('550e8400-e29b-41d4-a716-446655440000');

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}
```

### nanoid

The nanoid method is used to validate a nanoid.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final nanoid = string().nanoid();

  final result = nanoid.tryParse('V1StGXR8_Z5jdHi6B-myT');

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}
```

### jwt

The jwt method is used to validate a JWT.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final jwt = string().jwt();

  final result = jwt.tryParse('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c');

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}
```

### base64

The base64 method is used to validate a base64 string.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final base64 = string().base64();

  final result = base64.tryParse('SGVsbG8gV29ybGQh');

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}
```

### letters

The letters method is used to validate a string that contains only letters.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final letters = string().letters();

  final result = letters.tryParse('Acanthis');

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}
```

It can be used with the `strict` parameter to allow spaces and special characters.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final letters = string().letters(strict: false);

  final result = letters.tryParse('Acanthis 1.0');

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}
```

### digits

The digits method is used to validate a string that contains only digits.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final digits = string().digits();

  final result = digits.tryParse('123456');

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}
```

It can be used with the `strict` parameter to allow spaces and special characters.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final digits = string().digits(strict: false);

  final result = digits.tryParse('123 456');

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}
```

### alphanumeric

The alphanumeric method is used to validate a string that contains only alphanumeric characters.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final alphanumeric = string().alphanumeric();

  final result = alphanumeric.tryParse('Acanthis10');

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}
```

It can be used with the `strict` parameter to allow spaces and special characters.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final alphanumeric = string().alphanumeric(strict: false);

  final result = alphanumeric.tryParse('Acanthis 1.0');

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}
```

### alphanumericWithSpaces

The alphanumericWithSpaces method is used to validate a string that contains only alphanumeric characters and spaces.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final alphanumericWithSpaces = string().alphanumericWithSpaces();

  final result = alphanumericWithSpaces.tryParse('Acanthis 10');
  
  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}
```

It can be used with the `strict` parameter to allow special characters.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final alphanumericWithSpaces = string().alphanumericWithSpaces(strict: false);

  final result = alphanumericWithSpaces.tryParse('Acanthis 1.0!');

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}
```

### specialCharacters

The specialCharacters method is used to validate a string that contains only special characters.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final specialCharacters = string().specialCharacters();

  final result = specialCharacters.tryParse('!@#\$%^&*()');

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}
```

It can be used with the `strict` parameter to allow spaces and alphanumeric characters.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final specialCharacters = string().specialCharacters(strict: false);

  final result = specialCharacters.tryParse('!@#\$%^&*() Acanthis');

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }

}
```

### allCharacters

The allCharacters method is used to validate a string that contains all characters.

```dart

import 'package:acanthis/acanthis.dart';

void main() {

  final allCharacters = string().allCharacters();

  final result = allCharacters.tryParse('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()');

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}
```

### upperCase

The upperCase method is used to validate a string that is in uppercase.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final uppercase = string().upperCase();

  final result = uppercase.tryParse('HELLO WORLD!');

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}
```

### lowerCase

The lowerCase method is used to validate a string that is in lowercase.

```dart
import 'package:acanthis/acanthis.dart';

void main() {

  final lowercase = string().lowerCase(); 

  final result = lowercase.tryParse('hello world!');

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}
```

### mixedCase

The mixedCase method is used to validate a string that is in mixed case.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final mixedCase = string().mixedCase();

  final result = mixedCase.tryParse('Hello World!');

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}
```

### card

The card method is used to validate a card number.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final card = string().card();

  final result = card.tryParse('4111-1111-1111-1111');

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}
```

### dateTime

The dateTime method is used to validate a string that is a valid date time.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final dateTime = string().dateTime();

  final result = dateTime.tryParse('2021-10-10');

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}
```

### time

The time method is used to validate a string that is a valid time.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final time = string().time();

  final result = time.tryParse('12:00:00');

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}
```

### uri

The uri method is used to validate a string that is a valid uri.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final uri = string().uri();

  final result = uri.tryParse('https://acanthis.dev');

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}
```

### url

The url method is used to validate a string that is a valid url.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final url = string().url();

  final result = url.tryParse('https://acanthis.serinus.app');

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}
```

### hexColor

The hexColor method is used to validate a string that is a valid hex color.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final hexColor = string().hexColor();

  final result = hexColor.tryParse('#ff0000');

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}
```

### uncompromised

The uncompromised method is used to validate a string that is not compromised.

::: warning
This method uses the `haveibeenpwned` API to check if the password is compromised.
This check is an async check.
:::

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final uncompromised = string().uncompromised();

  final result = uncompromised.tryParseAsync('password');

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}
```

### or

The `or` method is used to create a `AcanthisUnion` from the current schema and the provided schemas.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final schema = string().or([string().min(3), string().max(5)]);

  final result = schema.tryParse('Acanthis');

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

  final result = list.tryParse(['Acanthis', '255']);

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }
}
```

### encode

The encode method is used to encode a string to base64.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final base64 = string().encode();

  final result = base64.tryParse('Hello World!');

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }

  /// result.value == 'SGVsbG8gV29ybGQh'
}
```

### decode

The decode method is used to decode a base64 string.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final base64 = string().decode();

  final result = base64.tryParse('SGVsbG8gV29ybGQh');

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }

  /// result.value == 'Hello World!'
}
```

### toUpperCase

The toUpperCase method is used to convert a string to uppercase.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final uppercase = string().toUpperCase();

  final result = uppercase.tryParse('hello world!');

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }

  /// result.value == 'HELLO WORLD!'
}
```

### toLowerCase

The toLowerCase method is used to convert a string to lowercase.

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final lowercase = string().toLowerCase();

  final result = lowercase.tryParse('HELLO WORLD!');

  if (result.success) {
    print('The schema is valid!');
  } else {
    print('The schema is invalid!');
  }

  /// result.value == 'hello world!'
}
```
