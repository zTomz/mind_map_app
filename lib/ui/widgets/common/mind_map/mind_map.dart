import 'package:flutter/material.dart';
import 'package:open_mind/ui/views/mind_map/models/mind_map.dart';
import 'package:open_mind/ui/widgets/common/mind_map/mind_map_bubbel.dart';
import 'package:stacked/stacked.dart';

import 'mind_map_model.dart';

class MindMapWidget extends StackedView<MindMapModel> {
  final MindMap mindMap;

  const MindMapWidget({
    super.key,
    required this.mindMap,
  });

  @override
  Widget builder(
    BuildContext context,
    MindMapModel viewModel,
    Widget? child,
  ) {

    return Stack(
      children: [
        Center(
          child: MindMapBubbel(node: viewModel.mindMap.root),
        ),
      ],
    );
  }

  @override
  MindMapModel viewModelBuilder(
    BuildContext context,
  ) =>
      MindMapModel(
        mindMap: mindMap,
      );
}
