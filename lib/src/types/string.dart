import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:email_validator/email_validator.dart';

import 'dart:convert' as convert;
import 'list.dart';
import 'types.dart';
import 'union.dart';

const _lettersStrict = r'^[a-zA-Z]+$';
const _digitsStrict = r'^[0-9]+$';
const _alphanumericStrict = r'^[a-zA-Z0-9]+$';
const _alphanumericWithSpacesStrict = r'^[a-zA-Z0-9 ]+$';
const _specialCharactersStrict = r'^[!@#\$%^&*(),.?":{}|<>]+$';
const _allCharactersStrict =
    r'^[a-zA-Z0-9!@#\$%^&*(),.?":{}\(\)\[\];_\-\?\!\£\|<> ]+$';
const _letters = r'[a-zA-Z]+';
const _digits = r'[0-9]+';
const _alphanumeric = r'[a-zA-Z0-9]+';
const _alphanumericWithSpaces = r'[a-zA-Z0-9 ]+';
const _specialCharacters = r'[!@#\$%^&*(),.?":{}|<>]+';
const _allCharacters = r'[a-zA-Z0-9!@#\$%^&*(),.?":{}\(\)\[\];_\-\?\!\£\|<> ]+';
const _cuidRegex = r'^c[^\s-]{8,}$';
const _cuid2Regex = r'^[0-9a-z]+$';
const _ulidRegex = r'^[0-9A-HJKMNP-TV-Z]{26}$';
// const uuidRegex =
//   /^([a-f0-9]{8}-[a-f0-9]{4}-[1-5][a-f0-9]{3}-[a-f0-9]{4}-[a-f0-9]{12}|00000000-0000-0000-0000-000000000000)$/i;
const _uuidRegex =
    r'^[0-9a-fA-F]{8}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{4}\b-[0-9a-fA-F]{12}$';
const _nanoidRegex = r'^[a-z0-9_-]{21}$';
const _jwtRegex = r'^[A-Za-z0-9-_]+\.[A-Za-z0-9-_]+\.[A-Za-z0-9-_]*$';
const _base64Regex =
    r'^([0-9a-zA-Z+/]{4})*(([0-9a-zA-Z+/]{2}==)|([0-9a-zA-Z+/]{3}=))?$';
const _timeRegex = r'^([0-1]?[0-9]|2[0-3]):[0-5][0-9](?::([0-5]\d))?$';

/// A class to validate string types
class AcanthisString extends AcanthisType<String> {
  AcanthisString();

  /// Add a check to the string to check if it is a valid email
  AcanthisString email() {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) => EmailValidator.validate(value),
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

