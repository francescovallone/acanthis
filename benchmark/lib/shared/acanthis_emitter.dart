import 'package:benchmark_harness/benchmark_harness.dart';

class AcanthisEmitter extends ScoreEmitter {
  final String groupName;
  final int iterations;

  AcanthisEmitter({this.groupName = 'acanthis', this.iterations = 100});

  @override
  void emit(String testName, double value) {
    print('$testName -> $value, $iterations');
  }
}
