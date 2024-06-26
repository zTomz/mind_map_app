import 'package:open_mind/ui/views/mind_map/models/mind_map.dart';

class BasicValidator {
  static String? validateText(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'The text cannot be empty';
    }

    if (value.trim().length < MindMap.minNameLength) {
      return 'Name must be at least 3 characters long';
    }

    // Check if text only contains numbers and no letters
    final textRegex = RegExp(r'^\d+$');
    if (textRegex.hasMatch(value)) {
      return 'Text must contain letters';
    }

    return null;
  }
}
