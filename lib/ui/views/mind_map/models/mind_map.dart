// ignore: depend_on_referenced_packages
import 'dart:convert';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:open_mind/ui/common/exeptions/invalid_node_edit.dart';
import 'package:uuid/uuid.dart';

import 'package:open_mind/ui/views/mind_map/models/node.dart';

class MindMap {
  String name;
  List<Node> nodes;
  final DateTime createdAt;
  final DateTime lastEditedAt;
  final String uuid;

  MindMap({
    required this.name,
    required this.nodes,
    required this.createdAt,
    required this.lastEditedAt,
    required this.uuid,
  });

  MindMap.fromName({
    required String name,
  }) : this(
          name: name,
          nodes: [
            Node.root(name),
          ],
          createdAt: DateTime.now(),
          lastEditedAt: DateTime.now(),
          uuid: const Uuid().v4(),
        );

  static const int minNameLength = 3;

  /// Update the name of the mind map and the content of the root node
  void updateName(String newName) {
    // Update the name of the mind map
    name = newName;

    // Rename the root node
    nodes.firstWhere((node) => node.isRoot).content = newName;
  }

  /// Edit the provided node with the given params
  void editNode(
    Node node, {
    String? content,
    String? parentUuid,
    List<String>? childrenUuids,
    Offset? position,
    String? uuid,
  }) {
    if (content != null && content.length <= 3) {
      throw const InvalidNodeEditException(
        message: 'Content must be longer than 3 characters',
      );
    }

    final editedNode = node.copyWith(
      content: content,
      parentUuid: parentUuid,
      childrenUuids: childrenUuids,
      position: position,
      uuid: uuid,
    );

    // Remove the old node and add the new one
    deleteNode(node.uuid);
    addNode(editedNode, node.parentUuid);

    // If the node is the root node and the content is edited, update the name
    // of the mind map too
    if (editedNode.isRoot && content != null) {
      name = editedNode.content;
    }
  }

  /// Adds a new node to the selected node
  void addNode(Node node, String? selectedNodeUuid) {
    nodes.add(node);

    if (selectedNodeUuid != null) {
      final selectedNode = findNodeByUuid(selectedNodeUuid)!;
      selectedNode.addChild(node.uuid);
    }
  }

  /// Finds a node by its uuid. If no node is found, returns `null`
  Node? findNodeByUuid(String uuid) {
    return nodes.firstWhereOrNull((node) => node.uuid == uuid);
  }

  /// Deletes a node by its uuid. Then goes recursively through its children
  /// and removes them as well. Also removes the reference from it's parent
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
    String? name,
    List<Node>? nodes,
    DateTime? createdAt,
    DateTime? lastEditedAt,
    String? uuid,
  }) {
    return MindMap(
      name: name ?? this.name,
      nodes: nodes ?? this.nodes,
      createdAt: createdAt ?? this.createdAt,
      lastEditedAt: lastEditedAt ?? this.lastEditedAt,
      uuid: uuid ?? this.uuid,
    );
  }

  @override
  String toString() {
    return 'MindMap(name: $name, nodes: $nodes, createdAt: $createdAt, lastEditedAt: $lastEditedAt, uuid: $uuid)';
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'nodes': nodes.map((x) => x.toMap()).toList(),
      'createdAt': createdAt.millisecondsSinceEpoch,
      'lastEditedAt': lastEditedAt.millisecondsSinceEpoch,
      'uuid': uuid,
    };
  }

  factory MindMap.fromMap(Map<String, dynamic> map) {
    return MindMap(
      name: map['name'] ?? '',
      nodes: List<Node>.from(map['nodes']?.map((x) => Node.fromMap(x))),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      lastEditedAt: DateTime.fromMillisecondsSinceEpoch(map['lastEditedAt']),
      uuid: map['uuid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MindMap.fromJson(String source) =>
      MindMap.fromMap(json.decode(source));
}
