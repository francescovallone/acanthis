import '../exceptions/validation_error.dart';

abstract class AcanthisType<O> {

  final List<AcanthisCheck> checks = [];

  AcanthisType();

  AcanthisParseStatus<O> parse(O value){
    for (var check in checks) {
      if(!check.check(value)){
        throw ValidationError(
          check.error
        );
      }
    }
    return AcanthisParseStatus(
      value: value
    );
  }

  AcanthisParseStatus<O> tryParse(O value){
    final errors = <String, String>{};
    for (var check in checks) {
      if(!check.check(value)){
        errors[check.name] = check.error;
      }
    }
    return AcanthisParseStatus(
      value: value,
      errors: errors,
      success: errors.isEmpty
    );
  }

  void addCheck(AcanthisCheck<O> check) {
    checks.add(check);
  }

}

class AcanthisCheck<O> {

  final bool Function(O value) onCheck;
  final String error;
  final String name;

  const AcanthisCheck({
    this.error = '',
    this.name = '',
    required this.onCheck
  });

  bool check(dynamic value){
    try {
      return onCheck(value as O);
    } catch (e) {
      return false;
    }
  }

}

class AcanthisParseStatus<O> {

  final O value;
  final Map<String, dynamic> errors;
  final bool success;

  const AcanthisParseStatus({
    required this.value,
    this.errors = const {},
    this.success = true
  });

  @override
  String toString() {
    return 'AcanthisParseStatus<$O>{value: $value, errors: $errors, success: $success}';
  }

}