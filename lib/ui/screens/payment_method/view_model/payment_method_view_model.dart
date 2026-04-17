import 'package:flutter/material.dart';
import 'package:velo_toulouse/model/subscription.dart';
import 'package:velo_toulouse/ui/states/subscription_state.dart';
import 'package:velo_toulouse/data/repositories/subscription/subscription_repository.dart';

enum PaymentMethod { applePay, googlePay, creditCard }

enum PaymentStatus { initial, processing, success, error }

class PaymentMethodViewModel extends ChangeNotifier {
  final Subscription plan;
  final SubscriptionRepository subscriptionRepository;
  final SubscriptionState subscriptionState;
  final VoidCallback? onSubscribed;

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
    this.onSubscribed,
  });

  void selectPaymentMethod(PaymentMethod method) {
    _selectedPaymentMethod = method;
    notifyListeners();
  }

  Future<void> processPayment() async {
    if (_selectedPaymentMethod == null) {
      _errorMessage = 'Please select a payment method';
      notifyListeners();
      return;
    }

    try {
      _status = PaymentStatus.processing;
      notifyListeners();

      // Simulate payment processing
      await Future.delayed(const Duration(seconds: 2));

      // Apply subscription
      subscriptionState.subscribe(plan);
      _status = PaymentStatus.success;
      onSubscribed?.call();
    } catch (e) {
      _status = PaymentStatus.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }
}
