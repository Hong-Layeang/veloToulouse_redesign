import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velo_toulouse/model/station.dart';
import 'package:velo_toulouse/ui/theme/app_theme.dart';
import 'package:velo_toulouse/ui/states/ride_state.dart';
import '../../booking/bike_booking_screen.dart';
import '../view_model/station_detail_view_model.dart';

class StationDetailContent extends StatelessWidget {
  const StationDetailContent({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<StationDetailViewModel>();
    final rideState = context.watch<RideState>();
    final width = MediaQuery.sizeOf(context).width;
    final crossAxisCount = _getGridCrossAxisCount(width);

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: false,
            elevation: 0,
            backgroundColor: AppTheme.background,
            surfaceTintColor: Colors.transparent,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 20,
                color: AppTheme.textPrimary,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              viewModel.station.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppTheme.textPrimary,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            titleSpacing: 0,
            centerTitle: false,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1),
              child: Container(
                height: 1,
                color: AppTheme.divider,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: AppTheme.background,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        'STATION ID: ${viewModel.station.id.toUpperCase()}',
                        style: const TextStyle(
                          color: AppTheme.primaryDark,
                          fontWeight: FontWeight.w700,
                          fontSize: 11.5,
                          letterSpacing: 0.9,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _MainStatCard(
                          title: 'Available',
                          value: '${viewModel.availableBikesCount}',
                          icon: Icons.pedal_bike,
                          color: AppTheme.primary,
                        ),
                        const SizedBox(width: 12),
                        _MainStatCard(
                          title: 'Total Slots',
                          value: '${viewModel.station.totalSlots}',
                          icon: Icons.grid_view_rounded,
                          color: AppTheme.textPrimary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: const [
                        Text(
                          'Bike Slots',
                          style: TextStyle(
                            color: AppTheme.textPrimary,
                            fontSize: 19,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Spacer(),
                        _LegendChip(
                          icon: Icons.pedal_bike,
                          color: AppTheme.primary,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    if (viewModel.availableSlots.isEmpty)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 18,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.surface,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppTheme.divider),
                        ),
                        child: const Text(
                          'No bikes are available at this station right now.',
                          style: TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    else
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: viewModel.availableSlots.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: 1.02,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                        itemBuilder: (context, index) => _ModernSlotCard(
                          slot: viewModel.availableSlots[index],
                          onTap: () {
                            if (rideState.hasActiveRide) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(rideState.activeRideMessage),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              return;
                            }

                            _showBookingConfirmationSheet(
                              context,
                              viewModel.availableSlots[index],
                              viewModel.station,
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showBookingConfirmationSheet(
    BuildContext context,
    SlotView slot,
    Station station,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 18),
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.surface,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F8FA),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.pedal_bike,
                        size: 40,
                        color: Color(0xFF0D5264),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Selected',
                            style: TextStyle(
                              color: Color(0xFF9AA6AF),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '${slot.code} ${slot.bikeName ?? ''}'.trim(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Color(0xFF0D5264),
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Available',
                            style: TextStyle(
                              color: Color(0xFFFC5C4A),
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(sheetContext);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => BikeBookingScreen(
                                station: station,
                                slotCode: slot.code,
                                bikeName: slot.bikeName,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF5C4B),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                        ),
                        child: const Text(
                          'Ride',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

int _getGridCrossAxisCount(double width) {
  if (width >= 560) return 4;
  if (width >= 390) return 3;
  return 2;
}

class _ModernSlotCard extends StatelessWidget {
  final SlotView slot;
  final VoidCallback onTap;

  const _ModernSlotCard({
    required this.slot,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.primary.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppTheme.primary.withValues(alpha: 0.38),
              width: 1.25,
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primary.withValues(alpha: 0.06),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  slot.code,
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                const Spacer(),
                Center(
                  child: Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.pedal_bike,
                      color: AppTheme.primary,
                      size: 32,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MainStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _MainStatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isAvailableCard = title == 'Available';

    return Expanded(
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
        decoration: BoxDecoration(
          color: isAvailableCard
              ? AppTheme.primary.withValues(alpha: 0.06)
              : AppTheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isAvailableCard
                ? AppTheme.primary.withValues(alpha: 0.24)
                : AppTheme.divider.withValues(alpha: 0.7),
            width: isAvailableCard ? 1.3 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: isAvailableCard
                    ? AppTheme.primary.withValues(alpha: 0.16)
                    : color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Icon(icon, color: color, size: 16),
            ),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: AppTheme.primary,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LegendChip extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _LegendChip({
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: AppTheme.surface,
        border: Border.all(color: AppTheme.divider),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Center(
        child: Icon(icon, size: 16, color: color),
      ),
    );
  }
}
