import 'package:acanthis/src/exceptions/async_exception.dart';

import '../exceptions/validation_error.dart';

/// A class to validate types
abstract class AcanthisType<O> {
  /// The operations that the type should perform
  final List<AcanthisOperation> operations = [];

  /// The constructor of the class
  AcanthisType();

  /// The parse method to parse the value
  /// it returns a [AcanthisParseResult] with the parsed value and throws a [ValidationError] if the value is not valid
  AcanthisParseResult<O> parse(O value) {
    final hasAsyncOperations = operations.any((element) => element is AcanthisAsyncCheck);
    if(hasAsyncOperations) {
      throw AsyncValidationException('Cannot use tryParse with async operations');
    }
    O newValue = value;
    for (var operation in operations) {
      if (operation is AcanthisCheck) {
        if (!operation(newValue)) {
          throw ValidationError(operation.error);
        }
      }
      if (operation is AcanthisTransformation) {
        newValue = operation(newValue);
      }
    }
    return AcanthisParseResult(value: newValue);
  }

  /// The tryParse method to try to parse the value
  /// it returns a [AcanthisParseResult]
  /// that has the following properties:
  /// - success: A boolean that indicates if the parsing was successful or not.
  /// - value: The value of the parsing. If the parsing was successful, this will contain the parsed value.
  /// - errors: The errors of the parsing. If the parsing was unsuccessful, this will contain the errors of the parsing.
  AcanthisParseResult<O> tryParse(O value) {
    final hasAsyncOperations = operations.any((element) => element is AcanthisAsyncCheck);
    if(hasAsyncOperations) {
      throw AsyncValidationException('Cannot use tryParse with async operations');
    }
    final errors = <String, String>{};
    O newValue = value;
    for (var operation in operations) {
      if (operation is AcanthisCheck) {
        if (!operation(newValue)) {
          errors[operation.name] = operation.error;
        }
      }
      if (operation is AcanthisTransformation) {
        newValue = operation(newValue);
      }
    }
    return AcanthisParseResult(
        value: newValue, errors: errors, success: errors.isEmpty);
  }

  /// The parseAsync method to parse the value that uses [AcanthisAsyncCheck]
  /// it returns a [AcanthisParseResult] with the parsed value and throws a [ValidationError] if the value is not valid
  Future<AcanthisParseResult<O>> parseAsync(O value) async {
    O newValue = value;
    for (var operation in operations) {
      if (operation is AcanthisCheck) {
        if (!operation(newValue)) {
          throw ValidationError(operation.error);
        }
      }
      if(operation is AcanthisAsyncCheck) {
        if(!await operation(newValue)) {
          throw ValidationError(operation.error);
        }
      }
      if (operation is AcanthisTransformation) {
        newValue = operation(newValue);
      }
    }
    return AcanthisParseResult(value: newValue);
  }

  /// The tryParseAsync method to try to parse the value that uses [AcanthisAsyncCheck]
  /// it returns a [AcanthisParseResult]
  /// that has the following properties:
  /// - success: A boolean that indicates if the parsing was successful or not.
  /// - value: The value of the parsing. If the parsing was successful, this will contain the parsed value.
  /// - errors: The errors of the parsing. If the parsing was unsuccessful, this will contain the errors of the parsing.
  Future<AcanthisParseResult<O>> tryParseAsync(O value) async {
    final errors = <String, String>{};
    O newValue = value;
    for (var operation in operations) {
      if (operation is AcanthisCheck) {
        if (!operation(newValue)) {
          errors[operation.name] = operation.error;
        }
      }
      if(operation is AcanthisAsyncCheck) {
        if(!await operation(newValue)) {
          errors[operation.name] = operation.error;
        }
      }
      if (operation is AcanthisTransformation) {
        newValue = operation(newValue);
      }
    }
    return AcanthisParseResult(
        value: newValue, errors: errors, success: errors.isEmpty);
  }

  /// Add a check to the type
  void addCheck(AcanthisCheck<O> check) {
    operations.add(check);
  }

  /// Add an async check to the type
  void addAsyncCheck(AcanthisAsyncCheck<O> check) {
    operations.add(check);
  }

  /// Add a transformation to the type
  void addTransformation(AcanthisTransformation<O> transformation) {
    operations.add(transformation);
  }
}

/// A class that represents a check operation
class AcanthisCheck<O> extends AcanthisOperation<O> {
  /// The function to check the value
  final bool Function(O value) onCheck;
  /// The error message of the check
  final String error;
  /// The name of the check
  final String name;
  /// The constructor of the class
  const AcanthisCheck({this.error = '', this.name = '', required this.onCheck});

  /// The call method to create a Callable class
  @override
  bool call(O value) {
    try {
      return onCheck(value);
    } catch (e) {
      return false;
    }
  }
}

/// A class that represents an async check operation
class AcanthisAsyncCheck<O> extends AcanthisOperation<O> {
  /// The function to check the value asynchronously
  final Future<bool> Function(O value) onCheck;
  /// The error message of the check
  final String error;
  /// The name of the check
  final String name;
  /// The constructor of the class
  const AcanthisAsyncCheck({this.error = '', this.name = '', required this.onCheck});

  @override
  Future<bool> call(O value) async {
    try {
      return await onCheck(value);
    } catch (e) {
      return false;
    }
  }

}

/// A class that represents a transformation operation
class AcanthisTransformation<O> extends AcanthisOperation<O> {
  /// The transformation function
  final O Function(O value) transformation;

  /// The constructor of the class
  const AcanthisTransformation({required this.transformation});

  /// The call method to create a Callable class
  @override
  O call(O value) {
    return transformation(value);
  }
}

/// A class that represents an operation
abstract class AcanthisOperation<O> {
  /// The constructor of the class
  const AcanthisOperation();

  /// The call method to create a Callable class
  dynamic call(O value);
}

/// A class to represent the result of a parse operation
class AcanthisParseResult<O> {
  /// The value of the parsing
  final O value;
  /// The errors of the parsing
  final Map<String, dynamic> errors;
  /// A boolean that indicates if the parsing was successful or not
  final bool success;
  /// The constructor of the class
  const AcanthisParseResult(
      {required this.value, this.errors = const {}, this.success = true});

  @override
  String toString() {
    return 'AcanthisParseResult<$O>{value: $value, errors: $errors, success: $success}';
  }
}
