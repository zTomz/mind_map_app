import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'empty_dialog_model.dart';

class EmptyDialog extends StackedView<EmptyDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const EmptyDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    EmptyDialogModel viewModel,
    Widget? child,
  ) {
    return const SimpleDialog();
  }

  @override
  EmptyDialogModel viewModelBuilder(BuildContext context) => EmptyDialogModel();
}
