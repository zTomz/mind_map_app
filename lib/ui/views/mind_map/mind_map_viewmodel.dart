import 'dart:ui';

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

  void selectNode(Node node) {
    selectedNode = node.uuid;
    rebuildUi();
  }

  Node? findNodeByUuid(String? uuid) {
    if (uuid == null) {
      return null;
    }

    return mindMap.findNodeByUuid(uuid);
  }

  /// Adds a new node to the selected node, returns the new node
  Node addNodeToSelectedNode(String content) {
    if (selectedNode == null) {
      throw Exception("No node selected");
    }

    final newNode = Node.fromParams(
      content: content,
      childrenUuids: [],
      position: Offset.zero,
      parentUuid: selectedNode!,
    );

    mindMap.addNode(newNode, selectedNode!);

    rebuildUi();

    return newNode;
  }

  void editSelectedNode({
    String? content,
    String? parent,
    List<String>? children,
    Offset? position,
  }) {
    if (selectedNode == null) {
      throw Exception("No node selected");
    }

    final newNode = findNodeByUuid(selectedNode!)!.copyWith(
      content: content,
      parentUuid: parent,
      childrenUuids: children,
      position: position,
    );

    mindMap = mindMap.copyWith(
      nodes: mindMap.nodes
          .map((node) => node.uuid == selectedNode! ? newNode : node)
          .toList(),
    );

    rebuildUi();
  }

  void deleteSelectedNode() {
    if (selectedNode == null) {
      throw Exception("No node selected");
    }

    mindMap.deleteNode(selectedNode!);
    selectedNode = null;

    rebuildUi();
  }

  void dragNode(Node node, Offset offset) {
    node.updatePosition(offset);

    rebuildUi();
  }
}
