import 'list.dart';
import 'types.dart';
import 'union.dart';

class AcanthisBoolean extends AcanthisType<bool> {
  /// Add a check to the boolean to check if it is true
  AcanthisBoolean isTrue() {
    addCheck(AcanthisCheck<bool>(
        onCheck: (value) => value,
        error: 'Value must be true',
        name: 'isTrue'));
    return this;
  }

  /// Add a check to the boolean to check if it is false
  AcanthisBoolean isFalse() {
    addCheck(AcanthisCheck<bool>(
        onCheck: (value) => !value,
        error: 'Value must be false',
        name: 'isFalse'));
    return this;
  }

  /// Create a list of booleans
  AcanthisList<bool> list() {
    return AcanthisList(this);
  }

  /// Create a union from the nullable
  AcanthisUnion or(List<AcanthisType> elements) {
    return AcanthisUnion([this, ...elements]);
  }
}

/// Create a boolean validator
AcanthisBoolean boolean() => AcanthisBoolean();
