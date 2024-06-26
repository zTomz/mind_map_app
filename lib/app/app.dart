import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:open_mind/ui/views/home/home_view.dart';
import 'package:open_mind/ui/bottom_sheets/empty/empty_sheet.dart';
import 'package:open_mind/services/app_info_service.dart';
import 'package:open_mind/ui/views/mind_map/mind_map_view.dart';
import 'package:open_mind/ui/dialogs/text_field/text_field_dialog.dart';
import 'package:open_mind/services/database_handler_service.dart';
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
    LazySingleton(classType: DatabaseHandlerService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: EmptySheet),
// @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: TextFieldDialog),
// @stacked-dialog
  ],
)
class App {}
