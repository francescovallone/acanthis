import '../exceptions/validation_error.dart';

abstract class AcanthisType<O> {
  final List<AcanthisOperation> operations = [];

  AcanthisType();

  AcanthisParseResult<O> parse(O value) {
    O newValue = value;
    for (var operation in operations) {
      if(operation is AcanthisCheck){
        if (!operation(newValue)) {
          throw ValidationError(operation.error);
        }
      }
      if(operation is AcanthisTransformation) {
        newValue = operation(newValue);
      }
    }
    return AcanthisParseResult(value: newValue);
  }

  AcanthisParseResult<O> tryParse(O value) {
    final errors = <String, String>{};
    O newValue = value;
    for (var operation in operations) {
      if(operation is AcanthisCheck) {
        if (!operation(newValue)) {
          errors[operation.name] = operation.error;
        }
      }
      if(operation is AcanthisTransformation) {
        newValue = operation(newValue);
      }
    }
    return AcanthisParseResult(
        value: newValue, errors: errors, success: errors.isEmpty);
  }

  void addCheck(AcanthisCheck<O> check) {
    operations.add(check);
  }

  void addTransformation(AcanthisTransformation<O> transformation) {
    operations.add(transformation);
  }

}

class AcanthisCheck<O> extends AcanthisOperation<O>{
  final bool Function(O value) onCheck;
  final String error;
  final String name;

  const AcanthisCheck({this.error = '', this.name = '', required this.onCheck});

  @override
  bool call(O value) {
    try {
      return onCheck(value);
    } catch (e) {
      return false;
    }
  }
}

class AcanthisTransformation<O> extends AcanthisOperation<O>{
  final O Function(O value) transformation;

  const AcanthisTransformation({required this.transformation});

  @override
  O call(O value) {
    return transformation(value);
  }

}

abstract class AcanthisOperation<O> {
  
  const AcanthisOperation();

  dynamic call(O value);

}

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
