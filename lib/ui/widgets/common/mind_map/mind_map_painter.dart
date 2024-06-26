import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:open_mind/ui/views/mind_map/models/mind_map.dart';
import 'package:open_mind/ui/views/mind_map/models/node.dart';
import 'package:open_mind/ui/widgets/common/mind_map/mind_map.dart';

class MindMapPainter extends CustomPainter {
  final MindMap mindMap;
  final Offset panningOffset;

  MindMapPainter({
    required this.mindMap,
    required this.panningOffset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (Node node in mindMap.nodes) {
      if (node.isRoot) {
        continue;
      }

      final parent = mindMap.nodes.firstWhere((n) => n.uuid == node.parentUuid);

      final nodeBubbleSize = MindMapWidget.calculateBubbleSize(node);
      final parentBubbleSize = MindMapWidget.calculateBubbleSize(parent);

      final nodePos = node.position +
          Offset(
            nodeBubbleSize.width / 2,
            nodeBubbleSize.height / 2,
          ) +
          panningOffset;
      final parentPos = parent.position +
          Offset(
            parentBubbleSize.width / 2,
            parentBubbleSize.height / 2,
          ) +
          panningOffset;

      final rect = Rect.fromLTRB(
        math.min(nodePos.dx, parentPos.dx),
        math.min(nodePos.dy, parentPos.dy),
        math.max(nodePos.dx, parentPos.dx),
        math.max(nodePos.dy, parentPos.dy),
      );

      final path = Path()
        ..moveTo(nodePos.dx, nodePos.dy)
        ..quadraticBezierTo(
            nodePos.dx > parentPos.dx ? rect.right : rect.left,
            nodePos.dy > parentPos.dy ? rect.top : rect.bottom,
            parentPos.dx,
            parentPos.dy);

      canvas.drawPath(
        path,
        Paint()
          ..color = Colors.green
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3,
      );
    }
  }

  @override
  bool shouldRepaint(MindMapPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(MindMapPainter oldDelegate) => false;
}
