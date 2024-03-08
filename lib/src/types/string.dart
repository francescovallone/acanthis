import 'package:email_validator/email_validator.dart';

import 'dart:convert';
import 'list.dart';
import 'nullable.dart';
import 'types.dart';

/// A class to validate string types
class AcanthisString extends AcanthisType<String> {
  AcanthisString();

  /// Add a check to the string to check if it is a valid email
  AcanthisString email() {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) =>
            EmailValidator.validate(value),
        error: 'Invalid email format',
        name: 'email'));
    return this;
  }

  /// Add a check to the string to check if its length is at least [length]
  AcanthisString min(int length) {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) => value.length >= length,
        error: 'Value must be at least $length characters long',
        name: 'min'));
    return this;
  }

  /// Add a check to the string to check if its length is at most [length]
  AcanthisString max(int length) {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) => value.length <= length,
        error: 'Value must be at most $length characters long',
        name: 'maxLength'));
    return this;
  }

  /// Add a check to the string to check if follows the pattern [pattern]
  AcanthisString pattern(RegExp pattern) {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) => pattern.hasMatch(value),
        error: 'Value does not match the pattern',
        name: 'pattern'));
    return this;
  }

  /// Add a check to the string to check if it is not empty
  AcanthisString required() {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) => value.isNotEmpty,
        error: 'Value is required',
        name: 'required'));
    return this;
  }

  /// Add a check to the string to check if it's length is exactly [length]
  AcanthisString length(int length) {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) => value.length == length,
        error: 'Value cannot be empty',
        name: 'notEmpty'));
    return this;
  }

  /// Add a check to the string to check if it contains [value]
  AcanthisString contains(String value) {
    addCheck(AcanthisCheck<String>(
        onCheck: (v) => v.contains(value),
        error: 'Value must contain $value',
        name: 'contains'));
    return this;
  }

  /// Add a check to the string to check if it starts with [value]
  AcanthisString startsWith(String value) {
    addCheck(AcanthisCheck<String>(
        onCheck: (v) => v.startsWith(value),
        error: 'Value must start with $value',
        name: 'startsWith'));
    return this;
  }

  /// Add a check to the string to check if it ends with [value]
  AcanthisString endsWith(String value) {
    addCheck(AcanthisCheck<String>(
        onCheck: (v) => v.endsWith(value),
        error: 'Value must end with $value',
        name: 'endsWith'));
    return this;
  }

  /// Create a list of strings
  AcanthisList<String> list() {
    return AcanthisList<String>(this);
  }

  /// Add a custom check to the string
  AcanthisString customCheck(
      {required bool Function(String value) onCheck,
      required String error,
      required String name}) {
    addCheck(AcanthisCheck<String>(onCheck: onCheck, error: error, name: name));
    return this;
  }
  
  /// Add a transformation to the string to encode it to base64
  AcanthisString encode() {
    addTransformation(AcanthisTransformation<String>(
        transformation: (value) => base64.encode(value.codeUnits)));
    return this;
  }

  /// Add a transformation to the string to decode it from base64
  AcanthisString decode() {
    addTransformation(AcanthisTransformation<String>(
        transformation: (value) => utf8.decode(base64.decode(value))));
    return this;
  }

  /// Add a transformation to the string to transform it using [transformation]
  AcanthisString transform(String Function(String value) transformation) {
    addTransformation(AcanthisTransformation<String>(transformation: transformation));
    return this;
  }

  /// Add a transformation to the string to transform it to uppercase
  AcanthisString toUpperCase() {
    addTransformation(AcanthisTransformation<String>(
        transformation: (value) => value.toUpperCase()));
    return this;
  }

  /// Add a transformation to the string to transform it to lowercase
  AcanthisString toLowerCase() {
    addTransformation(AcanthisTransformation<String>(
        transformation: (value) => value.toLowerCase()));
    return this;
  }

  /// Make the value nullable
  AcanthisNullable<String> nullable({String? defaultValue}){
    return AcanthisNullable(this, defaultValue: defaultValue);
  }

}

/// Create a new AcanthisString instance
AcanthisString string() => AcanthisString();
