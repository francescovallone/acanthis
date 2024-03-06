class ValidationError extends Error {
  final String message;

  ValidationError(this.message);

  @override
  String toString() {
    return "ValidationError: $message";
  }
}
