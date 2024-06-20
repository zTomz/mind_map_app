import 'package:flutter/material.dart';
import 'package:open_mind/ui/common/theme_extension.dart';
import 'package:open_mind/ui/common/ui_helpers.dart';
import 'package:open_mind/ui/views/mind_map/models/node.dart';

class MindMapBubbel extends StatelessWidget {
  final Node node;

  const MindMapBubbel({
    super.key,
    required this.node,
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
    return Container(
      padding: const EdgeInsets.all(Spacing.medium),
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(Radii.medium),
      ),
      child: Text(node.content),
    );
  }
}
