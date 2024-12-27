import 'dart:collection';

import '../exceptions/validation_error.dart';
import 'list.dart';
import 'types.dart';

/// A class to validate map types
class AcanthisMap<V> extends AcanthisType<Map<String, V>> {
  Map<String, AcanthisType> _fields;

  Map<String, AcanthisType> get fields => UnmodifiableMapView(_fields);

  bool _passthrough = false;
  final List<_Dependency> _dependencies = [];
  final List<String> _optionalFields = [];

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
      final dependFrom = _keyQuery(dependency.dependendsOn, value);
      final dependTo = _keyQuery(dependency.dependent, value);
      if (dependFrom != null && dependTo != null) {
        if (!dependency.dependency(dependFrom, dependTo)) {
          throw ValidationError(
              'Dependency not met: ${dependency.dependendsOn}->${dependency.dependent}');
        }
      } else {
        throw ValidationError(
            'The dependency or dependFrom field does not exist in the map');
      }
    }
    final result = super.parse(parsed);
    return result.value;
  }

  Future<Map<String, V>> _asyncParse(Map<String, V> value) async {
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
      final result = await _fields[obj.key]!.parseAsync(obj.value);
      parsed[obj.key] = result.value;
    }
    for (var dependency in _dependencies) {
      final dependFrom = _keyQuery(dependency.dependendsOn, value);
      final dependTo = _keyQuery(dependency.dependent, value);
      if (dependFrom != null && dependTo != null) {
        if (!dependency.dependency(dependFrom, dependTo)) {
          throw ValidationError(
              'Dependency not met: ${dependency.dependendsOn}->${dependency.dependent}');
        }
      } else {
        throw ValidationError(
            'The dependency or dependFrom field does not exist in the map');
      }
    }
    final result = await super.parseAsync(parsed);
    return result.value;
  }

  (Map<String, V> values, Map<String, dynamic> errors) _tryParse(
      Map<String, V> value) {
    final parsed = <String, V>{};
    final errors = <String, dynamic>{};
    if (!_fields.keys.every((element) =>
        value.containsKey(element) || _optionalFields.contains(element))) {
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
      final dependFrom = _keyQuery(dependency.dependendsOn, value);
      final dependTo = _keyQuery(dependency.dependent, value);
      if (dependFrom != null && dependTo != null) {
        if (!dependency.dependency(dependFrom, dependTo)) {
          errors[dependency.dependent] = {'dependency': 'Dependency not met'};
        }
      } else {
        errors[dependency.dependent] = {
          'dependency[${dependency.dependendsOn}->${dependency.dependent}]':
              'The dependency or dependFrom field does not exist in the map'
        };
      }
    }
    return (result.value, errors);
  }

  Future<({Map<String, V> values, Map<String, dynamic> errors})> _tryParseAsync(
      Map<String, V> value) async {
    final parsed = <String, V>{};
    final errors = <String, dynamic>{};
    if (!_fields.keys.every((element) =>
        value.containsKey(element) || _optionalFields.contains(element))) {
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
      final parsedValue = await _fields[obj.key]!.tryParseAsync(obj.value);
      parsed[obj.key] = parsedValue.value;
      errors[obj.key] = parsedValue.errors;
    }
    final result = await super.tryParseAsync(parsed);
    for (var dependency in _dependencies) {
      final dependFrom = _keyQuery(dependency.dependendsOn, value);
      final dependTo = _keyQuery(dependency.dependent, value);
      if (dependFrom != null && dependTo != null) {
        if (!dependency.dependency(dependFrom, dependTo)) {
          errors[dependency.dependent] = {'dependency': 'Dependency not met'};
        }
      } else {
        errors[dependency.dependent] = {
          'dependency[${dependency.dependendsOn}->${dependency.dependent}]':
              'The dependency or dependFrom field does not exist in the map'
        };
      }
    }
    return (values: result.value, errors: errors);
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

  /// Add optional fields to the map
  ///
  /// The optionals are valid only for the current layer of the object
  AcanthisMap<V> optionals(List<String> fields) {
    _optionalFields.addAll(fields);
    return this;
  }

  /// Override of [parse] from [AcanthisType]
  @override
  AcanthisParseResult<Map<String, V>> parse(Map<String, V> value) {
    final hasAsyncOperations = operations.any((element) => element is AcanthisAsyncCheck);
    if(hasAsyncOperations) {
      throw Exception('Cannot use tryParse with async operations');
    }
    final parsed = _parse(value);
    return AcanthisParseResult(value: parsed);
  }

  @override
  Future<AcanthisParseResult<Map<String, V>>> parseAsync(Map<String, V> value) async {
    final parsed = await _asyncParse(value);
    return AcanthisParseResult(value: parsed);
  }

  @override
  Future<AcanthisParseResult<Map<String, V>>> tryParseAsync(Map<String, V> value) async {
    final parsed = await _tryParseAsync(value);
    return AcanthisParseResult(value: parsed.values, errors: parsed.errors, success: _recursiveSuccess(parsed.errors));
  }

  /// Override of [tryParse] from [AcanthisType]
  @override
  AcanthisParseResult<Map<String, V>> tryParse(Map<String, V> value) {
    final hasAsyncOperations = operations.any((element) => element is AcanthisAsyncCheck);
    if(hasAsyncOperations) {
      throw Exception('Cannot use tryParse with async operations');
    }
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
    required String dependent,
    required String dependendsOn,
    required bool Function(dynamic, dynamic) dependency,
  }) {
    _dependencies.add(_Dependency(dependent, dependendsOn, dependency));
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

  AcanthisMap<V?> partial({bool deep = false}) {
    if (deep) {
      return AcanthisMap<V?>(_fields.map((key, value) {
        if(value is AcanthisMap) {
          return MapEntry(key, value.partial(deep: deep));
        }
        return MapEntry(key, value.nullable());
      }));
    }
    return AcanthisMap<V?>(_fields.map((key, value) => MapEntry(key, value.nullable())));
  }

  /// Add a transformation to the map to transform it using [transformation]
  AcanthisMap<V> transform(
      Map<String, V> Function(Map<String, V>) transformation) {
    addTransformation(AcanthisTransformation(transformation: transformation));
    return this;
  }

}

/// Create a map of [fields]
AcanthisMap object(Map<String, AcanthisType> fields) => AcanthisMap<dynamic>(
      fields,
    );

class _Dependency {
  final String dependent;
  final String dependendsOn;
  final bool Function(dynamic, dynamic) dependency;

  _Dependency(this.dependent, this.dependendsOn, this.dependency);
}
