class InvalidNodeEditException implements Exception {
  final String message;

  const InvalidNodeEditException({
    required this.message,
  });

  @override
  String toString() => message;
}
