import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_mind/ui/common/theme_extension.dart';

abstract class Spacing {
  static const double small = 12;
  static const double medium = 18;
  static const double large = 35;
}

abstract class Radii {
  static const double small = 14;
  static const double medium = 20;
}

String formatDateTime(DateTime dateTime) {
  final DateFormat formatter = DateFormat('dd.MM.yyyy HH:mm');
  return formatter.format(dateTime);
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showMaterialSnackBar(
  BuildContext context, {
  required String message,
  SnackBarAction? action,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: context.colorScheme.inverseSurface,
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
      ),
      action: action,
    ),
  );
}
