class AuthError implements Exception {
  final int id;
  final String title;
  final String message;

  AuthError({
    required this.id,
    required this.title,
    required this.message,
  });

  @override
  bool operator ==(covariant AuthError other) {
    if (identical(this, other)) return true;

    return other.id == id && other.title == title && other.message == message;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ message.hashCode;
}
