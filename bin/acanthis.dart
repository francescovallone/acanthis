
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
    'elements': acanthis.dynamicList(
      [
        acanthis.string().min(3).max(10),
        acanthis.number().gte(5)
      ]
    ).min(2).max(5)
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
    print(parsed);

  final list = acanthis.dynamicList(
    [
      acanthis.string().min(3).max(10),
      acanthis.number().gte(5)
    ]
  ).min(2).max(5);

  final parsedList = list.tryParse(['Hell', 5]);
  print(parsedList);
}
