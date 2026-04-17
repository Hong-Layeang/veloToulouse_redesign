import 'package:flutter/material.dart';
import 'package:velo_toulouse/model/subscription.dart';
import 'package:velo_toulouse/data/repositories/subscription/subscription_repository.dart';

enum SubscriptionsStatus { loading, success, error }

class SubscriptionsViewModel extends ChangeNotifier {
  final SubscriptionRepository subscriptionRepository;
  
  SubscriptionsStatus _status = SubscriptionsStatus.loading;
  List<Subscription> _plans = <Subscription>[];
  String? _errorMessage;

  SubscriptionsStatus get status => _status;
  List<Subscription> get plans => _plans;
  String? get errorMessage => _errorMessage;

  SubscriptionsViewModel({required this.subscriptionRepository}) {
    _init();
  }

  Future<void> _init() async {
    try {
      _status = SubscriptionsStatus.loading;
      _errorMessage = null;
      notifyListeners();

      _plans = await subscriptionRepository.fetchSubscriptions();
      _status = SubscriptionsStatus.success;
    } catch (e) {
      _status = SubscriptionsStatus.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }
}