  /// Add a check to the string to check if it contains letters
  AcanthisString letters({bool strict = true}) {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) => (strict ? RegExp(_lettersStrict) : RegExp(_letters))
            .hasMatch(value),
        error: 'Value must contain ${strict ? 'only ' : ''}letters',
        name: 'letters'));
    return this;
  }

  /// Add a check to the string to check if it contains digits
  AcanthisString digits({bool strict = true}) {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) =>
            (strict ? RegExp(_digitsStrict) : RegExp(_digits)).hasMatch(value),
        error: 'Value must contain ${strict ? 'only ' : ''}digits',
        name: 'digits'));
    return this;
  }

  /// Add a check to the string to check if it contains alphanumeric characters
  AcanthisString alphanumeric({bool strict = true}) {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) =>
            (strict ? RegExp(_alphanumericStrict) : RegExp(_alphanumeric))
                .hasMatch(value),
        error:
            'Value must contain ${strict ? 'only ' : ''}alphanumeric characters',
        name: 'alphanumeric'));
    return this;
  }

  /// Add a check to the string to check if it contains alphanumeric characters and spaces
  AcanthisString alphanumericWithSpaces({bool strict = true}) {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) => (strict
                ? RegExp(_alphanumericWithSpacesStrict)
                : RegExp(_alphanumericWithSpaces))
            .hasMatch(value),
        error:
            'Value must contain ${strict ? 'only ' : ''}alphanumeric or spaces characters',
        name: 'alphanumericWithSpaces'));
    return this;
  }

  /// Add a check to the string to check if it contains special characters
  AcanthisString specialCharacters({bool strict = true}) {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) => (strict
                ? RegExp(_specialCharactersStrict)
                : RegExp(_specialCharacters))
            .hasMatch(value),
        error: 'Value must contain ${strict ? 'only ' : ''}special characters',
        name: 'specialCharacters'));
    return this;
  }

  /// Add a check to the string to check if it contains all characters
  AcanthisString allCharacters({bool strict = true}) {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) =>
            (strict ? RegExp(_allCharactersStrict) : RegExp(_allCharacters))
                .hasMatch(value),
        error: 'Value must contain ${strict ? 'only ' : ''} characters',
        name: 'specialCharacters'));
    return this;
  }

  /// Add a check to the string to check if it is in uppercase
  AcanthisString upperCase() {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) => value == value.toUpperCase(),
        error: 'Value must be uppercase',
        name: 'upperCase'));
    return this;
  }

  /// Add a check to the string to check if it is in lowercase
  AcanthisString lowerCase() {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) => value == value.toLowerCase(),
        error: 'Value must be lowercase',
        name: 'lowerCase'));
    return this;
  }

  /// Add a check to the string to check if it is in mixed case
  AcanthisString mixedCase() {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) =>
            value != value.toUpperCase() && value != value.toLowerCase(),
        error: 'Value must be mixed case',
        name: 'mixedCase'));
    return this;
  }

  /// Add a check to the string to check if it is a valid date time
  AcanthisString dateTime() {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) => DateTime.tryParse(value) != null,
        error: 'Value must be a valid date time',
        name: 'dateTime'));
    return this;
  }

  AcanthisString time() {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) => (RegExp(_timeRegex)).hasMatch(value),
        error: 'Value must be a valid time format',
        name: 'time'));
    return this;
  }

  AcanthisString hexColor() {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) {
          if (value.length != 7) return false;
          if (value[0] != '#') return false;
          return RegExp(r'^[0-9a-fA-F]+$').hasMatch(value.substring(1));
        },
        error: 'Value must be a valid hex color',
        name: 'hexColor'));
    return this;
  }

  /// Add a check to the string to check if it is a valid uri
  AcanthisString uri() {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) => Uri.tryParse(value) != null,
        error: 'Value must be a valid uri',
        name: 'uri'));
    return this;
  }

  AcanthisString url() {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) {
          if (value.isEmpty) return false;
          final uriValue = Uri.tryParse(value);
          if (uriValue == null) return false;
          return uriValue.hasScheme && uriValue.host.isNotEmpty;
        },
        error: 'Value must be a valid url',
        name: 'url'));
    return this;
  }

  AcanthisString uncompromised() {
    addAsyncCheck(AcanthisAsyncCheck<String>(
        onCheck: (value) async {
          final bytes = convert.utf8.encode(value);
          final sha = sha1.convert(bytes);
          final hexString = sha.toString().toUpperCase();
          final client = HttpClient();
          final request = await client.getUrl(
            Uri.parse(
                'https://api.pwnedpasswords.com/range/${hexString.substring(0, 5)}'),
          );
          final response = await request.close();
          final body = await response.transform(convert.utf8.decoder).join();
          final lines = body.split('\n');
          return !lines
              .any((element) => element.startsWith(hexString.substring(5)));
        },
        error: 'Value is compromised',
        name: 'uncompromised'));
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

  AcanthisString card() {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) {
          final sanitized = value.replaceAll(RegExp(r'\D'), '');
          if (sanitized.length < 13 || sanitized.length > 19) return false;
          if (!RegExp(r'^\d+$').hasMatch(sanitized)) return false;
          return _isValidLuhn(sanitized);
        },
        error: 'Value must be a valid card number',
        name: 'card'));
    return this;
  }

  bool _isValidLuhn(String number) {
    int sum = 0;
    bool alternate = false;
    for (int i = number.length - 1; i >= 0; i--) {
      int digit = int.parse(number[i]);

      if (alternate) {
        digit *= 2;
        if (digit > 9) digit -= 9;
      }

      sum += digit;
      alternate = !alternate;
    }
    return sum % 10 == 0;
  }

  AcanthisString cuid() {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) =>
            RegExp(_cuidRegex, caseSensitive: false).hasMatch(value),
        error: 'Value must be a valid cuid',
        name: 'cuid'));
    return this;
  }

  AcanthisString cuid2() {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) =>
            RegExp(_cuid2Regex, caseSensitive: false).hasMatch(value),
        error: 'Value must be a valid cuid2',
        name: 'cuid2'));
    return this;
  }

  AcanthisString ulid() {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) =>
            RegExp(_ulidRegex, caseSensitive: false).hasMatch(value),
        error: 'Value must be a valid ulid',
        name: 'ulid'));
    return this;
  }

  AcanthisString uuid() {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) =>
            RegExp(_uuidRegex, caseSensitive: false).hasMatch(value),
        error: 'Value must be a valid uuid',
        name: 'uuid'));
    return this;
  }

  AcanthisString nanoid() {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) =>
            RegExp(_nanoidRegex, caseSensitive: false).hasMatch(value),
        error: 'Value must be a valid nanoid',
        name: 'nanoid'));
    return this;
  }

  AcanthisString jwt() {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) =>
            RegExp(_jwtRegex, caseSensitive: false).hasMatch(value),
        error: 'Value must be a valid jwt',
        name: 'jwt'));
    return this;
  }

  AcanthisString base64() {
    addCheck(AcanthisCheck<String>(
        onCheck: (value) =>
            RegExp(_base64Regex, caseSensitive: false).hasMatch(value),
        error: 'Value must be a valid base64',
        name: 'base64'));
    return this;
  }

  /// Create a list of strings
  AcanthisList<String> list() {
    return AcanthisList<String>(this);
  }

  /// Add a transformation to the string to encode it to base64
  AcanthisString encode() {
    addTransformation(AcanthisTransformation<String>(
        transformation: (value) => convert.base64.encode(value.codeUnits)));
    return this;
  }

  /// Add a transformation to the string to decode it from base64
  AcanthisString decode() {
    addTransformation(AcanthisTransformation<String>(
        transformation: (value) =>
            convert.utf8.decode(convert.base64.decode(value))));
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

  /// Create a union from the string
  AcanthisUnion or(List<AcanthisType> elements) {
    return AcanthisUnion([this, ...elements]);
  }

  // AcanthisDate date() {
  //   addTransformation(AcanthisTransformation(transformation: (value) => DateTime.parse(value)));
  //   return AcanthisDate();
  // }
}

/// Create a new AcanthisString instance
AcanthisString string() => AcanthisString();
