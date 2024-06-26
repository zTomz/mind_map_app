import 'package:flutter/material.dart';
import 'package:open_mind/app/app.dialogs.dart';
import 'package:open_mind/app/app.locator.dart';
import 'package:open_mind/app/app.router.dart';
import 'package:open_mind/ui/common/theme_extension.dart';
import 'package:open_mind/ui/common/ui_helpers.dart';
import 'package:open_mind/ui/dialogs/text_field/text_field_dialog_request_data.dart';
import 'package:open_mind/ui/views/mind_map/models/mind_map.dart';
import 'package:open_mind/ui/widgets/common/editable_text/editable_text_widget.dart';
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
        title: EditableTextWidget(
          text: mindMap.name,
          onChanged: (value) async {
            if (value.length < MindMap.minNameLength) {
              ScaffoldMessenger.of(context).clearSnackBars();
              showMaterialSnackBar(
                context,
                message:
                    'The mind map name has to be at least ${MindMap.minNameLength} characters long',
              );
              return;
            }

            await viewModel.updateMindMapName(value);
          },
        ),
        leading: BackButton(
          onPressed: () async {
            await viewModel.saveMindMap();
            locator<NavigationService>().clearStackAndShow(Routes.homeView);
          },
        ),
        actions: [
          if (viewModel.hasSelectedNode) ...[
            IconButton(
              onPressed: () async {
                final data = TextFieldDialogRequestData(
                  title: 'Edit Node',
                  hintText: 'Node Content',
                  prefillText: viewModel
                      .findNodeByUuid(viewModel.selectedNode!)!
                      .content,
                  primaryButtonText: 'Edit',
                );

                final result = await locator<DialogService>()
                    .showCustomDialog<String, TextFieldDialogRequestData>(
                  variant: DialogType.textField,
                  data: data,
                );

                if (result != null && result.confirmed && result.data != null) {
                  viewModel.editSelectedNode(content: result.data!);
                }
              },
              tooltip: "Edit Node",
              icon: const Icon(Icons.edit_rounded),
            ),
            if (!(viewModel.findNodeByUuid(viewModel.selectedNode)?.isRoot ??
                false))
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
                    await viewModel.deleteSelectedNode();
                  }
                },
                tooltip: "Delete Node",
                icon: const Icon(Icons.delete_rounded),
              ),
          ],
        ],
      ),
      floatingActionButton: viewModel.hasSelectedNode
          ? FloatingActionButton.extended(
              onPressed: () async {
                // Create new node
                final result = await locator<DialogService>()
                    .showCustomDialog<String, TextFieldDialogRequestData>(
                  variant: DialogType.textField,
                  data: const TextFieldDialogRequestData(
                    title: 'Create New Node',
                    hintText: 'Node Content',
                  ),
                );

                if (result != null && result.confirmed && result.data != null) {
                  final newNode = await viewModel.addNodeToSelectedNode(
                    result.data!,
                  );
                  viewModel.selectNode(newNode.uuid);
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
            )
          : null,
      body: MindMapWidget(
        mindMap: viewModel.mindMap,
        selectedNodeUuid: viewModel.selectedNode,
        onNodeSelected: (node) {
          viewModel.selectNode(node.uuid);
        },
        onNodeDragged: (node, offset) {
          viewModel.dragNode(node, offset);
        },
        onNodeDragEnd: () async => await viewModel.saveMindMap(),
        onPan: (_) => viewModel.selectNode(null),
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
