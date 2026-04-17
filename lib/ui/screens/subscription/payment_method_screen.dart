import 'package:flutter/material.dart';
import 'package:velo_toulouse/models/subscription.dart';
import '../../theme/app_theme.dart';
import '../../states/subscription_state.dart';
import 'confirmation_screen.dart';

enum PaymentMethod { applePay, googlePay, creditCard }

class PaymentMethodScreen extends StatefulWidget {
  final Subscription plan;
  final SubscriptionState subscriptionState;
  final VoidCallback? onSubscribed;

  const PaymentMethodScreen({
    super.key,
    required this.plan,
    required this.subscriptionState,
    this.onSubscribed,
  });

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  PaymentMethod? _selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Method'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const Divider(height: 1),
            const SizedBox(height: 32),
            _PaymentOption(
              icon: Icons.apple,
              label: 'Apple Pay',
              selected: _selected == PaymentMethod.applePay,
              onTap: () => setState(() => _selected = PaymentMethod.applePay),
            ),
            const SizedBox(height: 16),
            _PaymentOption(
              iconWidget: Text(
                'G',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.red.shade400,
                ),
              ),
              label: 'Google Pay',
              selected: _selected == PaymentMethod.googlePay,
              onTap: () => setState(() => _selected = PaymentMethod.googlePay),
            ),
            const SizedBox(height: 16),
            _PaymentOption(
              iconWidget: Container(
                width: 32,
                height: 22,
                decoration: BoxDecoration(
                  color: Colors.red.shade400,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.more_horiz, color: Colors.white, size: 16),
                  ],
                ),
              ),
              label: 'Credit Card',
              selected: _selected == PaymentMethod.creditCard,
              onTap: () => setState(() => _selected = PaymentMethod.creditCard),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _selected != null
                      ? () {
                          widget.subscriptionState.subscribe(widget.plan);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => ConfirmationScreen(
                                plan: widget.plan,
                                onFinish: () {
                                  widget.onSubscribed?.call();
                                  Navigator.of(context).popUntil(
                                    (route) => route.isFirst,
                                  );
                                },
                              ),
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: AppTheme.primary.withValues(alpha: 0.4),
                    disabledForegroundColor: Colors.white70,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: const Text('Next'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentOption extends StatelessWidget {
  final IconData? icon;
  final Widget? iconWidget;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _PaymentOption({
    this.icon,
    this.iconWidget,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 64,
        decoration: BoxDecoration(
          color: selected
              ? AppTheme.primary.withValues(alpha: 0.08)
              : const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? AppTheme.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            const SizedBox(width: 20),
            if (iconWidget != null)
              iconWidget!
            else if (icon != null)
              Icon(icon, size: 28, color: AppTheme.textPrimary),
            const SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: selected ? AppTheme.primary : AppTheme.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
