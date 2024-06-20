import 'package:flutter/material.dart';
import 'package:open_mind/ui/common/theme_extension.dart';
import 'package:open_mind/ui/dialogs/create_new_mind_map/form_validator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import 'create_new_mind_map_dialog_model.dart';
import 'create_new_mind_map_dialog.form.dart';

@FormView(fields: [
  FormTextField(
    name: 'mindMapName',
    validator: CreateNewMindMapFormValidator.validateMindMapName,
  ),
])
class CreateNewMindMapDialog extends StackedView<CreateNewMindMapDialogModel>
    with $CreateNewMindMapDialog {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const CreateNewMindMapDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CreateNewMindMapDialogModel viewModel,
    Widget? child,
  ) {
    return SimpleDialog(
      titlePadding: const EdgeInsets.only(
        left: 24,
        top: 24,
        right: 24,
        bottom: 0,
      ),
      contentPadding: const EdgeInsets.all(24),
      backgroundColor: context.colorScheme.surfaceContainerHigh,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.edit_rounded,
            color: context.colorScheme.secondary,
          ),
          const SizedBox(height: 24),
          const Text("Create New Mind Map"),
        ],
      ),
      children: [
        TextFormField(
          controller: mindMapNameController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Mind Map Name',
          ),
        ),
        if (viewModel.hasMindMapNameValidationMessage) ...[
          const SizedBox(height: 5),
          Text(
            viewModel.mindMapNameValidationMessage!,
            style: TextStyle(
              color: context.colorScheme.error,
              fontSize: 12,
            ),
          ),
        ],
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => completer(
                DialogResponse<String>(
                  confirmed: false,
                ),
              ),
              child: const Text('Cancel'),
            ),
            const SizedBox(width: 12),
            FilledButton.tonal(
              onPressed: () {
                if (!validateFormFields(viewModel)) return;

                completer(
                  DialogResponse<String>(
                    confirmed: true,
                    data: mindMapNameController.text,
                  ),
                );
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ],
    );
  }

  @override
  CreateNewMindMapDialogModel viewModelBuilder(BuildContext context) =>
      CreateNewMindMapDialogModel();

  @override
  void onViewModelReady(CreateNewMindMapDialogModel viewModel) {
    syncFormWithViewModel(viewModel);
  }

  @override
  void onDispose(CreateNewMindMapDialogModel viewModel) {
    super.onDispose(viewModel);

    disposeForm();
  }
}
