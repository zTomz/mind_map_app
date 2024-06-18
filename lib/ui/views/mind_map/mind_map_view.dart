import 'package:flutter/material.dart';
import 'package:open_mind/ui/views/mind_map/models/mind_map.dart';
import 'package:stacked/stacked.dart';

import 'mind_map_viewmodel.dart';

class MindMapView extends StackedView<MindMapViewModel> {
  final MindMap mindMap;

  const MindMapView({
    super.key,
    required this.mindMap,
  });

  @override
  Widget builder(
    BuildContext context,
    MindMapViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.mindMap.name),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  MindMapViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MindMapViewModel(
        mindMap: mindMap,
      );
}
