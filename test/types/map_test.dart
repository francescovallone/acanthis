import 'package:acanthis/acanthis.dart' as acanthis;
import 'package:acanthis/src/exceptions/validation_error.dart';

import 'package:acanthis/src/types/map.dart';import 'package:test/test.dart';

void main() {

  group(
    '$AcanthisMap', 
    () {
      test(
        'when creating a map validator,'
        'and the map is valid, '
        'then the result should be successful', 
        () {
        final map = acanthis.jsonObject({
          'key': acanthis.string().min(5).max(20)
        });
        final result = map.tryParse({'key': 'value'});

        expect(result.success, true);

        final resultParse = map.parse({'key': 'value'});

        expect(resultParse.success, true);
      });

      test(
        'when creating a map validator with a required field,'
        'and the map is missing the required field, '
        'then the result should be unsuccessful',
        () {
          final map = acanthis.jsonObject({
            'key': acanthis.string().min(5).max(20)
          });
          final result = map.tryParse({});

          expect(result.success, false);

          expect(() => map.parse({}), throwsA(TypeMatcher<ValidationError>()));
        }
      );

      test(
        'when creating a map validator with the passthrough property,'
        'and the parse value contains a non validated key, '
        'then the result should be successful',
        () {
          final map = acanthis.jsonObject({
            'key': acanthis.string().min(5).max(20)
          }).passthrough();
          final result = map.tryParse({
            'key': 'value',
            'other': 'value'
          });

          expect(result.success, true);

          final resultParse = map.parse({
            'key': 'value',
            'other': 'value'
          });

          expect(resultParse.success, true);

        }
      );

      test(
        'when creating a map validator with the passthrough property,'
        'and the parse value contains a non validated key, '
        'then the result should be unsuccessful',
        () {
          final map = acanthis.jsonObject({
            'key': acanthis.string().min(5).max(20)
          });
          
          final result = map.tryParse({
            'key': 'value',
            'other': 'value'
          });

          expect(result.success, false);

          expect(() => map.parse({
            'key': 'value',
            'other': 'value'
          }), throwsA(TypeMatcher<ValidationError>()));
        }
      );

      test(
        'when creating a map validator with the omit property,'
        'and the parse value does not contains a validated key, '
        'then the result should be successful',
        () {
          final map = acanthis.jsonObject({
            'key': acanthis.string().min(5).max(20)
          }).omit(['key']);

          final result = map.tryParse({});

          expect(result.success, true);

          final resultParse = map.parse({});

          expect(resultParse.success, true);
        }
      );

      test(
        'when creating a map validator with the omit property,'
        'and the parse value contains a validated key, '
        'then the result should be unsuccessful',
        () {
          final map = acanthis.jsonObject({
            'key': acanthis.string().min(5).max(20)
          }).omit(['key']);

          final result = map.tryParse({'key': 'value'});

          expect(result.success, false);

          expect(() => map.parse({'key': 'value'}), throwsA(TypeMatcher<ValidationError>()));
        }
      );

      test(
        'when creating a map validator with the merge property, '
        'and the parse value contains a validated key, '
        'then the result should be successful',
        () {
          final map = acanthis.jsonObject({
            'key': acanthis.string().min(5).max(20)
          }).merge({
            'other': acanthis.string().min(5).max(20)
          });

          final result = map.tryParse({
            'key': 'value',
            'other': 'value'
          });

          expect(result.success, true);

          final resultParse = map.parse({
            'key': 'value',
            'other': 'value'
          });

          expect(resultParse.success, true);
        }
      );

      test(
        'when creating a map validator with the merge property, '
        'and the parse value does not contain a validated key, '
        'then the result should be unsuccessful',
        () {
          final map = acanthis.jsonObject({
            'key': acanthis.string().min(5).max(20)
          }).merge({
            'other': acanthis.string().min(5).max(20)
          });

          final result = map.tryParse({
            'key': 'value'
          });

          expect(result.success, false);

          expect(() => map.parse({
            'key': 'value'
          }), throwsA(TypeMatcher<ValidationError>()));
        }
      );

      test(
        'when creating a map validator with the extend property, '
        'and the parse value contains a validated key, '
        'then the result should be successful',
        () {
          final map = acanthis.jsonObject({
            'key': acanthis.string().min(5).max(20)
          }).extend({
            'other': acanthis.string().min(5).max(20)
          });

          final result = map.tryParse({
            'key': 'value',
            'other': 'value'
          });

          expect(result.success, true);

          final resultParse = map.parse({
            'key': 'value',
            'other': 'value'
          });

          expect(resultParse.success, true);
        }
      );

      test(
        'when creating a map validator with the extend property, '
        'and the parse value does not contain a validated key, '
        'then the result should be unsuccessful',
        () {
          final map = acanthis.jsonObject({
            'key': acanthis.string().min(5).max(20)
          }).extend({
            'other': acanthis.string().min(5).max(20)
          });

          final result = map.tryParse({
            'key': 'value'
          });

          expect(result.success, false);

          expect(() => map.parse({
            'key': 'value'
          }), throwsA(TypeMatcher<ValidationError>()));
        }
      );

      test(
        'when creating a map validator with the pick property, '
        'and the parse value contains a validated key, '
        'then the result should be successful',
        () {
          final map = acanthis.jsonObject({
            'key': acanthis.string().min(5).max(20)
          }).pick(['key']);

          final result = map.tryParse({
            'key': 'value'
          });

          expect(result.success, true);

          final resultParse = map.parse({
            'key': 'value'
          });

          expect(resultParse.success, true);
        }
      );

      test(
        'when creating a map validator with the pick property, '
        'and the parse value does not contain a validated key, '
        'then the result should be unsuccessful',
        () {
          final map = acanthis.jsonObject({
            'key': acanthis.string().min(5).max(20)
          }).pick(['key']);

          final result = map.tryParse({
            'other': 'value'
          });

          expect(result.success, false);

          expect(() => map.parse({
            'other': 'value'
          }), throwsA(TypeMatcher<ValidationError>()));
        }
      );

    }
  );

}