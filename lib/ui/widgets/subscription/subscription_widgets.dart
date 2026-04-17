import 'package:flutter/material.dart';
import 'package:velo_toulouse/model/subscription.dart';
import 'package:velo_toulouse/ui/theme/app_theme.dart';

/// Subscription-specific widget showing subscription details in a card
class SubscriptionInfoCard extends StatelessWidget {
  final Subscription subscription;
  final bool isActive;
  final VoidCallback? onTap;

  const SubscriptionInfoCard({
    super.key,
    required this.subscription,
    this.isActive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive ? AppTheme.primary : AppTheme.divider,
            width: isActive ? 2 : 1,
          ),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: AppTheme.primary.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    subscription.label,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ),
                if (isActive)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.green.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'Active',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.green,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              subscription.description,
              style: const TextStyle(
                fontSize: 13,
                color: AppTheme.textSecondary,
                height: 1.4,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${subscription.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primary,
                  ),
                ),
                Text(
                  _getPeriodLabel(subscription.duration),
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getPeriodLabel(Duration duration) {
    if (duration.inDays >= 365) {
      return 'per year';
    } else if (duration.inDays >= 30) {
      return 'per month';
    } else if (duration.inDays >= 7) {
      return 'per week';
    } else {
      return 'per day';
    }
  }
}

/// Subscription benefit list widget
class SubscriptionBenefits extends StatelessWidget {
  final Subscription subscription;

  const SubscriptionBenefits({
    super.key,
    required this.subscription,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _BenefitRow(
          icon: Icons.schedule,
          label: 'Valid Period',
          value: _formatDuration(subscription.duration),
        ),
        const SizedBox(height: 12),
        _BenefitRow(
          icon: Icons.timer,
          label: 'Per Ride Limit',
          value: _formatDuration(subscription.rideDuration),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    if (duration.inDays >= 365) {
      final years = duration.inDays ~/ 365;
      return '$years year${years > 1 ? 's' : ''}';
    } else if (duration.inDays >= 30) {
      final months = duration.inDays ~/ 30;
      return '$months month${months > 1 ? 's' : ''}';
    } else if (duration.inDays >= 1) {
      return '${duration.inDays} day${duration.inDays > 1 ? 's' : ''}';
    } else {
      final hours = duration.inHours;
      return '$hours hour${hours > 1 ? 's' : ''}';
    }
  }
}

class _BenefitRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _BenefitRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppTheme.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppTheme.textSecondary,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }
}
