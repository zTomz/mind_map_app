// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:open_mind/ui/dialogs/text_field/basic_validator.dart';
import 'package:stacked/stacked.dart';

const bool _autoTextFieldValidation = true;

const String TextValueKey = 'text';

final Map<String, TextEditingController>
    _TextFieldDialogTextEditingControllers = {};

final Map<String, FocusNode> _TextFieldDialogFocusNodes = {};

final Map<String, String? Function(String?)?> _TextFieldDialogTextValidations =
    {
  TextValueKey: BasicValidator.validateText,
};

mixin $TextFieldDialog {
  TextEditingController get textController =>
      _getFormTextEditingController(TextValueKey);

  FocusNode get textFocusNode => _getFormFocusNode(TextValueKey);

  TextEditingController _getFormTextEditingController(
    String key, {
    String? initialValue,
  }) {
    if (_TextFieldDialogTextEditingControllers.containsKey(key)) {
      return _TextFieldDialogTextEditingControllers[key]!;
    }

    _TextFieldDialogTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _TextFieldDialogTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_TextFieldDialogFocusNodes.containsKey(key)) {
      return _TextFieldDialogFocusNodes[key]!;
    }
    _TextFieldDialogFocusNodes[key] = FocusNode();
    return _TextFieldDialogFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormStateHelper model) {
    textController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated(
    'Use syncFormWithViewModel instead.'
    'This feature was deprecated after 3.1.0.',
  )
  void listenToFormUpdated(FormViewModel model) {
    textController.addListener(() => _updateFormData(model));

    _updateFormData(model, forceValidate: _autoTextFieldValidation);
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormStateHelper model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          TextValueKey: textController.text,
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

    for (var controller in _TextFieldDialogTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _TextFieldDialogFocusNodes.values) {
      focusNode.dispose();
    }

    _TextFieldDialogTextEditingControllers.clear();
    _TextFieldDialogFocusNodes.clear();
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

  String? get textValue => this.formValueMap[TextValueKey] as String?;

  set textValue(String? value) {
    this.setData(
      this.formValueMap..addAll({TextValueKey: value}),
    );

    if (_TextFieldDialogTextEditingControllers.containsKey(TextValueKey)) {
      _TextFieldDialogTextEditingControllers[TextValueKey]?.text = value ?? '';
    }
  }

  bool get hasText =>
      this.formValueMap.containsKey(TextValueKey) &&
      (textValue?.isNotEmpty ?? false);

  bool get hasTextValidationMessage =>
      this.fieldsValidationMessages[TextValueKey]?.isNotEmpty ?? false;

  String? get textValidationMessage =>
      this.fieldsValidationMessages[TextValueKey];
}

extension Methods on FormStateHelper {
  setTextValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[TextValueKey] = validationMessage;

  /// Clears text input fields on the Form
  void clearForm() {
    textValue = '';
  }

  /// Validates text input fields on the Form
  void validateForm() {
    this.setValidationMessages({
      TextValueKey: getValidationMessage(TextValueKey),
    });
  }
}

/// Returns the validation message for the given key
String? getValidationMessage(String key) {
  final validatorForKey = _TextFieldDialogTextValidations[key];
  if (validatorForKey == null) return null;

  String? validationMessageForKey = validatorForKey(
    _TextFieldDialogTextEditingControllers[key]!.text,
  );

  return validationMessageForKey;
}

/// Updates the fieldsValidationMessages on the FormViewModel
void updateValidationData(FormStateHelper model) =>
    model.setValidationMessages({
      TextValueKey: getValidationMessage(TextValueKey),
    });
