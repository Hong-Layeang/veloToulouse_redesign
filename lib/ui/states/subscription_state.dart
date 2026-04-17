import 'package:flutter/material.dart';
import 'package:velo_toulouse/model/subscription.dart';

class ActiveSubscription {
  final Subscription plan;
  final DateTime startDate;
  final DateTime expirationDate;

  const ActiveSubscription({
    required this.plan,
    required this.startDate,
    required this.expirationDate,
  });

  bool get isExpired => DateTime.now().isAfter(expirationDate);
  bool get isActive => !isExpired;
}

class SubscriptionState extends ChangeNotifier {
  ActiveSubscription? _activeSubscription;

  ActiveSubscription? get activeSubscription => _activeSubscription;
  bool get hasActiveSubscription =>
      _activeSubscription != null && _activeSubscription!.isActive;

  void subscribe(Subscription plan) {
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
