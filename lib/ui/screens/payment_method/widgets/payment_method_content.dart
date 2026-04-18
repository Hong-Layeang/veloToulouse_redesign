import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velo_toulouse/model/payment_method.dart';
import 'package:velo_toulouse/ui/screens/payment_method/view_model/payment_method_view_model.dart';
import 'package:velo_toulouse/ui/screens/confirmation/confirmation_screen.dart';
import 'package:velo_toulouse/ui/theme/app_theme.dart';

class PaymentMethodContent extends StatelessWidget {
  const PaymentMethodContent({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PaymentMethodViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Method'),
      ),
      body: _buildBody(context, viewModel),
    );
  }

  Widget _buildBody(BuildContext context, PaymentMethodViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const Divider(height: 1),
          const SizedBox(height: 32),
          _PaymentOption(
            icon: Icons.apple,
            label: 'Apple Pay',
            selected: viewModel.selectedPaymentMethod == PaymentMethod.applePay,
            onTap: () => viewModel.selectPaymentMethod(PaymentMethod.applePay),
          ),
          const SizedBox(height: 16),
          _PaymentOption(
            iconWidget: const Text(
              'G',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            label: 'Google Pay',
            selected: viewModel.selectedPaymentMethod == PaymentMethod.googlePay,
            onTap: () => viewModel.selectPaymentMethod(PaymentMethod.googlePay),
          ),
          const SizedBox(height: 16),
          _PaymentOption(
            icon: Icons.credit_card,
            label: 'Credit Card',
            selected: viewModel.selectedPaymentMethod == PaymentMethod.creditCard,
            onTap: () => viewModel.selectPaymentMethod(PaymentMethod.creditCard),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: viewModel.status == PaymentStatus.processing
                  ? null
                  : () async {
                      await viewModel.processPayment();
                      if (viewModel.status == PaymentStatus.success && context.mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ConfirmationScreen(
                              onFinish: () => Navigator.popUntil(context, (route) => route.isFirst),
                            ),
                          ),
                        );
                      }
                    },
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
              child: viewModel.status == PaymentStatus.processing
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text('Continue'),
            ),
          ),
          const SizedBox(height: 24),
        ],
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
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? AppTheme.primary : AppTheme.divider,
            width: selected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: selected ? AppTheme.primary.withValues(alpha: 0.1) : Colors.transparent,
        ),
        child: Row(
          children: [
            if (icon != null)
              Icon(
                icon,
                size: 28,
                color: selected ? AppTheme.primary : AppTheme.textSecondary,
              )
            else
              iconWidget ?? const SizedBox.shrink(),
            const SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: selected ? AppTheme.primary : AppTheme.textPrimary,
              ),
            ),
            const Spacer(),
            if (selected)
              const Icon(
                Icons.check_circle,
                color: AppTheme.primary,
              )
            else
              Icon(
                Icons.circle_outlined,
                color: AppTheme.divider,
              ),
          ],
        ),
      ),
    );
  }
}
