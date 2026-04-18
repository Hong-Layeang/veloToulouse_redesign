import 'package:flutter/material.dart';
import 'package:velo_toulouse/model/confirmation_type.dart';
import 'package:velo_toulouse/model/subscription.dart';
import 'package:velo_toulouse/ui/theme/app_theme.dart';

class ConfirmationContent extends StatelessWidget {
  final VoidCallback onFinish;
  final ConfirmationType type;
  final Subscription? subscription;
  final String? bikeName;
  final String? stationName;

  const ConfirmationContent({
    super.key,
    required this.onFinish,
    required this.type,
    this.subscription,
    this.bikeName,
    this.stationName,
  });

  @override
  Widget build(BuildContext context) {
    if (type == ConfirmationType.subscription) {
      return _buildSubscriptionConfirmation();
    }
    return _buildBikeRentalConfirmation();
  }

  Widget _buildSubscriptionConfirmation() {
    final activeSubscription = subscription;
    if (activeSubscription == null) {
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
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${activeSubscription.label} is now active.',
              textAlign: TextAlign.center,
              style: const TextStyle(
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
                  onPressed: onFinish,
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

  Widget _buildBikeRentalConfirmation() {
    final resolvedBikeName = bikeName ?? 'Bike';
    final resolvedStationName = stationName ?? 'Station';

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
              '$resolvedBikeName at $resolvedStationName is ready.',
              textAlign: TextAlign.center,
              style: const TextStyle(
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
                  onPressed: onFinish,
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
