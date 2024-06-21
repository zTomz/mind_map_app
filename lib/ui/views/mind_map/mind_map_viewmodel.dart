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

  void selectNode(Node node) {
    selectedNode = node;
    rebuildUi();
  }

  void addNodeToSelectedNode(String content) {
    if (selectedNode == null) {
      throw Exception("No node selected");
    }

    selectedNode!.addChild(
      Node(
        content: content,
        children: [],
        position: Offset.zero,
        parent: selectedNode,
      ),
    );
    rebuildUi();
  }

  void dragNode(Node node, Offset offset) {
    node.updatePosition(offset);

    rebuildUi();
  }
}
