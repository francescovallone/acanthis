import 'list.dart';
import 'types.dart';

/// A class to validate date types
class AcanthisDate extends AcanthisType<DateTime> {
  AcanthisDate();

  /// Add a check to the date to check if it is before or equal to [value]
  AcanthisDate min(DateTime value) {
    addCheck(AcanthisCheck<DateTime>(
        onCheck: (toTest) =>
            toTest.isAfter(value) || toTest.isAtSameMomentAs(value),
        error: 'The date must be greater than or equal to $value',
        name: 'min'));
    return this;
  }

  /// Add a check to the date to check if it is less than or equal to [value]
  AcanthisDate max(DateTime value) {
    addCheck(AcanthisCheck<DateTime>(
        onCheck: (toTest) =>
            toTest.isBefore(value) || toTest.isAtSameMomentAs(value),
        error: 'The date must be less than or equal to $value',
        name: 'max'));
    return this;
  }

  /// Create a list of dates
  AcanthisList<DateTime> list() {
    return AcanthisList<DateTime>(this);
  }

  /// Add a custom check to the date
  AcanthisDate customCheck(
      {required bool Function(DateTime value) onCheck,
      required String error,
      required String name}) {
    addCheck(
        AcanthisCheck<DateTime>(onCheck: onCheck, error: error, name: name));
    return this;
  }

  /// Add a transformation to the date to transform it using [transformation]
  AcanthisDate transform(DateTime Function(DateTime value) transformation) {
    addTransformation(AcanthisTransformation<DateTime>(transformation: transformation));
    return this;
  }

}

/// Create a new date type
AcanthisDate date() => AcanthisDate();
