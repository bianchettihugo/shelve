class CategoryError implements Exception {
  final int id;
  final String title;
  final String message;

  CategoryError({
    required this.id,
    required this.title,
    required this.message,
  });

  @override
  bool operator ==(covariant CategoryError other) {
    if (identical(this, other)) return true;

    return other.id == id && other.title == title && other.message == message;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ message.hashCode;
}
