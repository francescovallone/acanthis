import 'package:acanthis/acanthis.dart' as acanthis;

void main(List<String> arguments) async {
  final string = acanthis.string();

  string.email().min(5).max(10).endsWith('i');

  final jsonObject = acanthis
      .object({
        'name': acanthis.string().min(5).max(10).encode(),
        'attributes': acanthis.object({
          'age': acanthis.number().gte(18),
          'email': acanthis.string().email(),
          'style': acanthis.object({'color': acanthis.string().min(3).max(10)}),
          'date': acanthis.date().min(DateTime.now())
        }),
      })
      .passthrough()
      .addFieldDependency(
          dependent: 'name',
          dependendsOn: 'attributes.age',
          dependency: (age, name) {
            return name.length < age;
          });

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

  // final schema = acanthis.object({
  //   'email': acanthis.string().email(),
  //   'password': acanthis.string().min(8).allCharacters().mixedCase().uncompromised(),
  //   'confirmPassword': acanthis.string().min(8).allCharacters().mixedCase().uncompromised()
  // }).addFieldDependency(
  //   dependent: 'password',
  //   dependendsOn: 'confirmPassword',
  //   dependency: (password, confirmPassword) => password == confirmPassword
  // );

  // final result = await schema.tryParseAsync({
  //   'email': 'test@example.com',
  //   'password': r'Nq;CRa7rZ)%pGm5$MB_j].',
  //   'confirmPassword': r'Nq;CRa7rZ)%pGm5$MB_j].'
  // });

  // print(result);

  final stringDate = acanthis.string().pipe(
        acanthis.date().min(DateTime.now()),
        transform: (value) => DateTime.parse(value),
      );
  final result = stringDate.tryParse('aaaaa');
  print(result);
  return;
}
