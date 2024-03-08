import 'package:email_validator/email_validator.dart';

import 'dart:convert';
import 'list.dart';
import 'types.dart';

class AcanthisString extends AcanthisType<String> {
  AcanthisString();

  AcanthisString email() {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) =>
            EmailValidator.validate(value),
        error: 'Invalid email format',
        name: 'email'));
    return this;
  }

  AcanthisString min(int length) {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) => value.length >= length,
        error: 'Value must be at least $length characters long',
        name: 'min'));
    return this;
  }

  AcanthisString max(int length) {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) => value.length <= length,
        error: 'Value must be at most $length characters long',
        name: 'maxLength'));
    return this;
  }

  AcanthisString pattern(RegExp pattern) {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) => pattern.hasMatch(value),
        error: 'Value does not match the pattern',
        name: 'pattern'));
    return this;
  }

  AcanthisString required() {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) => value.isNotEmpty,
        error: 'Value is required',
        name: 'required'));
    return this;
  }

  AcanthisString length(int length) {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) => value.length == length,
        error: 'Value cannot be empty',
        name: 'notEmpty'));
    return this;
  }

  AcanthisString contains(String value) {
    addCheck(AcanthisCheck<String>(
        onCheck: (v) => v.contains(value),
        error: 'Value must contain $value',
        name: 'contains'));
    return this;
  }

  AcanthisString startsWith(String value) {
    addCheck(AcanthisCheck<String>(
        onCheck: (v) => v.startsWith(value),
        error: 'Value must start with $value',
        name: 'startsWith'));
    return this;
  }

  AcanthisString endsWith(String value) {
    addCheck(AcanthisCheck<String>(
        onCheck: (v) => v.endsWith(value),
        error: 'Value must end with $value',
        name: 'endsWith'));
    return this;
  }

  AcanthisList<String> list() {
    return AcanthisList<String>(this);
  }

  AcanthisString customCheck(
      {required bool Function(String value) onCheck,
      required String error,
      required String name}) {
    addCheck(AcanthisCheck<String>(onCheck: onCheck, error: error, name: name));
    return this;
  }
  
  AcanthisString encode() {
    addTransformation(AcanthisTransformation<String>(
        transformation: (value) => base64.encode(value.codeUnits)));
    return this;
  }

  AcanthisString decode() {
    addTransformation(AcanthisTransformation<String>(
        transformation: (value) => utf8.decode(base64.decode(value))));
    return this;
  }

  AcanthisString transform(String Function(String value) transformation) {
    addTransformation(AcanthisTransformation<String>(transformation: transformation));
    return this;
  }

  AcanthisString toUpperCase() {
    addTransformation(AcanthisTransformation<String>(
        transformation: (value) => value.toUpperCase()));
    return this;
  }

  AcanthisString toLowerCase() {
    addTransformation(AcanthisTransformation<String>(
        transformation: (value) => value.toLowerCase()));
    return this;
  }

}

AcanthisString string() => AcanthisString();
