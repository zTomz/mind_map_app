import 'package:open_mind/ui/views/mind_map/models/node.dart';

class MindMap {
  final Node root;
  final String name;
  final DateTime createdAt;

  MindMap({
    required this.root,
    required this.name,
    required this.createdAt,
  });

  MindMap.fromName({required String name})
      : this(
          root: Node.root(name),
          name: name,
          createdAt: DateTime.now(),
        );

  List<Node> getNodes() {
    List<Node> nodes = [];

    _traverse(root, nodes);

    return nodes;
  }

  void _traverse(Node node, List<Node> nodes) {
    nodes.add(node);
    for (Node child in node.children) {
      _traverse(child, nodes);
    }
  }

  @override
  String toString() {
    return 'MindMap(root: $root, name: $name createdAt: $createdAt)';
  }
}
