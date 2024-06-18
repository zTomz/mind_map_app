import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'empty_sheet_model.dart';

class EmptySheet extends StackedView<EmptySheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const EmptySheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    EmptySheetModel viewModel,
    Widget? child,
  ) {
    return Container();
  }

  @override
  EmptySheetModel viewModelBuilder(BuildContext context) => EmptySheetModel();
}
