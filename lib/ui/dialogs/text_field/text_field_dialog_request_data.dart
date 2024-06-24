class TextFieldDialogRequestData {
  final String title;
  final String hintText;
  final String? prefillText;
  final String primaryButtonText;
  final String secondaryButtonText;

  const TextFieldDialogRequestData({
    required this.title,
    required this.hintText,
    this.prefillText,
    this.primaryButtonText = 'Create',
    this.secondaryButtonText = 'Cancel',
  });

  @override
  String toString() {
    return 'TextFieldDialogRequestData{title: $title, hintText: $hintText, prefillText: $prefillText}';
  }
}
