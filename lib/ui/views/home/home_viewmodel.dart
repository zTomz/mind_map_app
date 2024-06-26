import 'package:open_mind/app/app.locator.dart';
import 'package:open_mind/services/database_handler_service.dart';
import 'package:open_mind/ui/views/mind_map/models/mind_map.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  List<MindMap> mindMaps = [];

  Future<void> init() async {
    mindMaps = await runBusyFuture<List<MindMap>>(
      locator<DatabaseHandlerService>().loadMindMaps(),
    );

    rebuildUi();
  }

  Future<void> deleteMindMap(MindMap mindMap) async {
    await runBusyFuture<void>(
        locator<DatabaseHandlerService>().deleteMindMap(mindMap.uuid));
    mindMaps.removeWhere((element) => element.uuid == mindMap.uuid);

    rebuildUi();
  }

  Future<void> createNewMindMap(MindMap mindMap) async {
    await runBusyFuture<void>(
        locator<DatabaseHandlerService>().saveMindMap(mindMap));
    mindMaps.add(mindMap);

    rebuildUi();
  }
}
