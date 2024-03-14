# Acanthis

Acanthis is a Validation library heavily inspired by [Zod](https://github.com/colinhacks/zod). It is designed to be a simple, and easy to use validation library.

## Features

Acanthis is designed to be composable. Schemas can be composed together to create more complex schemas.

Also Acanthis doesn't require any runtime dependencies, and makes use of a chainable API to create schemas.

## Getting Started

To get started with Acanthis, you can install it using the following command:

```bash
dart pub add acanthis
```

## Example

Here is a simple example of how to use Acanthis:

```dart
import 'package:acanthis/acanthis.dart';

void main() {
  final schema = object({
	'name': string().min(3),
	'age': number().positive(),
  });

  final result = schema.tryParse({
	  'name': 'Francesco',
	  'age': 59,
  });

  /// The result is a AcanthisParseResult object
  /// that has the following properties:
  /// - success: A boolean that indicates if the parsing was successful or not.
  /// - value: The value of the parsing. If the parsing was successful, this will contain the parsed value.
  /// - errors: The errors of the parsing. If the parsing was unsuccessful, this will contain the errors of the parsing.

  if (result.success) {
	  print('The schema is valid!');
  } else {
	  print('The schema is invalid!');
  }
}
```

As you can see if you come from a Zod background, the API is very similar and should be familiar to you.

## Contributions

Contributions are welcome! If you want to contribute to Acanthis, you can open a pull request on the [GitHub repository](https://github.com/francescovallone/acanthis/pulls)

