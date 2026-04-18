import 'package:flutter/material.dart';
import 'package:velo_toulouse/model/subscription.dart';
import 'package:velo_toulouse/ui/states/ride_state.dart';

class ConfirmationViewModel extends ChangeNotifier {
  final Subscription plan;
  final VoidCallback onFinish;
  final RideState rideState;

  ConfirmationViewModel({
    required this.plan,
    required this.onFinish,
    required this.rideState,
  });

  String get title => '${plan.label} Unlocked';

  String get subtitle => 'Your ${plan.label.toLowerCase()} is now active and ready to use.';

  // Handle finish button press
  void finish() {
    rideState.endRide();
    onFinish();
    notifyListeners();
  }
}
