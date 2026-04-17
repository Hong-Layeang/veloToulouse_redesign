import 'package:flutter/material.dart';
import 'package:velo_toulouse/ui/theme/app_theme.dart';

/// Ride-specific widget showing active ride timer
/// Used during an active bike ride session
class RideTimerDisplay extends StatelessWidget {
  final Duration elapsed;
  final Duration remaining;
  final bool isActive;

  const RideTimerDisplay({
    super.key,
    required this.elapsed,
    required this.remaining,
    this.isActive = true,
  });

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isActive ? AppTheme.primary : AppTheme.divider,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Elapsed',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatDuration(elapsed),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.primary,
                    ),
                  ),
                ],
              ),
              Container(
                width: 1,
                height: 40,
                color: AppTheme.divider,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Remaining',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppTheme.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatDuration(remaining),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: remaining.inSeconds < 300
                          ? Colors.orange
                          : AppTheme.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Ride-specific widget showing station availability status
class StationAvailabilityBadge extends StatelessWidget {
  final int availableSlots;
  final int totalSlots;
  final bool showBikeCount;

  const StationAvailabilityBadge({
    super.key,
    required this.availableSlots,
    required this.totalSlots,
    this.showBikeCount = true,
  });

  Color _getStatusColor() {
    final percentage = (availableSlots / totalSlots) * 100;
    if (percentage > 50) return AppTheme.green;
    if (percentage > 20) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: _getStatusColor().withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _getStatusColor(),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.two_wheeler,
            size: 16,
            color: _getStatusColor(),
          ),
          const SizedBox(width: 6),
          Text(
            '$availableSlots',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: _getStatusColor(),
            ),
          ),
          Text(
            '/$totalSlots',
            style: TextStyle(
              fontSize: 12,
              color: _getStatusColor().withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}
