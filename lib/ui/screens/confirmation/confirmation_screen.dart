import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velo_toulouse/model/subscription.dart';
import 'package:velo_toulouse/model/confirmation_type.dart';
import 'view_model/confirmation_view_model.dart';
import 'widgets/confirmation_content.dart';

class ConfirmationScreen extends StatelessWidget {
  final VoidCallback onFinish;
  final ConfirmationType type;
  final Subscription? subscription; 
  final String? bikeName; 
  final String? stationName; 

  const ConfirmationScreen({
    super.key,
    required this.onFinish,
    required this.type,
    this.subscription,
    this.bikeName,
    this.stationName,
  });

  @override
  Widget build(BuildContext context) {
    return Provider<ConfirmationViewModel>(
      create: (context) => ConfirmationViewModel(
        onFinish: onFinish,
        type: type,
        subscription: subscription,
        bikeName: bikeName,
        stationName: stationName,
      ),
      child: const ConfirmationContent(),
    );
  }
}
