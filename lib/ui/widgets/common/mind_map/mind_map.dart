import 'package:flutter/material.dart';
import 'package:open_mind/ui/views/mind_map/models/mind_map.dart';
import 'package:open_mind/ui/views/mind_map/models/node.dart';
import 'package:open_mind/ui/widgets/common/mind_map/mind_map_bubbel.dart';
import 'package:stacked/stacked.dart';

import 'mind_map_model.dart';

class MindMapWidget extends StackedView<MindMapModel> {
  final MindMap mindMap;
  final Node? selectedNode;
  final void Function(Node node) onNodeSelected;
  final void Function(Node node, Offset offset) onNodeDragged;

  const MindMapWidget({
    super.key,
    required this.mindMap,
    required this.selectedNode,
    required this.onNodeSelected,
    required this.onNodeDragged,
  });

  @override
  Widget builder(
    BuildContext context,
    MindMapModel viewModel,
    Widget? child,
  ) {
    return Stack(
      children: [
        Center(
          child: MindMapBubbel(
            node: mindMap.root,
            isSelected: selectedNode == mindMap.root,
            onNodeSelected: onNodeSelected,
            onNodeDragged: onNodeDragged,
          ),
        ),
        ...mindMap.getNodes().skip(1).map(
              (node) => MindMapBubbel(
                node: node,
                isSelected: selectedNode == node,
                onNodeSelected: onNodeSelected,
                onNodeDragged: onNodeDragged,
              ),
            ),
      ],
    );
  }

  @override
  MindMapModel viewModelBuilder(
    BuildContext context,
  ) =>
      MindMapModel();
}
