import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Node {
  final String content;
  final String? parentUuid;
  List<String> childrenUuids;
  Offset position;
  final String uuid;

  Node({
    required this.content,
    required this.position,
    required this.parentUuid,
    required this.childrenUuids,
    required this.uuid,
  });

  Node.root(String content)
      : this(
          content: content,
          position: Offset.zero,
          parentUuid: null,
          childrenUuids: [],
          uuid: const Uuid().v4(),
        );

  Node.fromParams({
    required String content,
    required Offset position,
    required String parentUuid,
    required List<String> childrenUuids,
  }) : this(
          content: content,
          position: position,
          parentUuid: parentUuid,
          childrenUuids: childrenUuids,
          uuid: const Uuid().v4(),
        );

  bool get isRoot => parentUuid == null;

  void addChild(String childUuid) {
    childrenUuids.add(childUuid);
  }

  void updatePosition(Offset offset) {
    position += offset;
  }

  Node copyWith({
    String? content,
    Offset? position,
    List<String>? childrenUuids,
    String? parentUuid,
    String? uuid,
  }) {
    return Node(
      content: content ?? this.content,
      position: position ?? this.position,
      childrenUuids: childrenUuids ?? this.childrenUuids,
      parentUuid: parentUuid ?? this.parentUuid,
      uuid: uuid ?? this.uuid,
    );
  }

  @override
  String toString() {
    return 'Node(content: $content, parentUuid: $parentUuid, childrenUuids: $childrenUuids, position: $position, uuid: $uuid)';
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'parentUuid': parentUuid,
      'childrenUuids': childrenUuids,
      'position': OffsetSerializer.toMap(position),
      'uuid': uuid,
    };
  }

  factory Node.fromMap(Map<String, dynamic> map) {
    return Node(
      content: map['content'] ?? '',
      parentUuid: map['parentUuid'],
      childrenUuids: List<String>.from(map['childrenUuids']),
      position: OffsetSerializer.fromMap(map['position']),
      uuid: map['uuid'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Node.fromJson(String source) => Node.fromMap(json.decode(source));
}

abstract class OffsetSerializer {
  static Offset fromMap(Map<String, dynamic> map) {
    return Offset(map['dx'], map['dy']);
  }

  static Map<String, dynamic> toMap(Offset offset) {
    return {'dx': offset.dx, 'dy': offset.dy};
  }
}