import 'package:flutter/material.dart';

class ConfirmationViewModel extends ChangeNotifier {
  final VoidCallback onFinish;

  ConfirmationViewModel({
    required this.onFinish,
  });

  // Handle finish button press
  void finish() {
    onFinish();
  }
}
