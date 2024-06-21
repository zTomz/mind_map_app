import 'package:flutter/material.dart';
import 'package:open_mind/app/app.dialogs.dart';
import 'package:open_mind/app/app.locator.dart';
import 'package:open_mind/ui/common/theme_extension.dart';
import 'package:open_mind/ui/views/mind_map/models/mind_map.dart';
import 'package:open_mind/ui/widgets/common/mind_map/mind_map.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // Create new node
          final result =
              await locator<DialogService>().showCustomDialog<String, String>(
            variant: DialogType.textField,
            title: "Create New Node",
            data: "Node Content",
          );

          if (result != null && result.confirmed && result.data != null) {
            viewModel.addNodeToSelectedNode(result.data!);
          }
        },
        label: Text(
          "Create Node",
          style: TextStyle(
            color: context.colorScheme.onPrimaryContainer,
          ),
        ),
        icon: Icon(
          Icons.add,
          color: context.colorScheme.onPrimaryContainer,
        ),
      ),
      body: MindMapWidget(
        mindMap: viewModel.mindMap,
        selectedNode: viewModel.selectedNode,
        onNodeSelected: (node) {
          viewModel.selectNode(node);
        },
        onNodeDragged: (node, offset) {
          viewModel.dragNode(node, offset);
        },
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
