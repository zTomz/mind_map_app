// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:open_mind/ui/dialogs/create_new_mind_map/form_validator.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String MindMapNameValueKey = 'mindMapName';

final Map<String, TextEditingController>
    _CreateNewMindMapDialogTextEditingControllers = {};

final Map<String, FocusNode> _CreateNewMindMapDialogFocusNodes = {};

final Map<String, String? Function(String?)?>
    _CreateNewMindMapDialogTextValidations = {
  MindMapNameValueKey: CreateNewMindMapFormValidator.validateMindMapName,
};

mixin $CreateNewMindMapDialog {
  TextEditingController get mindMapNameController =>
      _getFormTextEditingController(MindMapNameValueKey);

  FocusNode get mindMapNameFocusNode => _getFormFocusNode(MindMapNameValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_CreateNewMindMapDialogTextEditingControllers.containsKey(key)) {
      return _CreateNewMindMapDialogTextEditingControllers[key]!;
    }

    _CreateNewMindMapDialogTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _CreateNewMindMapDialogTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_CreateNewMindMapDialogFocusNodes.containsKey(key)) {
      return _CreateNewMindMapDialogFocusNodes[key]!;
    }
    _CreateNewMindMapDialogFocusNodes[key] = FocusNode();
    return _CreateNewMindMapDialogFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    mindMapNameController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    mindMapNameController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          MindMapNameValueKey: mindMapNameController.text,
        }),
    );

    if (_autoTextFieldValidation || forceValidate) {
      updateValidationData(model);
    }
  }

  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller
        in _CreateNewMindMapDialogTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _CreateNewMindMapDialogFocusNodes.values) {
      focusNode.dispose();
    }

    _CreateNewMindMapDialogTextEditingControllers.clear();
    _CreateNewMindMapDialogFocusNodes.clear();
  }
}

extension ValueProperties on FormStateHelper {
  bool get hasAnyValidationMessage => this
      .fieldsValidationMessages
      .values
      .any((validation) => validation != null);

  bool get isFormValid {
    if (!_autoTextFieldValidation) this.validateForm();

    return !hasAnyValidationMessage;
  }

  String? get mindMapNameValue =>
      this.formValueMap[MindMapNameValueKey] as String?;

  set mindMapNameValue(String? value) {
    this.setData(
      this.formValueMap..addAll({MindMapNameValueKey: value}),
    );

    if (_CreateNewMindMapDialogTextEditingControllers.containsKey(
        MindMapNameValueKey)) {
      _CreateNewMindMapDialogTextEditingControllers[MindMapNameValueKey]?.text =
          value ?? '';
    }
  }

  bool get hasMindMapName =>
      this.formValueMap.containsKey(MindMapNameValueKey) &&
      (mindMapNameValue?.isNotEmpty ?? false);

  bool get hasMindMapNameValidationMessage =>
      this.fieldsValidationMessages[MindMapNameValueKey]?.isNotEmpty ?? false;

  String? get mindMapNameValidationMessage =>
      this.fieldsValidationMessages[MindMapNameValueKey];
}

extension Methods on FormStateHelper {
  setMindMapNameValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[MindMapNameValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    mindMapNameValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      MindMapNameValueKey: getValidationMessage(MindMapNameValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _CreateNewMindMapDialogTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _CreateNewMindMapDialogTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      MindMapNameValueKey: getValidationMessage(MindMapNameValueKey),
    });
