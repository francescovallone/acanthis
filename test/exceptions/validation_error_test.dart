import 'package:acanthis/src/exceptions/validation_error.dart';
import 'package:test/test.dart';

void main() {

  group(
    '$ValidationError', 
    () {
      test(
        'Should return a string with the message', 
        () {
          final error = ValidationError('This is a test');
          expect(error.toString(), 'ValidationError: This is a test');
        }
      );
    }
  );

}