import 'nullable.dart';
import 'types.dart';

/// A class to validate list types
class AcanthisList<T> extends AcanthisType<List<T>> {
  AcanthisType<T> element;

  AcanthisList(
    this.element,
  );

  List<T> _parse(List<T> value) {
    final parsed = <T>[];
    for (var i = 0; i < value.length; i++) {
      final parsedElement = element.parse(value[i]);
      parsed.add(parsedElement.value);
    }
    final result = super.parse(value);
    return result.value;
  }

  (List<T> parsed, Map<String, dynamic> errors) _tryParse(List<T> value) {
    final parsed = <T>[];
    final errors = <String, dynamic>{};
    for (var i = 0; i < value.length; i++) {
      final parsedElement = element.tryParse(value[i]);
      parsed.add(parsedElement.value);
      if (parsedElement.errors.isNotEmpty) {
        errors[i.toString()] = parsedElement.errors;
      }
    }
    final result = super.tryParse(value);
    return (result.value, {...errors, ...result.errors});
  }

  /// Override of [parse] from [AcanthisType]
  @override
  AcanthisParseResult<List<T>> parse(List<T> value) {
    final parsed = _parse(value);
    return AcanthisParseResult(value: parsed);
  }

  /// Override of [tryParse] from [AcanthisType]
  @override
  AcanthisParseResult<List<T>> tryParse(List<T> value) {
    final (parsed, errors) = _tryParse(value);
    return AcanthisParseResult(
        value: parsed, errors: errors, success: _recursiveSuccess(errors));
  }

  bool _recursiveSuccess(Map<String, dynamic> errors) {
    List<bool> results = [];
    for (var error in errors.values) {
      results.add(error is Map<String, dynamic>
          ? _recursiveSuccess(error)
          : error.isEmpty);
    }
    return results.every((element) => element);
  }

  /// Add a check to the list to check if it is at least [length] elements long
  AcanthisList<T> min(int length) {
    addCheck(AcanthisCheck<List<T>>(
        onCheck: (toTest) => toTest.length >= length,
        error: 'The list must have at least $length elements',
        name: 'min'));
    return this;
  }

  /// Add a check to the list to check if it is at most [length] elements long
  AcanthisList<T> max(int length) {
    addCheck(AcanthisCheck<List<T>>(
        onCheck: (toTest) => toTest.length <= length,
        error: 'The list must have at most $length elements',
        name: 'max'));
    return this;
  }

  /// Add a check to the list to check if all elements are unique
  AcanthisList<T> unique() {
    addCheck(AcanthisCheck<List<T>>(
        onCheck: (toTest) => toTest.toSet().length == toTest.length,
        error: 'The list must have unique elements',
        name: 'unique'));
    return this;
  }

  /// Add a check to the list to check if it has exactly [value] elements
  AcanthisList<T> length(int value) {
    addCheck(AcanthisCheck<List<T>>(
        onCheck: (toTest) => toTest.length == value,
        error: 'The list must have exactly $value elements',
        name: 'length'));
    return this;
  }

  /// Add a custom check to the list
  AcanthisList<T> customCheck(
      {required bool Function(List<T> value) onCheck,
      required String error,
      required String name}) {
    addCheck(
        AcanthisCheck<List<T>>(onCheck: onCheck, error: error, name: name));
    return this;
  }

  /// Add a transformation to the list to transform it using [transformation]
  AcanthisList<T> transform(List<T> Function(List<T> value) transformation) {
    addTransformation(AcanthisTransformation(transformation: transformation));
    return this;
  }

  /// Make the value nullable
  AcanthisNullable<List<T>> nullable({List<T>? defaultValue}) {
    return AcanthisNullable(this, defaultValue: defaultValue);
  }
}
