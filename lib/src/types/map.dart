import '../exceptions/validation_error.dart';
import 'list.dart';
import 'types.dart';

class AcanthisMap<V> extends AcanthisType<Map<String, V>> {
  Map<String, AcanthisType> _fields;

  Map<String, AcanthisType> get fields => _fields;

  bool _passthrough = false;

  AcanthisMap(
    this._fields,
  );

  Map<String, V> _parse(Map<String, V> value) {
    final parsed = <String, V>{};
    if (!_fields.keys.every((element) => value.containsKey(element))) {
      for (var field in _fields.keys) {
        if (!value.containsKey(field)) {
          throw ValidationError('Field $field is required');
        }
      }
    }
    for (var obj in value.entries) {
      if (!_fields.containsKey(obj.key)) {
        if (_passthrough) {
          parsed[obj.key] = obj.value;
          continue;
        }
        throw ValidationError('Field ${obj.key} is not allowed in this object');
      }
      parsed[obj.key] = _fields[obj.key]!.parse(obj.value).value;
    }
    final result = super.parse(parsed);
    return result.value;
  }

  (Map<String, V> values, Map<String, dynamic> errors) _tryParse(
      Map<String, V> value) {
    final parsed = <String, V>{};
    final errors = <String, dynamic>{};
    if (!_fields.keys.every((element) => value.containsKey(element))) {
      for (var field in _fields.keys) {
        if (!value.containsKey(field)) {
          errors[field] = {'required': 'Field is required'};
        }
      }
    }
    for (var obj in value.entries) {
      if (!_fields.containsKey(obj.key)) {
        if (_passthrough) {
          parsed[obj.key] = obj.value;
        }else{
          errors[obj.key] = {'notAllowed': 'Field is not allowed in this object'};
        }
        continue;
      }
      final parsedValue = _fields[obj.key]!.tryParse(obj.value);
      parsed[obj.key] = parsedValue.value;
      errors[obj.key] = parsedValue.errors;
    }
    final result = super.tryParse(parsed);
    return (result.value, errors);
  }

  @override
  AcanthisParseResult<Map<String, V>> parse(Map<String, V> value) {
    final parsed = _parse(value);
    return AcanthisParseResult(value: parsed);
  }

  @override
  AcanthisParseResult<Map<String, V>> tryParse(Map<String, V> value) {
    final (parsed, errors) = _tryParse(value);
    return AcanthisParseResult(
        value: parsed,
        errors: errors,
        success: _recursiveSuccess(errors));
  }

  AcanthisList<Map<String, V>> list() {
    return AcanthisList<Map<String, V>>(this);
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

  AcanthisMap<V> extend(Map<String, AcanthisType> fields) {
    _fields.addAll(fields);
    return this;
  }

  AcanthisMap<V> merge(Map<String, AcanthisType> fields) {
    _fields = {..._fields, ...fields};
    return this;
  }

  AcanthisMap<V> pick(Iterable<String> fields) {
    final newFields = <String, AcanthisType>{};
    for (var field in fields) {
      if (_fields.containsKey(field)) {
        newFields[field] = _fields[field]!;
      }
    }
    _fields = newFields;
    return this;
  }

  AcanthisMap<V> omit(Iterable<String> toOmit) {
    final newFields = <String, AcanthisType>{};
    for (var field in _fields.keys) {
      if (!toOmit.contains(field)) {
        newFields[field] = _fields[field]!;
      }
    }
    _fields = newFields;
    return this;
  }

  AcanthisMap<V> passthrough() {
    _passthrough = true;
    return this;
  }

  AcanthisMap<V> transform(Map<String, V> Function(Map<String, V>) transformation) {
    addTransformation(AcanthisTransformation(transformation: transformation));
    return this;
  }

}

AcanthisMap jsonObject(Map<String, AcanthisType> fields) =>
    AcanthisMap<dynamic>(
      fields,
    );
