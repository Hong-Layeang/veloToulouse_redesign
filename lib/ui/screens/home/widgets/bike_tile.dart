import 'package:flutter/material.dart';
import '../../../../models/bike.dart';
import '../../../theme/app_theme.dart';

class BikeTile extends StatelessWidget {
  final Bike bike;
  final bool isSelected;
  final VoidCallback? onTap;
  const BikeTile({super.key, required this.bike, this.isSelected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    final canSelect = bike.isAvailable;

    return GestureDetector(
      onTap: canSelect ? onTap : null,
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
          opacity: canSelect ? 1.0 : 0.5,
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
                  bike.type == BikeType.electric
                      ? Icons.electric_bike
                      : Icons.pedal_bike,
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
                      bike.type == BikeType.electric ? 'Electric' : 'Mechanical',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              // Battery
              if (bike.batteryPercent != null) ...[
                Text(
                  '${bike.batteryPercent}%',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _batteryColor(bike.batteryPercent!),
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  _batteryIcon(bike.batteryPercent!),
                  size: 18,
                  color: _batteryColor(bike.batteryPercent!),
                ),
                const SizedBox(width: 12),
              ],
              // Condition badge
              _buildConditionBadge(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConditionBadge() {
    final (String label, Color color, IconData icon) = switch (bike.condition) {
      BikeCondition.good => ('Good', AppTheme.green, Icons.check_circle_outline),
      BikeCondition.charging => ('Charging', AppTheme.amber, Icons.bolt),
      BikeCondition.maintenance => ('Repair', AppTheme.red, Icons.build_outlined),
    };

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

  Color _batteryColor(int percent) {
    if (percent >= 50) return AppTheme.green;
    if (percent >= 20) return AppTheme.amber;
    return AppTheme.red;
  }

  IconData _batteryIcon(int percent) {
    if (percent >= 80) return Icons.battery_full;
    if (percent >= 50) return Icons.battery_5_bar;
    if (percent >= 20) return Icons.battery_3_bar;
    return Icons.battery_1_bar;
  }
}
