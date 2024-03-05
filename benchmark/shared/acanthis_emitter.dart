import 'package:benchmark_harness/benchmark_harness.dart';
import 'dart:io';

class AcanthisEmitter extends ScoreEmitter{

  final String groupName;
  final int iterations;

  AcanthisEmitter({this.groupName = 'acanthis', this.iterations = 100});

  @override
  void emit(String testName, double value) {
    File('${groupName}_benchmark.csv').writeAsStringSync(
      '$testName, $value, ${value/iterations}, $iterations\n',
      mode: FileMode.append
    );
  }

}