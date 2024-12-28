import 'package:acanthis/acanthis.dart';

/// A class to validate nullable types
class AcanthisNullable<T> extends AcanthisType<T?> {
  /// The default value of the nullable
  final T? defaultValue;

  /// The element of the nullable
  final AcanthisType<T> element;

  AcanthisNullable(this.element, {this.defaultValue});

  /// override of the [parse] method from [AcanthisType]
  @override
  AcanthisParseResult<T?> parse(T? value) {
    if (value == null) {
      return AcanthisParseResult(value: defaultValue);
    }
    return element.parse(value);
  }

  /// override of the [tryParse] method from [AcanthisType]
  @override
  AcanthisParseResult<T?> tryParse(T? value) {
    if (value == null) {
      return AcanthisParseResult(value: defaultValue);
    }
    return element.tryParse(value);
  }

  @override
  Future<AcanthisParseResult<T?>> parseAsync(T? value) async {
    if (value == null) {
      return AcanthisParseResult(value: defaultValue);
    }
    return element.parseAsync(value);
  }

  @override
  Future<AcanthisParseResult<T?>> tryParseAsync(T? value) async {
    if (value == null) {
      return AcanthisParseResult(value: defaultValue);
    }
    return super.tryParseAsync(value);
  }

  /// Make a list of nullable elements
  AcanthisList<T?> list() {
    return AcanthisList(this);
  }

  /// Create a union from the nullable
  AcanthisUnion or(List<AcanthisType> elements) {
    return AcanthisUnion([this, ...elements]);
  }

  @override
  AcanthisNullable nullable({T? defaultValue}) {
    return this;
  }
}
