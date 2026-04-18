import 'package:flutter/material.dart';
import 'package:velo_toulouse/model/subscription.dart';
import 'package:velo_toulouse/data/repositories/subscription/subscription_repository.dart';

final List<Subscription> availablePlans = <Subscription>[
  Subscription(
    id: 'day_pass',
    label: 'Day Pass',
    description: 'Unlimited 30 minutes rides\nValid for 24 hours',
    price: 3,
    duration: const Duration(days: 1),
    rideDuration: const Duration(minutes: 30),
  ),
  Subscription(
    id: 'monthly_pass',
    label: 'Monthly Pass - Best Deal',
    description: 'Unlimited 45 minutes rides\nValid for 1 month',
    price: 25,
    duration: const Duration(days: 30),
    rideDuration: const Duration(minutes: 45),
  ),
  Subscription(
    id: 'annual_pass',
    label: 'Annual Pass',
    description: 'Unlimited 45 minutes rides\nValid for 1 year',
    price: 50,
    duration: const Duration(days: 365),
    rideDuration: const Duration(minutes: 45),
  ),
];

enum SubscriptionsStatus { loading, success, error }

class SubscriptionsViewModel extends ChangeNotifier {
  final SubscriptionRepository subscriptionRepository;
  
  SubscriptionsStatus _status = SubscriptionsStatus.success;
  List<Subscription> _plans = availablePlans;
  String? _errorMessage;
  String? _selectedPlanId;

  SubscriptionsStatus get status => _status;
  List<Subscription> get plans => _plans;
  String? get errorMessage => _errorMessage;
  String? get selectedPlanId => _selectedPlanId;

  void selectPlan(Subscription plan) {
    _selectedPlanId = plan.id;
    notifyListeners();
  }

  Subscription? get selectedPlan {
    if (_selectedPlanId == null) {
      return null;
    }

    for (final Subscription plan in _plans) {
      if (plan.id == _selectedPlanId) {
        return plan;
      }
    }

    return null;
  }

  SubscriptionsViewModel({required this.subscriptionRepository}) {
    _init();
  }

  Future<void> _init() async {
    try {
      _status = SubscriptionsStatus.success;
      _plans = availablePlans;
    } catch (e) {
      _status = SubscriptionsStatus.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }
}
