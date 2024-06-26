class NoNodeSelectedException implements Exception {
  const NoNodeSelectedException();

  @override
  String toString() {
    return "No node selected";
  }
}
