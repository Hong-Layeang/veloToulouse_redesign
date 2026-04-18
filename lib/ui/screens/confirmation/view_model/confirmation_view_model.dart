import 'package:flutter/foundation.dart';

class ConfirmationViewModel {
  final VoidCallback onFinish;

  ConfirmationViewModel({
    required this.onFinish,
  });

  // Handle finish button press
  void finish() {
    onFinish();
  }
}
