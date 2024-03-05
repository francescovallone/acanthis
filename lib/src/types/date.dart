import 'types.dart';

class AcanthisDate extends AcanthisType<DateTime> {

  AcanthisDate();

  AcanthisDate min(DateTime value){
    addCheck(AcanthisCheck<DateTime>(
      onCheck: (toTest) => toTest.isAfter(value) || toTest.isAtSameMomentAs(value),
      error: 'The date must be greater than or equal to $value',
      name: 'min'
    ));
    return this;
  }

  AcanthisDate max(DateTime value){
    addCheck(AcanthisCheck<DateTime>(
      onCheck: (toTest) => toTest.isBefore(value) || toTest.isAtSameMomentAs(value),
      error: 'The date must be less than or equal to $value',
      name: 'max'
    ));
    return this;
  }

  AcanthisDate customCheck({
    required bool Function(DateTime value) onCheck,
    required String error,
    required String name
  }){
    addCheck(AcanthisCheck<DateTime>(
      onCheck: onCheck,
      error: error,
      name: name
    ));
    return this;
  }

}

AcanthisDate date() => AcanthisDate();