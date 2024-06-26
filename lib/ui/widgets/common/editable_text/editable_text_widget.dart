import 'package:flutter/material.dart';
import 'package:open_mind/ui/common/theme_extension.dart';

class EditableTextWidget extends StatelessWidget {
  /// The text to display, which is editable
  final String text;

  /// The function that is called when the text changes
  final void Function(String) onChanged;

  const EditableTextWidget({
    super.key,
    required this.text,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: text,
      onChanged: onChanged,
      style: context.textTheme.headlineSmall,
      decoration: const InputDecoration.collapsed(hintText: "Mind Map Name"),
    );
  }
}
