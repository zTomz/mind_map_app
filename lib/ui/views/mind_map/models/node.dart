import 'dart:ui';

class Node {
  final String content;
  final Node? parent;
  final List<Node> children;
  final Offset position;

  Node({
    required this.content,
    required this.children,
    required this.position,
    this.parent,
  });

  Node.root(String content)
      : this(
          content: content,
          position: Offset.zero,
          parent: null,
          children: [],
        );

  bool get isRoot => parent == null;

  @override
  String toString() {
    return 'Node(content: $content, parent: $parent, children: $children, position: $position)';
  }
}
