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

  /// Delete the mind map from the database. If the mind map is already removed,
  /// there is the optional parameter `alreadyRemoved` wich can be set to true.
  Future<void> deleteMindMap(
    MindMap mindMap, {
    bool alreadyRemoved = false,
  }) async {
    await runBusyFuture<void>(
      locator<DatabaseHandlerService>().deleteMindMap(mindMap.uuid),
    );

    if (!alreadyRemoved) {
      mindMaps.removeWhere((element) => element.uuid == mindMap.uuid);
    }

    rebuildUi();
  }

  /// Just removes the mind map from the mind map's list. These changes are
  /// not saved. It is suggestes to call `deleteMindMap` and parse the argument
  /// `alreadyRemoved: true`, if the user didn't want to undo the deletion.
  void removeMindMap(MindMap mindMap) {
    mindMaps.removeWhere((element) => element.uuid == mindMap.uuid);

    rebuildUi();
  }

  /// This function can be called after `removeMindMap`, to add the removed
  /// mind map back to the list. This function does not call any function
  /// of the database
  void addMindMap(MindMap mindMap) {
    mindMaps.add(mindMap);

    rebuildUi();
  }

  /// Create a new mind map and save the changes to the database.
  Future<void> createNewMindMap(MindMap mindMap) async {
    await runBusyFuture<void>(
      locator<DatabaseHandlerService>().saveMindMap(mindMap),
    );
    mindMaps.add(mindMap);

    rebuildUi();
  }
}
