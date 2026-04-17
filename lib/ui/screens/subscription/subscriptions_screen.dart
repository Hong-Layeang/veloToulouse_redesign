import 'package:flutter/material.dart';

import 'package:velo_toulouse/models/subscription/subscription.dart';
import '../../states/subscription_state.dart';
import '../../theme/app_theme.dart';
import 'payment_method_screen.dart';

final List<Subscription> availablePlans = <Subscription>[
  Subscription(
    id: 'day_pass',
    label: 'Day Pass',
    description: 'Unlimited 30 minutes rides\nValid for 24 hours',
    price: 3,
    duration: const Duration(days: 1),
    rideDuration: const Duration(minutes: 30),
  ),
  Subscription(
    id: 'monthly_pass',
    label: 'Monthly Pass - Best Deal',
    description: 'Unlimited 45 minutes rides\nValid for 1 month',
    price: 25,
    duration: const Duration(days: 30),
    rideDuration: const Duration(minutes: 45),
  ),
  Subscription(
    id: 'annual_pass',
    label: 'Annual Pass',
    description: 'Unlimited 45 minutes rides\nValid for 1 year',
    price: 50,
    duration: const Duration(days: 365),
    rideDuration: const Duration(minutes: 45),
  ),
];

class SubscriptionsScreen extends StatelessWidget {
  final SubscriptionState subscriptionState;
  final VoidCallback? onSubscribed;

  const SubscriptionsScreen({
    super.key,
    required this.subscriptionState,
    this.onSubscribed,
  });

  @override
  Widget build(BuildContext context) {
    final activePlanId = subscriptionState.activeSubscription?.plan.id;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 210,
            backgroundColor: AppTheme.primary,
            foregroundColor: Colors.white,
            title: const Text(
              'Subscriptions',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppTheme.primary, AppTheme.primaryDark],
                  ),
                ),
                child: const SafeArea(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 24, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Spacer(),
                        Text(
                          'Choose the pass that fits your ride pattern.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            height: 1.1,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'All plans are based on the mock subscription data already used by the app.',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
                _SubscriptionSummaryCard(
                  activePlanId: activePlanId ?? '',
                  activeLabel: subscriptionState.hasActiveSubscription
                      ? subscriptionState.activeSubscription!.plan.label
                      : 'No active pass',
                ),
                const SizedBox(height: 18),
                ...availablePlans.map(
                  (plan) => _PlanCard(
                    plan: plan,
                    isActive: activePlanId == plan.id,
                    onSelect: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => PaymentMethodScreen(
                            plan: plan,
                            subscriptionState: subscriptionState,
                            onSubscribed: onSubscribed,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _SubscriptionSummaryCard extends StatelessWidget {
  final String activePlanId;
  final String activeLabel;

  const _SubscriptionSummaryCard({
    required this.activePlanId,
    required this.activeLabel,
  });

  @override
  Widget build(BuildContext context) {
    final hasActivePlan = activePlanId.isNotEmpty;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppTheme.divider),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: hasActivePlan
                  ? AppTheme.primary.withValues(alpha: 0.12)
                  : const Color(0xFFF3F3F3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              hasActivePlan ? Icons.verified : Icons.card_membership_outlined,
              color: hasActivePlan ? AppTheme.primary : AppTheme.textSecondary,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hasActivePlan ? 'Active pass' : 'No pass selected yet',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  hasActivePlan
                      ? 'Current plan: $activeLabel'
                      : 'Pick a pass below to unlock payment options and continue.',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final Subscription plan;
  final bool isActive;
  final VoidCallback onSelect;

  const _PlanCard({
    required this.plan,
    required this.isActive,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final priceText = '€${plan.price.toStringAsFixed(2)}';
    final recurringText = _formatRecurring(plan.duration);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: isActive
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFFF3E8), Colors.white],
              )
            : null,
        color: isActive ? null : Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: isActive ? AppTheme.primary : AppTheme.divider,
          width: isActive ? 1.6 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              plan.label,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: AppTheme.textPrimary,
                              ),
                            ),
                          ),
                          if (plan.id == 'monthly') ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.primary.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: const Text(
                                'Popular',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: AppTheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        plan.description,
                        style: const TextStyle(
                          fontSize: 13,
                          height: 1.45,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isActive)
                  Container(
                    margin: const EdgeInsets.only(left: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.green.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Text(
                      'Active',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.green,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  priceText,
                  style: const TextStyle(
                    fontSize: 30,
                    height: 1,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.primary,
                  ),
                ),
                if (recurringText.isNotEmpty) ...[
                  const SizedBox(width: 4),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      recurringText,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppTheme.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
                const Spacer(),
                _InfoChip(
                  icon: Icons.schedule,
                  label: _formatDuration(plan.duration),
                ),
                const SizedBox(width: 8),
                _InfoChip(
                  icon: Icons.directions_bike,
                  label: 'Ride ${_formatRideDuration(plan.rideDuration)}',
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: plan.description
                  .split('\n')
                  .where((line) => line.trim().isNotEmpty)
                  .map(
                    (feature) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F8F8),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        feature,
                        style: const TextStyle(
                          fontSize: 12.5,
                          height: 1.3,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: onSelect,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isActive
                      ? AppTheme.primaryDark
                      : AppTheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                child: Text(isActive ? 'Change plan' : 'Select plan'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    if (duration.inDays >= 365) {
      return '1 year';
    }
    if (duration.inDays >= 30) {
      return duration.inDays ~/ 30 == 1
          ? '1 month'
          : '${duration.inDays ~/ 30} months';
    }
    if (duration.inDays >= 1) {
      return duration.inDays == 1 ? '24h' : '${duration.inDays} days';
    }
    return '${duration.inHours}h';
  }

  String _formatRecurring(Duration duration) {
    if (duration.inDays >= 365) {
      return '/year';
    }
    if (duration.inDays >= 30) {
      return '/month';
    }
    if (duration.inDays >= 1) {
      return '/day';
    }
    return '';
  }

  String _formatRideDuration(Duration duration) {
    if (duration.inMinutes % 60 == 0) {
      final hours = duration.inHours;
      return hours == 1 ? '1 hour' : '$hours hours';
    }
    final minutes = duration.inMinutes;
    return minutes == 1 ? '1 min' : '$minutes mins';
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: AppTheme.textSecondary),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
