

class BaseException implements Exception {
  final String? message;
  final int? code;

  const BaseException({this.message, this.code});

  @override
  String toString() {
    return 'BaseException: $message${code != null ? ' (code: $code)' : ''}';
  }
}