import 'package:flutter/material.dart';
import 'package:open_mind/ui/common/ui_helpers.dart';
import 'package:open_mind/ui/views/mind_map/models/mind_map.dart';
import 'package:open_mind/ui/views/mind_map/models/node.dart';
import 'package:open_mind/ui/widgets/common/mind_map/mind_map_bubbel.dart';
import 'package:open_mind/ui/widgets/common/mind_map/mind_map_painter.dart';
import 'package:stacked/stacked.dart';

import 'mind_map_model.dart';

class MindMapWidget extends StackedView<MindMapModel> {
  final MindMap mindMap;
  final String? selectedNodeUuid;
  final Offset mindMapOffset;
  final void Function(Node node) onNodeSelected;
  final void Function(Node node, Offset offset) onNodeDragged;
  final void Function() onNodeDragEnd;
  final void Function(Offset offset) onPan;

  const MindMapWidget({
    super.key,
    required this.mindMap,
    required this.selectedNodeUuid,
    this.mindMapOffset = Offset.zero,
    required this.onNodeSelected,
    required this.onNodeDragged,
    required this.onNodeDragEnd,
    required this.onPan,
  });

  @override
  Widget builder(
    BuildContext context,
    MindMapModel viewModel,
    Widget? child,
  ) {
    return GestureDetector(
      onPanUpdate: (details) {
        viewModel.updatePanningOffset(details.delta);
        onPan(details.delta);
      },
      onPanEnd: (details) {
        viewModel.setPanning(false);
      },
      child: MouseRegion(
        cursor: viewModel.isPanning
            ? SystemMouseCursors.move
            : SystemMouseCursors.basic,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: MindMapPainter(
                  mindMap: mindMap,
                  panningOffset: viewModel.panningOffset,
                ),
              ),
            ),
            ...mindMap.nodes.map(
              (node) => MindMapBubbel(
                node: node,
                isSelected: selectedNodeUuid == node.uuid,
                onNodeSelected: onNodeSelected,
                onNodeDragged: onNodeDragged,
                onNodeDragEnd: onNodeDragEnd,
                panningOffset: viewModel.panningOffset,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  MindMapModel viewModelBuilder(
    BuildContext context,
  ) =>
      MindMapModel();

  static Size calculateBubbleSize(Node node) {
    final textPainter = TextPainter(
      text: TextSpan(text: node.content),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    final textSize = textPainter.size;

    return Size(
      textSize.width + Spacing.small * 2,
      textSize.height + (Spacing.small * 0.75) * 2,
    );
  }
}
