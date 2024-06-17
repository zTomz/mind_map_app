part of 'mind_map_bloc.dart';

sealed class MindMapState extends Equatable {
  final MindMap mindMap;

  const MindMapState(this.mindMap);

  @override
  List<Object> get props => [mindMap];
}

final class MindMapInitial extends MindMapState {
  const MindMapInitial(super.mindMap);
}
