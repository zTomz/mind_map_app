// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/dialogs/create_new_mind_map/create_new_mind_map_dialog.dart';

enum DialogType {
  createNewMindMap,
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
    DialogType.createNewMindMap: (context, request, completer) =>
        CreateNewMindMapDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
