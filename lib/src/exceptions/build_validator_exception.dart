class BuildValidatorException implements Exception {
  /// The message of the exception
  final String message;

  /// The constructor of the exception
  BuildValidatorException(this.message);

  @override
  String toString() {
    return 'BuildValidatorException: $message';
  }
}
