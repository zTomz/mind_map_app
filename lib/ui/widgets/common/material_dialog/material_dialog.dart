import 'package:flutter/material.dart';
import 'package:open_mind/ui/common/theme_extension.dart';

class MaterialDialog extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget body;
  final void Function() onConfirm;
  final void Function() onCancel;

  const MaterialDialog({
    super.key,
    required this.title,
    required this.icon,
    required this.body,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      titlePadding: const EdgeInsets.only(
        left: 24,
        top: 24,
        right: 24,
        bottom: 0,
      ),
      contentPadding: const EdgeInsets.all(24),
      backgroundColor: context.colorScheme.surfaceContainerHigh,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: context.colorScheme.secondary,
          ),
          const SizedBox(height: 24),
          Text(title),
        ],
      ),
      children: [
        body,
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: onCancel,
              child: const Text('Cancel'),
            ),
            const SizedBox(width: 12),
            FilledButton.tonal(
              onPressed: onConfirm,
              child: const Text('Create'),
            ),
          ],
        ),
      ],
    );
  }
}
