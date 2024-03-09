import '../exceptions/validation_error.dart';

/// A class to validate types
abstract class AcanthisType<O> {
  /// The operations that the type should perform
  final List<AcanthisOperation> operations = [];

  AcanthisType();

  /// The parse method to parse the value
  /// it returns a [AcanthisParseResult] with the parsed value and throws a [ValidationError] if the value is not valid
  AcanthisParseResult<O> parse(O value) {
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
  /// it returns a [AcanthisParseResult] with the parsed value and the errors
  AcanthisParseResult<O> tryParse(O value) {
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

  /// Add a check to the type
  void addCheck(AcanthisCheck<O> check) {
    operations.add(check);
  }

  /// Add a transformation to the type
  void addTransformation(AcanthisTransformation<O> transformation) {
    operations.add(transformation);
  }
}

/// A class that represents a check operation
class AcanthisCheck<O> extends AcanthisOperation<O> {
  final bool Function(O value) onCheck;
  final String error;
  final String name;

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

/// A class that represents a transformation operation
class AcanthisTransformation<O> extends AcanthisOperation<O> {
  final O Function(O value) transformation;

  const AcanthisTransformation({required this.transformation});

  /// The call method to create a Callable class
  @override
  O call(O value) {
    return transformation(value);
  }
}

/// A class that represents an operation
abstract class AcanthisOperation<O> {
  const AcanthisOperation();

  /// The call method to create a Callable class
  dynamic call(O value);
}

/// A class to represent the result of a parse operation
class AcanthisParseResult<O> {
  final O value;
  final Map<String, dynamic> errors;
  final bool success;

  const AcanthisParseResult(
      {required this.value, this.errors = const {}, this.success = true});

  @override
  String toString() {
    return 'AcanthisParseResult<$O>{value: $value, errors: $errors, success: $success}';
  }
}
