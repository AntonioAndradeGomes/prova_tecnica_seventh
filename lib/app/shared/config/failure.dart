class Failure implements Exception {
  final String message;
  final int code;

  Failure({
    required this.message,
    required this.code,
  });

  factory Failure.fromMap(Map<dynamic, dynamic> map) => Failure(
        message: map['message'] ?? 'Server error',
        code: map['code'] ?? 500,
      );
}
