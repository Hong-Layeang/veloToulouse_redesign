import 'package:flutter/material.dart';
import 'package:velo_toulouse/model/subscription.dart';
import 'package:velo_toulouse/data/repositories/subscription/subscription_repository.dart';
import 'package:velo_toulouse/ui/utils/async_value.dart';

class SubscriptionsViewModel extends ChangeNotifier {
  final SubscriptionRepository subscriptionRepository;
  AsyncValue<List<Subscription>> _plansValue =
      AsyncValue<List<Subscription>>.loading();

  AsyncValue<List<Subscription>> get plansValue => _plansValue;
  List<Subscription> get plans => _plansValue.data ?? const <Subscription>[];
  String? get errorMessage => _plansValue.error?.toString();

  SubscriptionsViewModel({required this.subscriptionRepository}) {
    _init();
  }

  Future<void> _init() async {
    _plansValue = AsyncValue<List<Subscription>>.loading();
    notifyListeners();

    try {
      final plans = await subscriptionRepository.fetchSubscriptions();
      _plansValue = AsyncValue<List<Subscription>>.success(plans);
    } catch (e) {
      _plansValue = AsyncValue<List<Subscription>>.error(e);
    }
    notifyListeners();
  }
}
