class Node {
  final String content;
  final Node? parent;
  final List<Node> children;
  final int level;

  Node({
    required this.content,
    this.parent,
    required this.children,
    required this.level,
  });

  Node.root(String content)
      : this(
          content: content,
          parent: null,
          children: [],
          level: 0,
        );
}
