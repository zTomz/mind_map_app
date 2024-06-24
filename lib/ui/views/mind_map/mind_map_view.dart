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
          if (viewModel.hasSelectedNode) ...[
            IconButton(
              onPressed: () async {
                final result = await locator<DialogService>()
                    .showCustomDialog<String, String>(
                  variant: DialogType.textField,
                  title: "Edit Node",
                  data: "Node Content",
                );

                if (result != null && result.confirmed && result.data != null) {
                  viewModel.editSelectedNode(content: result.data!);
                }
              },
              tooltip: "Edit Node",
              icon: const Icon(Icons.edit_rounded),
            ),
            if (!viewModel.selectedNode!.isRoot)
              IconButton(
                onPressed: () async {
                  final result =
                      await locator<DialogService>().showConfirmationDialog(
                    title: "Are you sure?",
                    description: "Are you sure you want to delete this node?",
                    confirmationTitle: "Delete",
                    confirmationTitleColor: context.colorScheme.error,
                    cancelTitleColor: context.colorScheme.primary,
                    dialogPlatform: DialogPlatform.Custom,
                  );

                  if (result?.confirmed ?? false) {
                    viewModel.deleteSelectedNode();
                  }
                },
                tooltip: "Delete Node",
                icon: const Icon(Icons.delete_rounded),
              ),
          ],
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          // Create new node
          final result =
              await locator<DialogService>().showCustomDialog<String, String>(
            variant: DialogType.textField,
            title: "Create New Node",
            data: "Node Content",
          );

          // FIXME: dont add node if no node selected
          // TODO: Change selected node to the new one

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
