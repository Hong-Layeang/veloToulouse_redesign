import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velo_toulouse/ui/screens/subscription/view_model/subscriptions_view_model.dart';
import 'package:velo_toulouse/ui/screens/payment_method/payment_method_screen.dart';
import 'package:velo_toulouse/ui/theme/app_theme.dart';

class SubscriptionsContent extends StatelessWidget {
  const SubscriptionsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final subscriptionsViewModel = context.watch<SubscriptionsViewModel>();

    return _buildBody(context, subscriptionsViewModel);
  }

  Widget _buildBody(BuildContext context, SubscriptionsViewModel viewModel) {
    switch (viewModel.status) {
      case SubscriptionsStatus.loading:
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      case SubscriptionsStatus.error:
        return Scaffold(
          body: Center(
            child: Text(viewModel.errorMessage ?? 'An error occurred'),
          ),
        );
      case SubscriptionsStatus.success:
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
                    const _SubscriptionSummaryCard(
                      activePlanId: '',
                      activeLabel: 'No active pass',
                    ),
                    const SizedBox(height: 18),
                    ...(viewModel.plans.map(
                      (plan) => _PlanCard(
                        plan: plan,
                        isActive: false,
                        onSelect: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => PaymentMethodScreen(plan: plan),
                            ),
                          );
                        },
                      ),
                    ).toList()),
                  ]),
                ),
              ),
            ],
          ),
        );
    }
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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Active Pass',
            style: TextStyle(
              color: AppTheme.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            activeLabel,
            style: TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (hasActivePlan) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
              decoration: BoxDecoration(
                color: AppTheme.green.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Active',
                style: TextStyle(
                  color: AppTheme.green,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final dynamic plan;
  final bool isActive;
  final VoidCallback onSelect;

  const _PlanCard({
    required this.plan,
    required this.isActive,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: isActive ? AppTheme.primary : AppTheme.divider,
          width: isActive ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plan.label,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      plan.description,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppTheme.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${plan.price}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.primary,
                    ),
                  ),
                  const Text(
                    'per period',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              onPressed: onSelect,
              style: ElevatedButton.styleFrom(
                backgroundColor: isActive ? AppTheme.primary.withValues(alpha: 0.1) : AppTheme.primary,
                foregroundColor: isActive ? AppTheme.primary : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                isActive ? 'Active' : 'Select',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

