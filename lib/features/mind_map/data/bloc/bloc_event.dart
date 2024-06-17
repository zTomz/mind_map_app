part of 'mind_map_bloc.dart';

sealed class MindMapEvent {
  const MindMapEvent();
}

final class MindMapCreated extends MindMapEvent {
  final MindMap mindMap;

  const MindMapCreated({
    required this.mindMap,
  });
}

final class NewNodeAdded extends MindMapEvent {
  final MindMap mindMap;
  final Node newNode;

  const NewNodeAdded({
    required this.mindMap,
    required this.newNode,
  });
}

final class NodeDeleted extends MindMapEvent {
  final MindMap mindMap;
  final Node deletedNode;

  const NodeDeleted({
    required this.mindMap,
    required this.deletedNode,
  });
}

final class NodeChanged extends MindMapEvent {
  final MindMap mindMap;
  final Node changedNode;

  const NodeChanged({
    required this.mindMap,
    required this.changedNode,
  });
}
