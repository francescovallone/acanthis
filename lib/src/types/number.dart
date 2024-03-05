import 'types.dart';

class AcanthisNumber extends AcanthisType<num> {

  AcanthisNumber();

  AcanthisNumber lte(num value){
    addCheck(AcanthisCheck<num>(
      onCheck: (toTest) => toTest <= value,
      error: 'Value must be less than or equal to $value',
      name: 'lte'
    ));
    return this;
  }

  AcanthisNumber gte(num value){
    addCheck(AcanthisCheck<num>(
      onCheck: (toTest) => toTest >= value,
      error: 'Value must be greater than or equal to $value',
      name: 'gte'
    ));
    return this;
  }

  AcanthisNumber gt(num value){
    addCheck(AcanthisCheck<num>(
      onCheck: (toTest) => toTest > value,
      error: 'Value must be greater than $value',
      name: 'gt'
    ));
    return this;
  }

  AcanthisNumber lt(num value){
    addCheck(AcanthisCheck<num>(
      onCheck: (toTest) => toTest < value,
      error: 'Value must be less than $value',
      name: 'lt'
    ));
    return this;
  }

  AcanthisNumber positive(){
    addCheck(AcanthisCheck<num>(
      onCheck: (toTest) => toTest > 0,
      error: 'Value must be positive',
      name: 'positive'
    ));
    return this;
  }

  AcanthisNumber negative(){
    addCheck(AcanthisCheck<num>(
      onCheck: (toTest) => toTest < 0,
      error: 'Value must be negative',
      name: 'negative'
    ));
    return this;
  }

  AcanthisNumber integer(){
    addCheck(AcanthisCheck<num>(
      onCheck: (toTest) => toTest % 1 == 0,
      error: 'Value must be an integer',
      name: 'integer'
    ));
    return this;
  }

  AcanthisNumber multipleOf(int value){
    addCheck(AcanthisCheck<num>(
      onCheck: (toTest) => toTest % value == 0,
      error: 'Value must be a multiple of $value',
      name: 'multipleOf'
    ));
    return this;
  }

  AcanthisNumber finite(){
    addCheck(AcanthisCheck<num>(
      onCheck: (toTest) => toTest.isFinite,
      error: 'Value is not finite',
      name: 'finite'
    ));
    return this;
  }

  AcanthisNumber infinite(){
    addCheck(AcanthisCheck<num>(
      onCheck: (toTest) => toTest.isInfinite,
      error: 'Value is not infinite',
      name: 'infinite'
    ));
    return this;
  }

  AcanthisNumber nan(){
    addCheck(AcanthisCheck<num>(
      onCheck: (toTest) => toTest.isNaN,
      error: 'Value is not NaN',
      name: 'nan'
    ));
    return this;
  }

  AcanthisNumber notNaN(){
    addCheck(AcanthisCheck<num>(
      onCheck: (toTest) => !toTest.isNaN,
      error: 'Value is NaN',
      name: 'notNaN'
    ));
    return this;
  }

  AcanthisNumber customCheck({
    required bool Function(num value) onCheck,
    required String error,
    required String name
  }){
    addCheck(AcanthisCheck<num>(
      onCheck: onCheck,
      error: error,
      name: name
    ));
    return this;
  }

}

AcanthisNumber number() => AcanthisNumber();