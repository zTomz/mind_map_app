// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/dialogs/empty/empty_dialog.dart';

enum DialogType {
  empty,
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
    DialogType.empty: (context, request, completer) =>
        EmptyDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
