import 'package:flutter/material.dart';
import 'package:open_mind/ui/views/mind_map/models/mind_map.dart';
import 'package:open_mind/ui/widgets/common/mind_map/mind_map.dart';
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
        title: Text(mindMap.name),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: MindMapWidget(mindMap: mindMap),
    );
  }

  @override
  MindMapViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MindMapViewModel();
}
