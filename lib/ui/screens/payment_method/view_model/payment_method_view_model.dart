import 'package:flutter/material.dart';
import 'package:velo_toulouse/model/payment_method.dart';
import 'package:velo_toulouse/model/subscription.dart';
import 'package:velo_toulouse/ui/states/subscription_state.dart';
import 'package:velo_toulouse/data/repositories/subscription/subscription_repository.dart';
import 'package:velo_toulouse/ui/utils/async_value.dart';

class PaymentMethodViewModel extends ChangeNotifier {
  final Subscription plan;
  final SubscriptionRepository subscriptionRepository;
  final SubscriptionState subscriptionState;

  PaymentMethod? _selectedPaymentMethod;
  AsyncValue<Object?> _paymentValue = AsyncValue<Object?>.success(null);

  PaymentMethod? get selectedPaymentMethod => _selectedPaymentMethod;
  AsyncValue<Object?> get paymentValue => _paymentValue;
  bool get isProcessing => _paymentValue.state == AsyncValueState.loading;
  bool get isSuccess => _paymentValue.state == AsyncValueState.success;
  String? get errorMessage => _paymentValue.error?.toString();

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
      _paymentValue = AsyncValue<Object?>.error('Please select a payment method');
      notifyListeners();
      return;
    }

    try {
      _paymentValue = AsyncValue<Object?>.loading();
      notifyListeners();

      // Simulate payment processing
      await Future.delayed(const Duration(seconds: 2));

      // Apply subscription
      await subscriptionRepository.saveActiveSubscriptionId(plan.id);
      subscriptionState.subscribe(plan);
      _paymentValue = AsyncValue<Object?>.success(null);
    } catch (e) {
      _paymentValue = AsyncValue<Object?>.error(e);
    }
    notifyListeners();
  }
}
