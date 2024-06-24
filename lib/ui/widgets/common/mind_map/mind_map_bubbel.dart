import 'package:flutter/material.dart';
import 'package:open_mind/ui/common/theme_extension.dart';
import 'package:open_mind/ui/common/ui_helpers.dart';
import 'package:open_mind/ui/views/mind_map/models/node.dart';

class MindMapBubbel extends StatelessWidget {
  final Node node;
  final bool isSelected;
  final void Function(Node node) onNodeSelected;
  final void Function(Node node, Offset offset) onNodeDragged;
  final Offset panningOffset;

  const MindMapBubbel({
    super.key,
    required this.node,
    required this.isSelected,
    required this.onNodeSelected,
    required this.onNodeDragged,
    required this.panningOffset,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: node.position.dy + panningOffset.dy,
      left: node.position.dx + panningOffset.dx,
      child: widgetBuilder(context),
    );
  }

  Widget widgetBuilder(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onNodeSelected(node);
      },
      onPanStart: (details) {
        onNodeSelected(node);
      },
      onPanUpdate: (details) {
        onNodeDragged(node, details.delta);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: Spacing.small, vertical: Spacing.small * 0.75),
          decoration: BoxDecoration(
            color: isSelected
                ? context.colorScheme.tertiaryContainer
                : context.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(Radii.small),
          ),
          child: Text(node.content),
        ),
      ),
    );
  }
}
