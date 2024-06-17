import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mind_map_app/features/mind_map/data/models/mind_map.dart';
import 'package:mind_map_app/features/mind_map/data/models/node.dart';

part 'bloc_event.dart';
part 'bloc_state.dart';

class MindMapBloc extends Bloc<MindMapEvent, MindMapState> {
  MindMapBloc({
    required MindMap mindMap,
  }) : super(MindMapInitial(mindMap));
}
