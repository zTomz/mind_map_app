import 'dart:ui';

import 'package:stacked/stacked.dart';

class MindMapModel extends BaseViewModel {
  bool isPanning = false;
  Offset panningOffset = Offset.zero;

  void setPanning(bool value) {
    isPanning = value;
    rebuildUi();
  }

  /// Updates the panning offset and sets the panning state to true
  void updatePanningOffset(Offset amount) {
    panningOffset += amount;
    isPanning = true;
    rebuildUi();
  }
}
