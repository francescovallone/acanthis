import 'package:acanthis/acanthis.dart';

class AcanthisNullable<T> extends AcanthisType<T?> {

  final T? defaultValue;

  final AcanthisType<T> element;

  AcanthisNullable(this.element, {
    this.defaultValue
  });

  @override
  AcanthisParseResult<T?> parse(T? value) {
    if (value == null) {
      return AcanthisParseResult(value: defaultValue);
    }
    return element.parse(value);
  }

  @override
  AcanthisParseResult<T?> tryParse(T? value) {
    if (value == null) {
      return AcanthisParseResult(value: defaultValue);
    }
    return element.tryParse(value);
  }

  AcanthisList<T?> list() {
    return AcanthisList(this);
  }

}