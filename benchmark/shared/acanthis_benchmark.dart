import 'package:benchmark_harness/benchmark_harness.dart';

import 'acanthis_emitter.dart';

class AcanthisBenchmark extends BenchmarkBase {

  final int iterations;

  AcanthisBenchmark({
    String name = 'AcanthisBenchmark',
    this.iterations = 100,
  }) : super(name, emitter: AcanthisEmitter());

  @override
  void exercise() {
    for (var i = 0; i < iterations; i++) {
      run();
    }
  }

}