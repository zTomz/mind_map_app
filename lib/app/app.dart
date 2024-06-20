import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:open_mind/ui/views/home/home_view.dart';
import 'package:open_mind/ui/bottom_sheets/empty/empty_sheet.dart';
import 'package:open_mind/services/app_info_service.dart';
import 'package:open_mind/ui/views/mind_map/mind_map_view.dart';
import 'package:open_mind/ui/dialogs/create_new_mind_map/create_new_mind_map_dialog.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: MindMapView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AppInfoService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: EmptySheet),
// @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: CreateNewMindMapDialog),
// @stacked-dialog
  ],
)
class App {}
