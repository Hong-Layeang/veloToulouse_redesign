import 'package:flutter/material.dart';
import '../../../../models/bike/bike.dart';
import '../../../theme/app_theme.dart';

class BikeTile extends StatelessWidget {
  final Bike bike;
  final bool isSelected;
  final VoidCallback? onTap;
  const BikeTile({super.key, required this.bike, this.isSelected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primary.withValues(alpha: 0.08)
              : Colors.transparent,
          border: isSelected
              ? Border(left: BorderSide(color: AppTheme.primary, width: 3))
              : null,
        ),
        child: Opacity(
          opacity: 1.0,
          child: Row(
            children: [
              // Bike icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.primary.withValues(alpha: 0.15)
                      : AppTheme.background,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.pedal_bike,
                  color: isSelected ? AppTheme.primary : AppTheme.textSecondary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              // Name
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bike.name,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Bike',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              _buildSimpleBadge(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSimpleBadge() {
    const label = 'Ready';
    const color = AppTheme.green;
    const icon = Icons.check_circle_outline;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: color),
        ),
      ],
    );
  }
}
