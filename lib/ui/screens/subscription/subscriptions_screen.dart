import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velo_toulouse/data/repositories/subscription/subscription_repository.dart';
import 'package:velo_toulouse/ui/screens/subscription/view_model/subscriptions_view_model.dart';
import 'package:velo_toulouse/ui/screens/subscription/widgets/subscriptions_content.dart';

/// Wrapper screen that creates the ViewModel and provides it to content
class SubscriptionsScreenWrapper extends StatelessWidget {
  const SubscriptionsScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SubscriptionsViewModel>(
      create: (context) => SubscriptionsViewModel(
        subscriptionRepository: context.read<SubscriptionRepository>(),
      ),
      child: const SubscriptionsContent(),
    );
  }
}

/// Standalone screen (used when navigating directly)
class SubscriptionsScreen extends StatelessWidget {
  const SubscriptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SubscriptionsScreenWrapper();
  }
}
