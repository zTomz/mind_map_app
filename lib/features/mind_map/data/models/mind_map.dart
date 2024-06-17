import 'package:mind_map_app/features/mind_map/data/models/node.dart';

class MindMap {
  final Node root;
  final String name;
  final DateTime createdAt;

  MindMap({
    required this.root,
    required this.name,
    required this.createdAt,
  });

  MindMap.fromName({required String name}) : this(
    root: Node.root(name),
    name: name,
    createdAt: DateTime.now(),
  );
}
