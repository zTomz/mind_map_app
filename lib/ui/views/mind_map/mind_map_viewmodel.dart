import 'dart:ui';

import 'package:open_mind/app/app.locator.dart';
import 'package:open_mind/services/database_handler_service.dart';
import 'package:open_mind/ui/views/mind_map/models/mind_map.dart';
import 'package:open_mind/ui/views/mind_map/models/node.dart';
import 'package:stacked/stacked.dart';

class MindMapViewModel extends BaseViewModel {
  MindMap mindMap;

  MindMapViewModel({
    required this.mindMap,
  });

  /// The uuid of the selected node
  String? selectedNode;
  bool get hasSelectedNode => selectedNode != null;

  void selectNode(String? nodeUuid) {
    selectedNode = nodeUuid;
    rebuildUi();
  }

  Node? findNodeByUuid(String? uuid) {
    if (uuid == null) {
      return null;
    }

    return mindMap.findNodeByUuid(uuid);
  }

  /// Adds a new node to the selected node, returns the new node
  Future<Node> addNodeToSelectedNode(String content) async {
    if (selectedNode == null) {
      throw const NoNodeSelectedException();
    }

    final newNode = Node.fromParams(
      content: content,
      childrenUuids: [],
      position: Offset.zero,
      parentUuid: selectedNode!,
    );
    mindMap.addNode(newNode, selectedNode!);

    await saveMindMap();

    rebuildUi();

    return newNode;
  }

  /// Edits the selected node. Just enter the params you want to change
  Future<void> editSelectedNode({
    String? content,
    String? parentUuid,
    List<String>? childrenUuids,
    Offset? position,
    String? uuid,
  }) async {
    if (selectedNode == null) {
      throw const NoNodeSelectedException();
    }

    mindMap.editNode(
      findNodeByUuid(selectedNode!)!,
      content: content,
      parentUuid: parentUuid,
      childrenUuids: childrenUuids,
      position: position,
      uuid: uuid,
    );

    await saveMindMap();

    rebuildUi();
  }

  Future<void> deleteSelectedNode() async {
    if (selectedNode == null) {
      throw const NoNodeSelectedException();
    }

    mindMap.deleteNode(selectedNode!);
    selectedNode = null;

    await saveMindMap();

    rebuildUi();
  }

  void dragNode(Node node, Offset offset) {
    node.updatePosition(offset);

    rebuildUi();
  }

  /// Saves the mind map. Also toggels the [busy] state
  Future<void> saveMindMap() async {
    await runBusyFuture(
      locator<DatabaseHandlerService>().saveMindMap(
        mindMap.copyWith(
          lastEditedAt: DateTime.now(),
        ),
      ),
    );
  }
}

class NoNodeSelectedException implements Exception {
  const NoNodeSelectedException();

  @override
  String toString() {
    return "No node selected";
  }
}
