import 'package:flutter/material.dart';
import 'package:open_mind/ui/views/mind_map/models/mind_map.dart';
import 'package:open_mind/ui/views/mind_map/models/node.dart';
import 'package:open_mind/ui/widgets/common/mind_map/mind_map_bubbel.dart';
import 'package:open_mind/ui/widgets/common/mind_map/mind_map_painter.dart';
import 'package:stacked/stacked.dart';

import 'mind_map_model.dart';

class MindMapWidget extends StackedView<MindMapModel> {
  final MindMap mindMap;
  final Node? selectedNode;
  final Offset mindMapOffset;
  final void Function(Node node) onNodeSelected;
  final void Function(Node node, Offset offset) onNodeDragged;

  const MindMapWidget({
    super.key,
    required this.mindMap,
    required this.selectedNode,
    this.mindMapOffset = Offset.zero,
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
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: MindMapPainter(mindMap: mindMap),
          ),
        ),
        ...mindMap.getNodes().map(
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
