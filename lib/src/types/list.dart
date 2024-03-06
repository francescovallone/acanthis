import 'types.dart';

class AcanthisList<T> extends AcanthisType<List<T>> {

  List<AcanthisType> elements;

  AcanthisList(
    this.elements,
  );

  List<T> _parse(List<T> value){
    final parsed = <T>[];
    for (var i = 0; i < value.length; i++) {
      final parsedElement = elements[i].parse(value[i]);
      parsed.add(parsedElement.value);
    }
    return parsed;
  }

  (List<T> parsed, Map<String, dynamic> errors) _tryParse(List<T> value){
    final parsed = <T>[];
    final errors = <String, dynamic>{};
    for (var i = 0; i < value.length; i++) {
      final parsedElement = elements[i].tryParse(value[i]);
      parsed.add(parsedElement.value);
      if(parsedElement.errors.isNotEmpty){
        errors[i.toString()] = parsedElement.errors;
      }
    }
    return (parsed, errors);
  }

  @override
  AcanthisParseResult<List<T>> parse(List<T> value) {
    final parsed = _parse(value);
    return AcanthisParseResult(value: parsed);
  }

  @override
  AcanthisParseResult<List<T>> tryParse(List<T> value) {
    final (parsed, errors) = _tryParse(value);
    return AcanthisParseResult(
      value: parsed,
      errors: errors,
      success: _recursiveSuccess(errors)
    );
  }

  bool _recursiveSuccess(Map<String, dynamic> errors){
    List<bool> results = [];
    for (var error in errors.values) {
      results.add(error is Map<String, dynamic> ? _recursiveSuccess(error) : error.isEmpty);
    }
    return results.every((element) => element);
  }

  AcanthisList<T> min(int length){
    addCheck(AcanthisCheck<List<T>>(
      onCheck: (toTest) => toTest.length >= length,
      error: 'The list must have at least $length elements',
      name: 'min'
    ));
    return this;
  }

  AcanthisList<T> max(int length){
    addCheck(AcanthisCheck<List<T>>(
      onCheck: (toTest) => toTest.length <= length,
      error: 'The list must have at most $length elements',
      name: 'max'
    ));
    return this;
  }

  AcanthisList<T> unique(){
    addCheck(AcanthisCheck<List<T>>(
      onCheck: (toTest) => toTest.toSet().length == toTest.length,
      error: 'The list must have unique elements',
      name: 'unique'
    ));
    return this;
  }

  AcanthisList<T> length(T value){
    addCheck(AcanthisCheck<List<T>>(
      onCheck: (toTest) => toTest.length == value,
      error: 'The list must have exactly $value elements',
      name: 'length'
    ));
    return this;
  }

  AcanthisList<T> customCheck({
    required bool Function(List<T> value) onCheck,
    required String error,
    required String name
  }){
    addCheck(AcanthisCheck<List<T>>(
      onCheck: onCheck,
      error: error,
      name: name
    ));
    return this;
  }

}

AcanthisList dynamicList(List<AcanthisType> elements) => AcanthisList<dynamic>(
  elements,
);