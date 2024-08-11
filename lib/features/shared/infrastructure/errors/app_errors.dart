class AppError extends Error {
  final String message;
  final String code;

  AppError(this.message, this.code);
}
