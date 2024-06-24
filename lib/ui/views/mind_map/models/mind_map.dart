// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:open_mind/ui/views/mind_map/models/node.dart';

class MindMap {
  List<Node> nodes;
  final String name;
  final DateTime createdAt;

  MindMap({
    required this.nodes,
    required this.name,
    required this.createdAt,
  });

  MindMap.fromName({
    required String name,
  }) : this(
          nodes: [
            Node.root(name),
          ],
          name: name,
          createdAt: DateTime.now(),
        );

  void addNode(Node node, Node selectedNode) {
    nodes.add(node);
    selectedNode.addChild(node.uuid);
  }

  Node? _findNodeByUuid(String uuid) {
    return nodes.firstWhereOrNull((node) => node.uuid == uuid);
  }

  void deleteNode(String uuid) {
    Node? nodeToDelete = _findNodeByUuid(uuid);

    if (nodeToDelete != null) {
      // Delete children recursively
      for (String childUuid in List.from(nodeToDelete.childrenUuids)) {
        deleteNode(childUuid);
      }

      // Delete the node
      nodes.removeWhere((node) => node.uuid == uuid);

      // Remove reference from parent
      if (nodeToDelete.parentUuid != null) {
        Node? parentNode = _findNodeByUuid(nodeToDelete.parentUuid!);
        if (parentNode != null) {
          parentNode.childrenUuids.remove(uuid);
        }
      }
    }
  }

  MindMap copyWith({
    List<Node>? nodes,
    String? name,
    DateTime? createdAt,
  }) {
    return MindMap(
      nodes: nodes ?? this.nodes,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'MindMap(nodes: $nodes, name: $name createdAt: $createdAt)';
  }
}
