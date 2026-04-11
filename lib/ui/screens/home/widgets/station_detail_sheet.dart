import 'package:flutter/material.dart';
import '../../../../models/bike.dart';
import '../../../../models/station.dart';
import '../../../theme/app_theme.dart';
import 'bike_tile.dart';
import 'swipe_to_unlock.dart';

class StationDetailSheet extends StatefulWidget {
  final Station station;
  final VoidCallback onClose;
  const StationDetailSheet({super.key, required this.station, required this.onClose});

  @override
  State<StationDetailSheet> createState() => _StationDetailSheetState();
}

class _StationDetailSheetState extends State<StationDetailSheet> {
  Bike? _selectedBike;

  @override
  Widget build(BuildContext context) {
    final station = widget.station;
    final bikes = station.bikes;

    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.35,
      maxChildSize: 0.92,
      snap: true,
      snapSizes: const [0.35, 0.5, 0.92],
      builder: (context, scrollController) {
        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, -2)),
            ],
          ),
          child: Column(
            children: [
              _buildHeader(station),
              const Divider(height: 1),
              Expanded(
                child: CustomScrollView(
                  controller: scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
                        child: Text(
                          _selectedBike != null ? 'SELECT A BIKE' : 'AVAILABLE BIKES',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8,
                            color: AppTheme.textSecondary.withValues(alpha: 0.8),
                          ),
                        ),
                      ),
                    ),
                    if (bikes.isNotEmpty)
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final bike = bikes[index];
                            return Column(
                              children: [
                                BikeTile(
                                  bike: bike,
                                  isSelected: _selectedBike?.id == bike.id,
                                  onTap: () {
                                    setState(() {
                                      _selectedBike = _selectedBike?.id == bike.id ? null : bike;
                                    });
                                  },
                                ),
                                if (index < bikes.length - 1)
                                  const Divider(height: 1, indent: 74),
                              ],
                            );
                          },
                          childCount: bikes.length,
                        ),
                      ),
                    if (bikes.isEmpty)
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.all(40),
                          child: Column(
                            children: [
                              Icon(Icons.pedal_bike, size: 48, color: AppTheme.divider),
                              SizedBox(height: 12),
                              Text('No bikes available', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppTheme.textSecondary)),
                              SizedBox(height: 4),
                              Text('Check back soon or try a nearby station', style: TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
                            ],
                          ),
                        ),
                      ),
                    const SliverToBoxAdapter(child: SizedBox(height: 100)),
                  ],
                ),
              ),
              if (_selectedBike != null)
                SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                    child: SwipeToRent(key: ValueKey(_selectedBike!.id), bike: _selectedBike!),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(Station station) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10, bottom: 4),
          width: 36,
          height: 4,
          decoration: BoxDecoration(color: AppTheme.divider, borderRadius: BorderRadius.circular(2)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              GestureDetector(
                onTap: widget.onClose,
                child: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  station.name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppTheme.textPrimary),
                ),
              ),
              IconButton(icon: const Icon(Icons.favorite_border, color: AppTheme.textPrimary), onPressed: () {}),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
          child: Row(
            children: [
              _statChip(Icons.pedal_bike, '${station.availableBikes} bikes', station.availableBikes > 0 ? AppTheme.green : AppTheme.red),
              const SizedBox(width: 12),
              _statChip(Icons.local_parking, '${station.availableDocks} docks', station.availableDocks > 0 ? AppTheme.primary : AppTheme.red),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: color)),
        ],
      ),
    );
  }
}
