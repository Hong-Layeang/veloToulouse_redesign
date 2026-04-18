import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view_model/confirmation_view_model.dart';
import 'widgets/confirmation_content.dart';

class ConfirmationScreen extends StatelessWidget {
  final VoidCallback onFinish;

  const ConfirmationScreen({
    super.key,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    return Provider<ConfirmationViewModel>(
      create: (context) => ConfirmationViewModel(
        onFinish: onFinish,
      ),
      child: const ConfirmationContent(),
    );
  }
}
