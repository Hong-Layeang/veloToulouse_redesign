import 'package:flutter/material.dart';
import 'package:velo_toulouse/model/payment_method.dart';
import 'package:velo_toulouse/model/subscription.dart';
import 'package:velo_toulouse/ui/states/subscription_state.dart';
import 'package:velo_toulouse/data/repositories/subscription/subscription_repository.dart';

enum PaymentStatus { initial, processing, success, error }

class PaymentMethodViewModel extends ChangeNotifier {
  final Subscription plan;
  final SubscriptionRepository subscriptionRepository;
  final SubscriptionState subscriptionState;

  PaymentMethod? _selectedPaymentMethod;
  PaymentStatus _status = PaymentStatus.initial;
  String? _errorMessage;

  PaymentMethod? get selectedPaymentMethod => _selectedPaymentMethod;
  PaymentStatus get status => _status;
  String? get errorMessage => _errorMessage;

  PaymentMethodViewModel({
    required this.plan,
    required this.subscriptionRepository,
    required this.subscriptionState,
  });

  void selectPaymentMethod(PaymentMethod method) {
    _selectedPaymentMethod = method;
    notifyListeners();
  }

  Future<void> processPayment() async {
    if (_selectedPaymentMethod == null) {
      _status = PaymentStatus.error;
      _errorMessage = 'Please select a payment method';
      notifyListeners();
      return;
    }

    try {
      _status = PaymentStatus.processing;
      _errorMessage = null;
      notifyListeners();

      // Simulate payment processing
      await Future.delayed(const Duration(seconds: 2));

      // Apply subscription
      await subscriptionRepository.saveActiveSubscriptionId(plan.id);
      subscriptionState.subscribe(plan);
      _status = PaymentStatus.success;
    } catch (e) {
      _status = PaymentStatus.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }
}
