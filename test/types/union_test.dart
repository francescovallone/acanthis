import 'package:acanthis/acanthis.dart';
import 'package:test/test.dart';

void main() {
  group('$AcanthisUnion', () {
    test(
        'when creating a union validator with a string and a number,'
        'and the value is a string, '
        'then the result should be successful', () {
      final u = union([string(), number()]);
      final result = u.tryParse('This is a test');

      expect(result.success, true);

      final resultParse = u.parse('This is a test');

      expect(resultParse.success, true);
    });

    test(
        'when creating a union validator with a string and a number,'
        'and the value is a number, '
        'then the result should be successful', () {
      final u = union([string(), number()]);
      final result = u.tryParse(1);

      expect(result.success, true);

      final resultParse = u.parse(1);

      expect(resultParse.success, true);
    });

    test(
        'when creating a union validator with a string and a number,'
        'and the value is a boolean, '
        'then the result should be unsuccessful', () {
      final u = union([string(), number()]);
      final result = u.tryParse(true);

      expect(result.success, false);

      expect(() => u.parse(true), throwsA(isA<ValidationError>()));
    });

    test(
        'when creating a string validator, '
        'and use the [or] method to create a union with a number,'
        'and the value is a string, '
        'then the result should be successful', () {
      final u = string().or([number()]);
      final result = u.tryParse('This is a test');

      expect(result.success, true);

      final resultParse = u.parse('This is a test');

      expect(resultParse.success, true);
    });

    test(
        'when creating a string validator with checks, '
        'and use the [or] method to create a union with a number,'
        'and the value is a valid string, '
        'then the result should be successful', () {
      final u = string().max(5).or([number()]);
      final result = u.tryParse('This');

      expect(result.success, true);

      final resultParse = u.parse('This');

      expect(resultParse.success, true);
    });

    test(
        'when creating a string validator with checks, '
        'and use the [or] method to create a union with a number,'
        'and the value is an invalid string, '
        'then the result should be unsuccessful', () {
      final u = string().max(5).or([number()]);
      final result = u.tryParse('This is a test');

      expect(result.success, false);

      expect(() => u.parse('This is a test'), throwsA(isA<ValidationError>()));
    });

    test(
        'when creating a number validator, '
        'and use the [or] method to create a union with a string,'
        'and the value is a number, '
        'then the result should be successful', () {
      final u = number().or([string()]);
      final result = u.tryParse(1);

      expect(result.success, true);

      final resultParse = u.parse(1);

      expect(resultParse.success, true);
    });

    test(
        'when creating a date validator, '
        'and use the [or] method to create a union with a string,'
        'and the value is a valid date, '
        'then the result should be successful', () {
      final u = date().or([string()]);
      final result = u.tryParse(DateTime.now());

      expect(result.success, true);

      final resultParse = u.parse(DateTime.now());

      expect(resultParse.success, true);
    });

    test(
        'when creating a boolean validator, '
        'and use the [or] method to create a union with a string,'
        'and the value is a valid bool, '
        'then the result should be successful', () {
      final u = boolean().or([string()]);
      final result = u.tryParse(false);

      expect(result.success, true);

      final resultParse = u.parse(false);

      expect(resultParse.success, true);
    });

    test(
        'when creating a nullable string validator, '
        'and use the [or] method to create a union with a number,'
        'and the value is null, '
        'then the result should be successful', () {
      final u = string().nullable().or([number()]);
      final result = u.tryParse(null);

      expect(result.success, true);

      final resultParse = u.parse(null);

      expect(resultParse.success, true);
    });
  });
}
