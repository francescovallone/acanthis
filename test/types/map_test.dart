import 'package:acanthis/acanthis.dart' as acanthis;
import 'package:acanthis/acanthis.dart';

import 'package:test/test.dart';

void main() {
  group('$AcanthisMap', () {
    test(
        'when creating a map validator,'
        'and the map is valid, '
        'then the result should be successful', () {
      final map =
          acanthis.object({'key': acanthis.string().min(5).max(20)});
      final result = map.tryParse({'key': 'value'});

      expect(result.success, true);

      final resultParse = map.parse({'key': 'value'});

      expect(resultParse.success, true);
    });

    test(
        'when creating a map validator with a required field,'
        'and the map is missing the required field, '
        'then the result should be unsuccessful', () {
      final map =
          acanthis.object({'key': acanthis.string().min(5).max(20)});
      final result = map.tryParse({});

      expect(result.success, false);

      expect(() => map.parse({}), throwsA(TypeMatcher<ValidationError>()));
    });

    test(
        'when creating a map validator with the passthrough property,'
        'and the parse value contains a non validated key, '
        'then the result should be successful', () {
      final map = acanthis
          .object({'key': acanthis.string().min(5).max(20)}).passthrough();
      final result = map.tryParse({'key': 'value', 'other': 'value'});

      expect(result.success, true);

      final resultParse = map.parse({'key': 'value', 'other': 'value'});

      expect(resultParse.success, true);
    });

    test(
        'when creating a map validator with the passthrough property,'
        'and the parse value contains a non validated key, '
        'then the result should be unsuccessful', () {
      final map =
          acanthis.object({'key': acanthis.string().min(5).max(20)});

      final result = map.tryParse({'key': 'value', 'other': 'value'});

      expect(result.success, false);

      expect(() => map.parse({'key': 'value', 'other': 'value'}),
          throwsA(TypeMatcher<ValidationError>()));
    });

    test(
        'when creating a map validator with the omit property,'
        'and the parse value does not contains a validated key, '
        'then the result should be successful', () {
      final map = acanthis.object({
        'key': acanthis.string().min(5).max(20),
        'other': acanthis.string().min(5).max(20)
      }).omit(['key']);

      final result = map.tryParse({'other': 'value'});

      expect(result.success, true);

      final resultParse = map.parse({'other': 'value'});

      expect(resultParse.success, true);
    });

    test(
        'when creating a map validator with the omit property,'
        'and the parse value contains a validated key, '
        'then the result should be unsuccessful', () {
      final map = acanthis
          .object({'key': acanthis.string().min(5).max(20)}).omit(['key']);

      final result = map.tryParse({'key': 'value'});

      expect(result.success, false);

      expect(() => map.parse({'key': 'value'}),
          throwsA(TypeMatcher<ValidationError>()));
    });

    test(
        'when creating a map validator with the merge property, '
        'and the parse value contains a validated key, '
        'then the result should be successful', () {
      final map = acanthis
          .object({'key': acanthis.string().min(5).max(20)}).merge(
              {'other': acanthis.string().min(5).max(20)});

      final result = map.tryParse({'key': 'value', 'other': 'value'});

      expect(result.success, true);

      final resultParse = map.parse({'key': 'value', 'other': 'value'});

      expect(resultParse.success, true);
    });

    test(
        'when creating a map validator with the merge property, '
        'and the parse value does not contain a validated key, '
        'then the result should be unsuccessful', () {
      final map = acanthis
          .object({'key': acanthis.string().min(5).max(20)}).merge(
              {'other': acanthis.string().min(5).max(20)});

      final result = map.tryParse({'key': 'value'});

      expect(result.success, false);

      expect(() => map.parse({'key': 'value'}),
          throwsA(TypeMatcher<ValidationError>()));
    });

    test(
        'when creating a map validator with the extend property, '
        'and the parse value contains a validated key, '
        'then the result should be successful', () {
      final map = acanthis
          .object({'key': acanthis.string().min(5).max(20)}).extend(
              {'other': acanthis.string().min(5).max(20)});

      final result = map.tryParse({'key': 'value', 'other': 'value'});

      expect(result.success, true);

      final resultParse = map.parse({'key': 'value', 'other': 'value'});

      expect(resultParse.success, true);
    });

    test(
        'when creating a map validator with the extend property, '
        'and the parse value does not contain a validated key, '
        'then the result should be unsuccessful', () {
      final map = acanthis
          .object({'key': acanthis.string().min(5).max(20)}).extend(
              {'other': acanthis.string().min(5).max(20)});

      final result = map.tryParse({'key': 'value'});

      expect(result.success, false);

      expect(() => map.parse({'key': 'value'}),
          throwsA(TypeMatcher<ValidationError>()));
    });

    test(
        'when creating a map validator with the pick property, '
        'and the parse value contains a validated key, '
        'then the result should be successful', () {
      final map = acanthis
          .object({'key': acanthis.string().min(5).max(20)}).pick(['key']);

      final result = map.tryParse({'key': 'value'});

      expect(result.success, true);

      final resultParse = map.parse({'key': 'value'});

      expect(resultParse.success, true);
    });

    test(
        'when creating a map validator with the pick property, '
        'and the parse value does not contain a validated key, '
        'then the result should be unsuccessful', () {
      final map = acanthis
          .object({'key': acanthis.string().min(5).max(20)}).pick(['key']);

      final result = map.tryParse({'other': 'value'});

      expect(result.success, false);

      expect(() => map.parse({'other': 'value'}),
          throwsA(TypeMatcher<ValidationError>()));
    });

    test(
        'when creating a map validator with a custom transformation,'
        'and all the elements in the map are valid, '
        'and the map itself is valid, '
        'then the result should be transformed', () {
      final map = acanthis.object({
        'key': acanthis.string().min(5).max(20),
      }).transform((value) => value
          .map((key, value) => MapEntry(key, value.toString().toUpperCase())));

      final result = map.tryParse({'key': 'value'});

      expect(result.success, true);

      final resultParse = map.parse({'key': 'value'});

      expect(resultParse.success, true);
      expect(resultParse.value['key'], 'VALUE');
    });

    test(
        'when creating a map validator for a complex object,'
        'and the map is valid, '
        'then the result should be successful', () {
      final object = acanthis.object({
        'name': acanthis.string().min(5).max(10).encode(),
        'attributes': acanthis.object({
          'age': acanthis.number().gte(18),
          'email': acanthis.string().email(),
          'style': acanthis.object({
            'color': acanthis
                .string()
                .min(3)
                .max(10)
                .transform((value) => value.toUpperCase())
          }),
          'date': acanthis.date().min(DateTime.now())
        }),
      }).passthrough();

      final parsed = object.parse({
        'name': 'Hello',
        'attributes': {
          'age': 18,
          'email': 'test@gmail.com',
          'style': {
            'color': 'red',
          },
          'date': DateTime.now()
        },
        'elements': ['Hell', 5],
      });

      expect(parsed.success, true);
    });

    test(
        'when creating a map validator for a complex object, '
        'and use the list method, '
        'and all the values are valid, '
        'then the result should be successful', () {
      final object = acanthis
          .object({
            'name': acanthis.string().min(5).max(10).encode(),
            'attributes': acanthis.object({
              'age': acanthis.number().gte(18),
              'email': acanthis.string().email(),
              'style': acanthis.object({
                'color': acanthis
                    .string()
                    .min(3)
                    .max(10)
                    .transform((value) => value.toUpperCase())
              }),
              'date': acanthis.date().min(DateTime.now())
            }),
          })
          .passthrough()
          .list();

      object.parse([
        {
          'name': 'Hello',
          'attributes': {
            'age': 18,
            'email': 'test@test.com',
            'style': {
              'color': 'red',
            },
            'date': DateTime.now()
          },
          'elements': ['Hell', 5],
        },
        {
          'name': 'Hello',
          'attributes': {
            'age': 18,
            'email': 'test@example.com',
            'style': {
              'color': 'red',
            },
            'date': DateTime.now()
          },
          'elements': ['Hell', 5],
        }
      ]);
    });

    test(
        'when creating a map validator for a complex object, '
        'and use the keys getter, '
        'then the not nested keys should be returned', () {
      final object = acanthis.object({
        'name': acanthis.string().min(5).max(10).encode(),
        'attributes': acanthis.object({
          'age': acanthis.number().gte(18),
          'email': acanthis.string().email(),
          'style': acanthis.object({
            'color': acanthis
                .string()
                .min(3)
                .max(10)
                .transform((value) => value.toUpperCase())
          }),
          'date': acanthis.date().min(DateTime.now())
        }),
      }).passthrough();
      expect(object.keys, ['name', 'attributes']);
    });
  });
}
