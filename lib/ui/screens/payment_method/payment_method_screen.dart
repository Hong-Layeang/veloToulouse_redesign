import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velo_toulouse/data/repositories/subscription/subscription_repository.dart';
import 'package:velo_toulouse/model/subscription.dart';
import 'package:velo_toulouse/ui/screens/payment_method/view_model/payment_method_view_model.dart';
import 'package:velo_toulouse/ui/screens/payment_method/widgets/payment_method_content.dart';
import 'package:velo_toulouse/ui/states/subscription_state.dart';

class PaymentMethodScreen extends StatelessWidget {
  final Subscription plan;
  final bool returnToPreviousAfterConfirmation;

  const PaymentMethodScreen({
    super.key,
    required this.plan,
    this.returnToPreviousAfterConfirmation = false,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PaymentMethodViewModel>(
      create: (context) => PaymentMethodViewModel(
        plan: plan,
        subscriptionRepository: context.read<SubscriptionRepository>(),
        subscriptionState: context.read<SubscriptionState>(),
      ),
      child: PaymentMethodContent(
        returnToPreviousAfterConfirmation: returnToPreviousAfterConfirmation,
      ),
    );
  }
}

