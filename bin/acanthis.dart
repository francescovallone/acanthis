import 'package:acanthis/acanthis.dart' as acanthis;

void main(List<String> arguments) {
  final string = acanthis.string();

  string.email().min(5).max(10).endsWith('i');

  final jsonObject = acanthis.jsonObject({
    'name': acanthis.string().min(5).max(10).encode(),
    'attributes': acanthis.jsonObject({
      'age': acanthis.number().gte(18),
      'email': acanthis.string().email(),
      'style': acanthis.jsonObject({'color': acanthis.string().min(3).max(10)}),
      'date': acanthis.date().min(DateTime.now())
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
  final list = acanthis
      .string()
      .max(5)
      .list()
      .max(3)
      .transform((value) => value.map((e) => e.toUpperCase()).toList());

  final parsedList = list.tryParse(['Hello', 'World', 'hello']);

  final number = acanthis.number().pow(2).gte(5);
  print(number.tryParse(3));
  print(parsed);
  print(parsedList);

  final union = acanthis.union([
    acanthis.number(),
    acanthis.string(),
  ]);

  print(union.tryParse(DateTime.now()));
}
