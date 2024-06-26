// ignore: depend_on_referenced_packages
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:uuid/uuid.dart';

import 'package:open_mind/ui/views/mind_map/models/node.dart';

class MindMap {
  List<Node> nodes;
  final String name;
  final DateTime createdAt;
  final String uuid;

  MindMap({
    required this.nodes,
    required this.name,
    required this.createdAt,
    required this.uuid,
  });

  MindMap.fromName({
    required String name,
  }) : this(
          nodes: [
            Node.root(name),
          ],
          name: name,
          createdAt: DateTime.now(),
          uuid: const Uuid().v4(),
        );

  void addNode(Node node, String selectedNodeUuid) {
    nodes.add(node);

    final selectedNode = findNodeByUuid(selectedNodeUuid)!;
    selectedNode.addChild(node.uuid);
  }

  Node? findNodeByUuid(String uuid) {
    return nodes.firstWhereOrNull((node) => node.uuid == uuid);
  }

  void deleteNode(String uuid) {
    Node? nodeToDelete = findNodeByUuid(uuid);

    if (nodeToDelete != null) {
      // Delete children recursively
      for (String childUuid in List.from(nodeToDelete.childrenUuids)) {
        deleteNode(childUuid);
      }

      // Delete the node
      nodes.removeWhere((node) => node.uuid == uuid);

      // Remove reference from parent
      if (nodeToDelete.parentUuid != null) {
        Node? parentNode = findNodeByUuid(nodeToDelete.parentUuid!);
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
    String? uuid,
  }) {
    return MindMap(
      nodes: nodes ?? this.nodes,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      uuid: uuid ?? this.uuid,
    );
  }

  @override
  String toString() {
    return 'MindMap(nodes: $nodes, name: $name createdAt: $createdAt, uuid: $uuid)';
  }

  

  Map<String, dynamic> toMap() {
    return {
      'nodes': nodes.map((x) => x.toMap()).toList(),
      'name': name,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'uuid': uuid,
    };
  }

  factory MindMap.fromMap(Map<String, dynamic> map) {
    return MindMap(
      nodes: List<Node>.from(map['nodes']?.map((x) => Node.fromMap(x))),
      name: map['name'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      uuid: map['uuid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MindMap.fromJson(String source) => MindMap.fromMap(json.decode(source));
}
