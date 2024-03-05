// Import BenchmarkBase class.
import 'dart:io';

import 'package:acanthis/acanthis.dart';

import 'shared/acanthis_benchmark.dart';

class LongStringValidationBenchmark extends AcanthisBenchmark {
  LongStringValidationBenchmark() : super(name: 'LongStringValidationBenchmark');

  static void main() {
    LongStringValidationBenchmark().report();
  }

  @override
  void run() {
    string().parse('long' * 256);
  }

}

class FixedLengthStringValidationBenchmark extends AcanthisBenchmark {
  FixedLengthStringValidationBenchmark() : super(name: 'FixedLengthStringValidationBenchmark');

  static void main() {
    FixedLengthStringValidationBenchmark().report();
  }

  @override
  void run() {
    string().max(5).min(1).parse('long');
  }

}

class EmptyStringValidationBenchmark extends AcanthisBenchmark {
  EmptyStringValidationBenchmark() : super(name: 'EmptyStringValidationBenchmark');

  static void main() {
    EmptyStringValidationBenchmark().report();
  }

  @override
  void run() {
    string().parse('');
  }

}

void main() {
  File('acanthis_benchmark.csv').writeAsStringSync(
    'name, total, avg, iters\n'
  );
  LongStringValidationBenchmark.main();
  FixedLengthStringValidationBenchmark.main();
  EmptyStringValidationBenchmark.main();
}