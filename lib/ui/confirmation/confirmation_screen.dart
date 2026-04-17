import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velo_toulouse/model/subscription.dart';
import 'package:velo_toulouse/ui/states/ride_state.dart';
import 'view_model/confirmation_view_model.dart';
import 'widgets/confirmation_content.dart';

class ConfirmationScreen extends StatelessWidget {
  final Subscription plan;
  final VoidCallback onFinish;

  const ConfirmationScreen({
    super.key,
    required this.plan,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ConfirmationViewModel>(
      create: (context) => ConfirmationViewModel(
        plan: plan,
        onFinish: onFinish,
        rideState: context.read<RideState>(),
      ),
      child: const ConfirmationContent(),
    );
  }
}
