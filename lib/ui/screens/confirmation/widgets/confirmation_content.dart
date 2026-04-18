import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velo_toulouse/ui/theme/app_theme.dart';
import 'package:velo_toulouse/model/confirmation_type.dart';
import '../view_model/confirmation_view_model.dart';

class ConfirmationContent extends StatelessWidget {
  const ConfirmationContent({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ConfirmationViewModel>();

    if (viewModel.type == ConfirmationType.subscription) {
      return _buildSubscriptionConfirmation(context, viewModel);
    } else {
      return _buildBikeRentalConfirmation(context, viewModel);
    }
  }

  Widget _buildSubscriptionConfirmation(BuildContext context, ConfirmationViewModel viewModel) {
    final subscription = viewModel.subscription;
    if (subscription == null) {
      return const Scaffold(
        body: Center(child: Text('No subscription found')),
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const Divider(height: 1),
            const Spacer(flex: 3),
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: AppTheme.green.withValues(alpha: 0.18),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                color: AppTheme.green,
                size: 56,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Subscription Confirmed',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${subscription.label} is now active.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: AppTheme.textSecondary,
              ),
            ),
            const Spacer(flex: 4),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => viewModel.finish(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: const Text('Continue'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBikeRentalConfirmation(BuildContext context, ConfirmationViewModel viewModel) {
    final bikeName = viewModel.bikeName ?? 'Bike';
    final stationName = viewModel.stationName ?? 'Station';

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const Divider(height: 1),
            const Spacer(flex: 3),
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: AppTheme.primary.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.two_wheeler,
                color: AppTheme.primary,
                size: 56,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Bike Unlocked',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$bikeName at $stationName is ready.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: AppTheme.textSecondary,
              ),
            ),
            const Spacer(flex: 4),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => viewModel.finish(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: const Text('Start Ride'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
