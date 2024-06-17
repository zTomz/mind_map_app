import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_map_app/features/mind_map/data/bloc/mind_map_bloc.dart';
import 'package:mind_map_app/features/mind_map/data/models/mind_map.dart';

@RoutePage()
class MindMapPage extends StatelessWidget {
  final MindMap mindMap;

  const MindMapPage({
    super.key,
    required this.mindMap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MindMapBloc(mindMap: mindMap),
      child: BlocBuilder<MindMapBloc, MindMapState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(mindMap.name),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
