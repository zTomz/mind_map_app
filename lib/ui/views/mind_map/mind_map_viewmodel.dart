import 'dart:ui';

import 'package:open_mind/ui/views/mind_map/models/mind_map.dart';
import 'package:open_mind/ui/views/mind_map/models/node.dart';
import 'package:stacked/stacked.dart';

class MindMapViewModel extends BaseViewModel {
  MindMap mindMap;

  MindMapViewModel({
    required this.mindMap,
  });

  Node? selectedNode;
  bool get hasSelectedNode => selectedNode != null;

  void selectNode(Node node) {
    selectedNode = node;
    rebuildUi();
  }

  void addNodeToSelectedNode(String content) {
    if (selectedNode == null) {
      throw Exception("No node selected");
    }

    final newNode = Node.fromParams(
      content: content,
      childrenUuids: [],
      position: Offset.zero,
      parentUuid: selectedNode!.uuid,
    );

    mindMap.addNode(newNode, selectedNode!);

    rebuildUi();
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

    final newNode = selectedNode!.copyWith(
      content: content,
      parentUuid: parent,
      childrenUuids: children,
      position: position,
    );

    mindMap = mindMap.copyWith(
      nodes: mindMap.nodes
          .map((node) => node.uuid == selectedNode!.uuid ? newNode : node)
          .toList(),
    );

    rebuildUi();
  }

  void deleteSelectedNode() {
    if (selectedNode == null) {
      throw Exception("No node selected");
    }

    mindMap.deleteNode(selectedNode!.uuid);

    rebuildUi();
  }

  void dragNode(Node node, Offset offset) {
    node.updatePosition(offset);

    rebuildUi();
  }
}
