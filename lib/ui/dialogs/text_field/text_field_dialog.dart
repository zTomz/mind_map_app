import 'package:flutter/material.dart';
import 'package:open_mind/ui/common/theme_extension.dart';
import 'package:open_mind/ui/dialogs/text_field/basic_validator.dart';
import 'package:open_mind/ui/dialogs/text_field/text_field_dialog.form.dart';
import 'package:open_mind/ui/dialogs/text_field/text_field_model.dart';
import 'package:open_mind/ui/widgets/common/material_dialog/material_dialog.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@FormView(fields: [
  FormTextField(
    name: 'text',
    validator: BasicValidator.validateText,
  ),
])
class TextFieldDialog extends StackedView<TextFieldDialogModel>
    with $TextFieldDialog {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const TextFieldDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TextFieldDialogModel viewModel,
    Widget? child,
  ) {
   
    return MaterialDialog(
      title: request.title ?? "Error",
      icon: Icons.edit_rounded,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: textController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: request.data,
            ),
          ),
          if (viewModel.hasTextValidationMessage) ...[
            const SizedBox(height: 5),
            Text(
              viewModel.textValidationMessage!,
              style: TextStyle(
                color: context.colorScheme.error,
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
      onConfirm: () {
        if (!validateFormFields(viewModel)) return;

        completer(
          DialogResponse<String>(
            confirmed: true,
            data: textController.text,
          ),
        );
      },
      onCancel: () => completer(
        DialogResponse<String>(
          confirmed: false,
        ),
      ),
    );
  }

  @override
  TextFieldDialogModel viewModelBuilder(BuildContext context) =>
      TextFieldDialogModel();

  @override
  void onViewModelReady(TextFieldDialogModel viewModel) {
    syncFormWithViewModel(viewModel);
  }

  @override
  void onDispose(TextFieldDialogModel viewModel) {
    super.onDispose(viewModel);

    disposeForm();
  }
}
