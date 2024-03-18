import 'dart:collection';

import '../exceptions/validation_error.dart';
import 'list.dart';
import 'nullable.dart';
import 'types.dart';

/// A class to validate map types
class AcanthisMap<V> extends AcanthisType<Map<String, V>> {
  Map<String, AcanthisType> _fields;

  Map<String, AcanthisType> get fields => UnmodifiableMapView(_fields);

  bool _passthrough = false;
  final List<_Dependency> _dependencies = [];

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
    for (var dependency in _dependencies) {
      final dependFrom = _keyQuery(dependency.dependFrom, value);
      final dependTo = _keyQuery(dependency.dependency, value);
      if (dependFrom != null && dependTo != null) {
        if (!dependency.condition(dependFrom, dependTo)) {
          throw ValidationError(
              'Dependency not met: ${dependency.dependFrom}->${dependency.dependency}');
        }
      } else {
        throw ValidationError(
            'The dependency or dependFrom field does not exist in the map');
      }
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
        } else {
          errors[obj.key] = {
            'notAllowed': 'Field is not allowed in this object'
          };
        }
        continue;
      }
      final parsedValue = _fields[obj.key]!.tryParse(obj.value);
      parsed[obj.key] = parsedValue.value;
      errors[obj.key] = parsedValue.errors;
    }
    final result = super.tryParse(parsed);
    for (var dependency in _dependencies) {
      final dependFrom = _keyQuery(dependency.dependFrom, value);
      final dependTo = _keyQuery(dependency.dependency, value);
      if (dependFrom != null && dependTo != null) {
        if (!dependency.condition(dependFrom, dependTo)) {
          errors[dependency.dependency] = {'dependency': 'Dependency not met'};
        }
      } else {
        errors[dependency.dependency] = {
          'dependency[${dependency.dependFrom}->${dependency.dependency}]':
              'The dependency or dependFrom field does not exist in the map'
        };
      }
    }
    return (result.value, errors);
  }

  dynamic _keyQuery(String key, Map<String, V> value) {
    final keys = key.split('.');
    dynamic result = value;
    for (var k in keys) {
      if (result is Map<String, dynamic>) {
        if (result.containsKey(k)) {
          result = result[k];
        } else {
          return null;
        }
      } else {
        return null;
      }
    }
    return result;
  }

  /// Override of [parse] from [AcanthisType]
  @override
  AcanthisParseResult<Map<String, V>> parse(Map<String, V> value) {
    final parsed = _parse(value);
    return AcanthisParseResult(value: parsed);
  }

  /// Override of [tryParse] from [AcanthisType]
  @override
  AcanthisParseResult<Map<String, V>> tryParse(Map<String, V> value) {
    final (parsed, errors) = _tryParse(value);
    return AcanthisParseResult(
        value: parsed, errors: errors, success: _recursiveSuccess(errors));
  }

  /// Create a list of maps
  AcanthisList<Map<String, V>> list() {
    return AcanthisList<Map<String, V>>(this);
  }

  /// Add a field dependency to the map to validate the map based on the [condition]
  /// [dependency] is the field that depends on [dependFrom]
  AcanthisMap<V> addFieldDependency({
    required String dependency,
    required String dependFrom,
    required bool Function(dynamic, dynamic) condition,
  }) {
    _dependencies.add(_Dependency(dependency, dependFrom, condition));
    return this;
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

  /// Add field(s) to the map
  AcanthisMap<V> extend(Map<String, AcanthisType> fields) {
    _fields.addAll(fields);
    return this;
  }

  /// Merge field(s) to the map
  /// if a field already exists, it will be overwritten
  AcanthisMap<V> merge(Map<String, AcanthisType> fields) {
    _fields = {..._fields, ...fields};
    return this;
  }

  /// Pick field(s) from the map
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

  /// Omit field(s) from the map
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

  /// Allow unknown keys in the map
  AcanthisMap<V> passthrough() {
    _passthrough = true;
    return this;
  }

  /// Add a transformation to the map to transform it using [transformation]
  AcanthisMap<V> transform(
      Map<String, V> Function(Map<String, V>) transformation) {
    addTransformation(AcanthisTransformation(transformation: transformation));
    return this;
  }

  /// Make the value nullable
  AcanthisNullable<Map<String, V>> nullable({Map<String, V>? defaultValue}) {
    return AcanthisNullable(this, defaultValue: defaultValue);
  }
}

/// Create a map of [fields]
AcanthisMap object(Map<String, AcanthisType> fields) => AcanthisMap<dynamic>(
      fields,
    );

class _Dependency {
  final String dependency;
  final String dependFrom;
  final bool Function(dynamic, dynamic) condition;

  _Dependency(this.dependency, this.dependFrom, this.condition);
}
