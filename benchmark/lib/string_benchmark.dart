// Import BenchmarkBase class.
import 'package:acanthis/acanthis.dart';
import 'package:luthor/luthor.dart';

import 'shared/acanthis_benchmark.dart';

class LongStringValidationBenchmark extends AcanthisBenchmark {
  LongStringValidationBenchmark()
      : super(name: 'LongStringValidationBenchmark');

  static void main() {
    LongStringValidationBenchmark().report();
  }

  @override
  void run() {
    string().parse('long' * 256);
  }
}

class LongLuthorStringValidationBenchmark extends AcanthisBenchmark {
  LongLuthorStringValidationBenchmark()
      : super(name: 'LongLuthorStringValidationBenchmark');

  static void main() {
    LongLuthorStringValidationBenchmark().report();
  }

  @override
  void run() {
    l.string().validateValue('long' * 256);
  }
}

class FixedLengthStringValidationBenchmark extends AcanthisBenchmark {
  FixedLengthStringValidationBenchmark()
      : super(name: 'FixedLengthStringValidationBenchmark');

  static void main() {
    FixedLengthStringValidationBenchmark().report();
  }

  @override
  void run() {
    string().max(5).min(1).parse('long');
  }
}

class FixedLuthorLengthStringValidationBenchmark extends AcanthisBenchmark {
  FixedLuthorLengthStringValidationBenchmark()
      : super(name: 'FixedLuthorLengthStringValidationBenchmark');

  static void main() {
    FixedLuthorLengthStringValidationBenchmark().report();
  }

  @override
  void run() {
    l.string().max(5).min(1).validateValue('long');
  }
}

class EmptyStringValidationBenchmark extends AcanthisBenchmark {
  EmptyStringValidationBenchmark()
      : super(name: 'EmptyStringValidationBenchmark');

  static void main() {
    EmptyStringValidationBenchmark().report();
  }

  @override
  void run() {
    string().parse('');
  }
}

class EmptyLuthorStringValidationBenchmark extends AcanthisBenchmark {
  EmptyLuthorStringValidationBenchmark()
      : super(name: 'EmptyLuthorStringValidationBenchmark');

  static void main() {
    EmptyLuthorStringValidationBenchmark().report();
  }

  @override
  void run() {
    l.string().validateValue('');
  }
}


class StringBenchmarks {
  static void main() {
    print("Running Acanthis String benchmarks");
    LongStringValidationBenchmark.main();
    FixedLengthStringValidationBenchmark.main();
    EmptyStringValidationBenchmark.main();
    print("Running Luthor String benchmarks");
    LongLuthorStringValidationBenchmark.main();
    FixedLuthorLengthStringValidationBenchmark.main();
    EmptyLuthorStringValidationBenchmark.main();
    print("String benchmarks complete");
  }
}
