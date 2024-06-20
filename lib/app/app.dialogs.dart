// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/dialogs/text_field/text_field_dialog.dart';

enum DialogType {
  textField,
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
    DialogType.textField: (context, request, completer) =>
        TextFieldDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
