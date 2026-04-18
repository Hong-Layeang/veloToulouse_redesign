import 'package:flutter/foundation.dart';
import 'package:velo_toulouse/model/subscription.dart';
import 'package:velo_toulouse/model/confirmation_type.dart';

class ConfirmationViewModel {
  final VoidCallback onFinish;
  final ConfirmationType type;
  final Subscription? subscription;
  final String? bikeName;
  final String? stationName;

  ConfirmationViewModel({
    required this.onFinish,
    required this.type,
    this.subscription,
    this.bikeName,
    this.stationName,
  });

  // Handle finish button press
  void finish() {
    onFinish();
  }
}
