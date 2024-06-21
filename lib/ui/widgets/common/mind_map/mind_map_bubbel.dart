import 'package:flutter/material.dart';
import 'package:open_mind/ui/common/theme_extension.dart';
import 'package:open_mind/ui/common/ui_helpers.dart';
import 'package:open_mind/ui/views/mind_map/models/node.dart';

class MindMapBubbel extends StatelessWidget {
  final Node node;
  final bool isSelected;
  final void Function(Node node) onNodeSelected;
  final void Function(Node node, Offset offset) onNodeDragged;

  const MindMapBubbel({
    super.key,
    required this.node,
    required this.isSelected,
    required this.onNodeSelected,
    required this.onNodeDragged,
  });

  @override
  Widget build(BuildContext context) {
    if (node.isRoot) {
      return widgetBuilder(context);
    }

    return Positioned(
      top: node.position.dy,
      left: node.position.dx,
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
        onNodeDragged(node, details.localPosition);
      },
      onPanUpdate: (details) {
        onNodeDragged(node, details.delta);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.all(Spacing.medium),
          decoration: BoxDecoration(
            color: isSelected
                ? Colors.red
                : context.colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(Radii.medium),
          ),
          child: Text(node.content),
        ),
      ),
    );
  }
}
