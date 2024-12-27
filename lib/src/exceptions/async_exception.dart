class AsyncValidationException implements Exception {
  
  /// The message of the exception
  final String message;

  /// The constructor of the exception
  AsyncValidationException(this.message);

  @override
  String toString() {
    return 'AsyncValidationException: $message';
  }

}