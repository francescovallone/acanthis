import 'dart:io';

import 'string_benchmark.dart';

void main(){
  File('acanthis_benchmark.csv').writeAsStringSync(
    'name, total, avg, iters\n'
  );

  StringBenchmarks.main();
}