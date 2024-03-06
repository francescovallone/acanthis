
import 'package:acanthis/acanthis.dart' as acanthis;

void main(List<String> arguments) {
  final string = acanthis.string();

  string
    .email()
    .min(5)
    .max(10)
    .endsWith('i');

  final jsonObject = acanthis.jsonObject({
    'name': acanthis.string()
      .min(5)
      .max(10),
    'attributes': acanthis.jsonObject({
      'age': acanthis.number()
        .gte(18),
      'email': acanthis.string().email(),
      'style': acanthis.jsonObject({
        'color': acanthis.string()
          .min(3)
          .max(10)
      }),
      'date': acanthis.date()
        .min(DateTime.now())
    }),
  }).passthrough();

  final parsed = jsonObject.parse({
      'name': 'Hello',
      'attributes': {
        'age': 18,
        'email': 'test@t.com',
        'style': {
          'color': 'red',
        },
        'date': DateTime.now()
      },
      'elements': ['Hell', 5],
    });
  final list = acanthis.string().max(5).list().max(2);

  final parsedList = list.tryParse(['Hello', 'World', 'hello']);
  print(parsedList);
}
