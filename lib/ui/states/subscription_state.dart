import 'package:flutter/material.dart';
import '../../../models/subscription.dart';

class SubscriptionState extends ChangeNotifier {
  ActiveSubscription? _activeSubscription;

  ActiveSubscription? get activeSubscription => _activeSubscription;
  bool get hasActiveSubscription =>
      _activeSubscription != null && _activeSubscription!.isActive;

  void subscribe(SubscriptionPlan plan) {
    final now = DateTime.now();
    _activeSubscription = ActiveSubscription(
      plan: plan,
      startDate: now,
      expirationDate: now.add(plan.duration),
    );
    notifyListeners();
  }

  void cancelSubscription() {
    _activeSubscription = null;
    notifyListeners();
  }
}
