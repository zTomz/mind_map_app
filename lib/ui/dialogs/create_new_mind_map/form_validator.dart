class CreateNewMindMapFormValidator {
  static String? validateMindMapName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a name';
    }

    if (value.trim().length < 3 || value.trim().length > 30) {
      return 'Name must be at least 3 characters long';
    }

    if (value.contains(RegExp(r'[0-9]'))) {
      return 'No numbers allowed';
    }

    return null;
  }
}
