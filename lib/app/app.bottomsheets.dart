// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedBottomsheetGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/bottom_sheets/empty/empty_sheet.dart';

enum BottomSheetType {
  empty,
}

void setupBottomSheetUi() {
  final bottomsheetService = locator<BottomSheetService>();

  final Map<BottomSheetType, SheetBuilder> builders = {
    BottomSheetType.empty: (context, request, completer) =>
        EmptySheet(request: request, completer: completer),
  };

  bottomsheetService.setCustomSheetBuilders(builders);
}
