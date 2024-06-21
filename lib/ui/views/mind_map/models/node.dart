import 'dart:ui';

import 'package:uuid/uuid.dart';

class Node {
  final String content;
  final Node? parent;
  List<Node> children;
  Offset position;
  final String uuid;

  Node({
    required this.content,
    required this.children,
    required this.position,
    required this.parent,
  }) : uuid = const Uuid().v4();

  Node.root(String content)
      : this(
          content: content,
          position: Offset.zero,
          parent: null,
          children: [],
        );

  bool get isRoot => parent == null;

  void addChild(Node node) {
    children.add(node);
  }

  void updatePosition(Offset offset) {
    position += offset;
  }

  @override
  String toString() {
    return 'Node(content: $content, parent: $parent, children: $children, position: $position)';
  }
}
