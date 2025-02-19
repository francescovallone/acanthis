import 'dart:math' as math;

import 'list.dart';
import 'types.dart';
import 'union.dart';

/// A class to validate number types
class AcanthisNumber extends AcanthisType<num> {
  AcanthisNumber();

  /// Add a check to the number to check if it is less than or equal to [value]
  AcanthisNumber lte(num value) {
    addCheck(AcanthisCheck<num>(
        onCheck: (toTest) => toTest <= value,
        error: 'Value must be less than or equal to $value',
        name: 'lte'));
    return this;
  }

  /// Add a check to the number to check if it is greater than or equal to [value]
  AcanthisNumber gte(num value) {
    addCheck(AcanthisCheck<num>(
        onCheck: (toTest) => toTest >= value,
        error: 'Value must be greater than or equal to $value',
        name: 'gte'));
    return this;
  }

  AcanthisNumber between(num min, num max) {
    addCheck(AcanthisCheck<num>(
        onCheck: (toTest) => toTest >= min && toTest <= max,
        error: 'Value must be between $min and $max',
        name: 'between'));
    return this;
  }

  /// Add a check to the number to check if it is greater than [value]
  AcanthisNumber gt(num value) {
    addCheck(AcanthisCheck<num>(
        onCheck: (toTest) => toTest > value,
        error: 'Value must be greater than $value',
        name: 'gt'));
    return this;
  }

  /// Add a check to the number to check if it is less than [value]
  AcanthisNumber lt(num value) {
    addCheck(AcanthisCheck<num>(
        onCheck: (toTest) => toTest < value,
        error: 'Value must be less than $value',
        name: 'lt'));
    return this;
  }

  /// Add a check to the number to check if it is positive
  AcanthisNumber positive() {
    addCheck(AcanthisCheck<num>(
        onCheck: (toTest) => toTest > 0,
        error: 'Value must be positive',
        name: 'positive'));
    return this;
  }

  /// Add a check to the number to check if it is negative
  AcanthisNumber negative() {
    addCheck(AcanthisCheck<num>(
        onCheck: (toTest) => toTest < 0,
        error: 'Value must be negative',
        name: 'negative'));
    return this;
  }

  /// Add a check to the number to check if it is an integer
  AcanthisNumber integer() {
    addCheck(AcanthisCheck<num>(
        onCheck: (toTest) => toTest is int,
        error: 'Value must be an integer',
        name: 'integer'));
    return this;
  }

  /// Add a check to the number to check if it is a double
  AcanthisNumber double() {
    addCheck(AcanthisCheck<num>(
        onCheck: (toTest) => toTest is! int,
        error: 'Value must be a double',
        name: 'double'));
    return this;
  }

  /// Add a check to the number to check if it is a multiple of [value]
  AcanthisNumber multipleOf(int value) {
    addCheck(AcanthisCheck<num>(
        onCheck: (toTest) => toTest % value == 0,
        error: 'Value must be a multiple of $value',
        name: 'multipleOf'));
    return this;
  }

  /// Add a check to the number to check if it is finite
  AcanthisNumber finite() {
    addCheck(AcanthisCheck<num>(
        onCheck: (toTest) => toTest.isFinite,
        error: 'Value is not finite',
        name: 'finite'));
    return this;
  }

  /// Add a check to the number to check if it is infinite
  AcanthisNumber infinite() {
    addCheck(AcanthisCheck<num>(
        onCheck: (toTest) => toTest.isInfinite,
        error: 'Value is not infinite',
        name: 'infinite'));
    return this;
  }

  /// Add a check to the number to check if it is "not a number"
  AcanthisNumber nan() {
    addCheck(AcanthisCheck<num>(
        onCheck: (toTest) => toTest.isNaN,
        error: 'Value is not NaN',
        name: 'nan'));
    return this;
  }

  /// Add a check to the number to check if it is not "not a number"
  AcanthisNumber notNaN() {
    addCheck(AcanthisCheck<num>(
        onCheck: (toTest) => !toTest.isNaN,
        error: 'Value is NaN',
        name: 'notNaN'));
    return this;
  }

  /// Create a list of numbers
  AcanthisList<num> list() {
    return AcanthisList<num>(this);
  }

  /// Transform the number to a power of [value]
  AcanthisNumber pow(int value) {
    addTransformation(AcanthisTransformation<num>(
        transformation: (toTransform) => math.pow(toTransform, value)));
    return this;
  }

  /// Create a union from the number
  AcanthisUnion or(List<AcanthisType> elements) {
    return AcanthisUnion([this, ...elements]);
  }
}

/// Create a number type
AcanthisNumber number() => AcanthisNumber();
