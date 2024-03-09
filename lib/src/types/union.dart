import 'types.dart';
import '../exceptions/validation_error.dart';

class AcanthisUnion extends AcanthisType<dynamic> {
  final List<AcanthisType> elements;

  AcanthisUnion(this.elements);

  @override
  AcanthisParseResult<dynamic> parse(dynamic value) {
    for (var element in elements) {
      try {
        final result = element.tryParse(value);
        if (result.success) {
          return result;
        }
      } catch (_) {}
    }
    throw ValidationError('Value does not match any of the elements');
  }

  @override
  AcanthisParseResult<dynamic> tryParse(dynamic value) {
    for (var element in elements) {
      try {
        final result = element.tryParse(value);
        if (result.success) {
          return result;
        }
      } catch (_) {}
    }
    return AcanthisParseResult(
        value: value,
        errors: {'union': 'Value does not match any of the elements'},
        success: false);
  }
}

/// A class that represents a transformation operation
AcanthisUnion union(List<AcanthisType> elements) {
  return AcanthisUnion(elements);
}
