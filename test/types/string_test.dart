import 'package:acanthis/acanthis.dart' as acanthis;
import 'package:acanthis/acanthis.dart';
import 'package:test/test.dart';

void main() {
  group('$AcanthisString', () {
    test(
        'when creating a string validator,'
        'and the string is valid, '
        'then the result should be successful', () {
      final string = acanthis.string();
      final result = string.tryParse('test');

      expect(result.success, true);

      final resultParse = string.parse('test');

      expect(resultParse.success, true);
    });

    test(
        'when creating a string validator with a max check,'
        'and the string is greater than the check, '
        'then the result should be successful', () {
      final string = acanthis.string().max(3);
      final result = string.tryParse('tes');

      expect(result.success, true);

      final resultParse = string.parse('tes');

      expect(resultParse.success, true);
    });

    test(
        'when creating a string validator with a max check,'
        'and the string is greater than the check, '
        'then the result should be unsuccessful', () {
      final string = acanthis.string().max(3);
      final result = string.tryParse('test');

      expect(result.success, false);

      expect(
          () => string.parse('test'), throwsA(TypeMatcher<ValidationError>()));
    });

    test(
        'when creating a string validator with a min check,'
        'and the string is less than the check, '
        'then the result should be unsuccessful', () {
      final string = acanthis.string().min(5);
      final result = string.tryParse('test');

      expect(result.success, false);

      expect(
          () => string.parse('test'), throwsA(TypeMatcher<ValidationError>()));
    });

    test(
        'when creating a string validator with a min check,'
        'and the string is less than the check, '
        'then the result should be successful', () {
      final string = acanthis.string().min(3);
      final result = string.tryParse('test');

      expect(result.success, true);

      final resultParse = string.parse('test');

      expect(resultParse.success, true);
    });

    test(
        'when creating a string validator with a min and max check,'
        'and the string is less than the min check, '
        'then the result should be unsuccessful', () {
      final string = acanthis.string().min(5).max(10);
      final result = string.tryParse('test');

      expect(result.success, false);

      expect(
          () => string.parse('test'), throwsA(TypeMatcher<ValidationError>()));
    });

    test(
        'when creating a string validator with a min and max check,'
        'and the string is greater than the max check, '
        'then the result should be unsuccessful', () {
      final string = acanthis.string().min(1).max(3);
      final result = string.tryParse('test');

      expect(result.success, false);

      expect(
          () => string.parse('test'), throwsA(TypeMatcher<ValidationError>()));
    });

    test(
        'when creating a string validator with a min and max check,'
        'and the string is within the min and max check, '
        'then the result should be successful', () {
      final string = acanthis.string().min(1).max(10);
      final result = string.tryParse('test');

      expect(result.success, true);

      final resultParse = string.parse('test');

      expect(resultParse.success, true);
    });

    test(
        'when creating a string validator with a pattern check,'
        'and the string matches the pattern, '
        'then the result should be successful', () {
      final string = acanthis.string().pattern(RegExp(r'^[a-z]+$'));
      final result = string.tryParse('test');

      expect(result.success, true);

      final resultParse = string.parse('test');

      expect(resultParse.success, true);
    });

    test(
        'when creating a string validator with a pattern check,'
        'and the string does not match the pattern, '
        'then the result should be unsuccessful', () {
      final string = acanthis.string().pattern(RegExp(r'^[a-z]+$'));
      final result = string.tryParse('test1');

      expect(result.success, false);

      expect(
          () => string.parse('test1'), throwsA(TypeMatcher<ValidationError>()));
    });

    test(
        'when creating a string validator with a required check,'
        'and the string is empty, '
        'then the result should be unsuccessful', () {
      final string = acanthis.string().required();
      final result = string.tryParse('');

      expect(result.success, false);

      expect(() => string.parse(''), throwsA(TypeMatcher<ValidationError>()));
    });

    test(
        'when creating a string validator with a required check,'
        'and the string is not empty, '
        'then the result should be successful', () {
      final string = acanthis.string().required();
      final result = string.tryParse('test');

      expect(result.success, true);

      final resultParse = string.parse('test');

      expect(resultParse.success, true);
    });

    test(
        'when creating a string validator with an email check,'
        'and the string is a valid email, '
        'then the result should be successful', () {
      final string = acanthis.string().email();
      final result = string.tryParse('test@test.com');

      expect(result.success, true);

      final resultParse = string.parse('test@test.com');

      expect(resultParse.success, true);
    });

    test(
        'when creating a string validator with an email check,'
        'and the string is not a valid email, '
        'then the result should be unsuccessful', () {
      final string = acanthis.string().email();
      final result = string.tryParse('test');

      expect(result.success, false);

      expect(
          () => string.parse('test'), throwsA(TypeMatcher<ValidationError>()));
    });

    test(
        'when creating a string validator with a length check,'
        'and the string length is not the same, '
        'then the result should be unsuccessful', () {
      final string = acanthis.string().length(5);
      final result = string.tryParse('test');

      expect(result.success, false);

      expect(
          () => string.parse('test'), throwsA(TypeMatcher<ValidationError>()));
    });

    test(
        'when creating a string validator with a length check,'
        'and the string length is the same, '
        'then the result should be successful', () {
      final string = acanthis.string().length(4);
      final result = string.tryParse('test');

      expect(result.success, true);

      final resultParse = string.parse('test');

      expect(resultParse.success, true);
    });

    test(
        'when creating a string validator with a contains check,'
        'and the string contains the substring, '
        'then the result should be successful', () {
      final string = acanthis.string().contains('es');
      final result = string.tryParse('test');

      expect(result.success, true);

      final resultParse = string.parse('test');

      expect(resultParse.success, true);
    });

    test(
        'when creating a string validator with a contains check,'
        'and the string does not contain the substring, '
        'then the result should be unsuccessful', () {
      final string = acanthis.string().contains('us');
      final result = string.tryParse('test');

      expect(result.success, false);

      expect(
          () => string.parse('test'), throwsA(TypeMatcher<ValidationError>()));
    });

    test(
        'when creating a string validator with a startsWith check,'
        'and the string does not starts with the substring, '
        'then the result should be successful', () {
      final string = acanthis.string().startsWith('te');
      final result = string.tryParse('test');

      expect(result.success, true);

      final resultParse = string.parse('test');

      expect(resultParse.success, true);
    });

    test(
        'when creating a string validator with a startsWith check,'
        'and the string does not starts with the substring, '
        'then the result should be unsuccessful', () {
      final string = acanthis.string().startsWith('es');
      final result = string.tryParse('test');

      expect(result.success, false);

      expect(
          () => string.parse('test'), throwsA(TypeMatcher<ValidationError>()));
    });

    test(
        'when creating a string validator with a endsWith check,'
        'and the string does not ends with the substring, '
        'then the result should be successful', () {
      final string = acanthis.string().endsWith('st');
      final result = string.tryParse('test');

      expect(result.success, true);

      final resultParse = string.parse('test');

      expect(resultParse.success, true);
    });

    test(
        'when creating a string validator with a endsWith check,'
        'and the string does not ends with the substring, '
        'then the result should be unsuccessful', () {
      final string = acanthis.string().endsWith('es');
      final result = string.tryParse('test');

      expect(result.success, false);

      expect(
          () => string.parse('test'), throwsA(TypeMatcher<ValidationError>()));
    });

    test(
        'when creating a string validator with a custom check,'
        'and the custom check is successful, '
        'then the result should be successful', () {
      final string = acanthis.string().customCheck(
          onCheck: (value) => value == 'test',
          error: 'Value must be test',
          name: 'customCheck');
      final result = string.tryParse('test');

      expect(result.success, true);

      final resultParse = string.parse('test');

      expect(resultParse.success, true);
    });

    test(
        'when creating a string validator with a custom check,'
        'and the custom check is unsuccessful, '
        'then the result should be unsuccessful', () {
      final string = acanthis.string().customCheck(
          onCheck: (value) => value == 'test',
          error: 'Value must be test',
          name: 'customCheck');
      final result = string.tryParse('test1');

      expect(result.success, false);

      expect(
          () => string.parse('test1'), throwsA(TypeMatcher<ValidationError>()));
    });

    test(
        'when creating a string validator with the toUpperCase transformation,'
        'and the string is valid, '
        'then the result should be the string in uppercase', () {
      final string = acanthis.string().toUpperCase();
      final result = string.tryParse('test');

      expect(result.success, true);

      final resultParse = string.parse('test');

      expect(resultParse.success, true);
      expect(resultParse.value, 'TEST');
    });

    test(
        'when creating a string validator with the toLowerCase transformation,'
        'and the string is valid, '
        'then the result should be the string in lowercase', () {
      final string = acanthis.string().toLowerCase();
      final result = string.tryParse('TEST');

      expect(result.success, true);

      final resultParse = string.parse('TEST');

      expect(resultParse.success, true);
      expect(resultParse.value, 'test');
    });

    test(
        'when creating a string validator with the encode transformation,'
        'and the string is valid, '
        'then the result should be the string encoded in base64', () {
      final string = acanthis.string().encode();
      final result = string.tryParse('test');

      expect(result.success, true);

      final resultParse = string.parse('test');

      expect(resultParse.success, true);
      expect(resultParse.value, 'dGVzdA==');
    });

    test(
        'when creating a string validator with the decode transformation,'
        'and the string is valid, '
        'then the result should be the string decoded from base64', () {
      final string = acanthis.string().decode();
      final result = string.tryParse('dGVzdA==');

      expect(result.success, true);

      final resultParse = string.parse('dGVzdA==');

      expect(resultParse.success, true);
      expect(resultParse.value, 'test');
    });
  });
}
