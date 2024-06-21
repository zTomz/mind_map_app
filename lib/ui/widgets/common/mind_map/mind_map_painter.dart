import 'package:flutter/material.dart';
import 'package:open_mind/ui/views/mind_map/models/mind_map.dart';
import 'package:open_mind/ui/views/mind_map/models/node.dart';

class MindMapPainter extends CustomPainter {
  final MindMap mindMap;

  MindMapPainter({
    required this.mindMap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (Node node in mindMap.getNodes()) {
      if (node.isRoot) {
        continue;
      }

      canvas.drawLine(
        node.position,
        node.parent!.position,
        Paint()..color = Colors.black,
      );
    }
  }

  @override
  bool shouldRepaint(MindMapPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(MindMapPainter oldDelegate) => false;
}
