import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velo_toulouse/data/repositories/subscription/subscription_repository.dart';
import 'package:velo_toulouse/ui/screens/subscription/view_model/subscriptions_view_model.dart';
import 'package:velo_toulouse/ui/screens/subscription/widgets/subscriptions_content.dart';

class SubscriptionsScreen extends StatelessWidget {
  final bool returnToPreviousAfterSubscription;

  const SubscriptionsScreen({
    super.key,
    this.returnToPreviousAfterSubscription = false,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SubscriptionsViewModel>(
      create: (context) => SubscriptionsViewModel(
        subscriptionRepository: context.read<SubscriptionRepository>(),
      ),
      child: SubscriptionsContent(
        returnToPreviousAfterSubscription: returnToPreviousAfterSubscription,
      ),
    );
  }
}
