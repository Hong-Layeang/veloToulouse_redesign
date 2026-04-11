import 'package:flutter/material.dart';
import '../../../../data/mock/mock_stations.dart';
import '../../../../models/station.dart';
import '../../../theme/app_theme.dart';
import '../../../states/subscription_state.dart';
import 'station_detail_sheet.dart';

class MapView extends StatefulWidget {
  final SubscriptionState subscriptionState;
  const MapView({super.key, required this.subscriptionState});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> with SingleTickerProviderStateMixin {
  Station? _selectedStation;
  int _selectedFilter = 0;

  late final AnimationController _sheetAnimController;
  late final Animation<double> _sheetSlideAnim;
  late final Animation<double> _scrimAnim;

  @override
  void initState() {
    super.initState();
    _sheetAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _sheetSlideAnim = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _sheetAnimController, curve: Curves.easeOutCubic),
    );
    _scrimAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _sheetAnimController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _sheetAnimController.dispose();
    super.dispose();
  }

  void _openStation(Station station) {
    setState(() => _selectedStation = station);
    _sheetAnimController.forward(from: 0);
  }

  void _closeStation() async {
    await _sheetAnimController.reverse();
    if (mounted) setState(() => _selectedStation = null);
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;

    return Stack(
      children: [
        // Map background
        Positioned.fill(
          child: Image.asset(
            'assets/images/map.png',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: const Color(0xFFE8E0D8)),
          ),
        ),
        // Station markers
        ..._buildMarkers(context),
        // User location dot
        Positioned(
          left: MediaQuery.of(context).size.width * 0.48,
          top: MediaQuery.of(context).size.height * 0.45,
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [
                BoxShadow(color: Colors.blue.withValues(alpha: 0.3), blurRadius: 8, spreadRadius: 2),
              ],
            ),
          ),
        ),
        // Search bar
        Positioned(
          top: padding.top + 8,
          left: 16,
          right: 16,
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.08), blurRadius: 8, offset: const Offset(0, 2)),
              ],
            ),
            child: Row(
              children: [
                const SizedBox(width: 16),
                Icon(Icons.search, color: AppTheme.textSecondary.withValues(alpha: 0.6)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Search stations...',
                    style: TextStyle(fontSize: 15, color: AppTheme.textSecondary.withValues(alpha: 0.6)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 6),
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(color: AppTheme.background, shape: BoxShape.circle),
                  child: const Icon(Icons.more_vert, size: 20, color: AppTheme.textSecondary),
                ),
              ],
            ),
          ),
        ),
        // Filter chips
        Positioned(
          top: padding.top + 64,
          left: 0,
          right: 0,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _filterChip(0, Icons.grid_view_rounded, 'All'),
                _filterChip(1, Icons.electric_bike, 'Electric'),
                _filterChip(2, Icons.pedal_bike, 'Mechanical'),
                _filterChip(3, Icons.local_parking, 'Parking'),
              ],
            ),
          ),
        ),
        // Right side controls
        Positioned(
          bottom: _selectedStation != null ? 320 : 110,
          right: 16,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _circleButton(Icons.my_location),
              const SizedBox(height: 12),
              _circleButton(Icons.refresh),
            ],
          ),
        ),
        // Left filter control
        Positioned(
          bottom: _selectedStation != null ? 320 : 110,
          left: 16,
          child: _circleButton(Icons.tune),
        ),
        // Book button (original circular design)
        if (_selectedStation == null)
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Station? best;
                  int maxBikes = 0;
                  for (final s in mockStations) {
                    if (s.availableBikes > maxBikes) {
                      maxBikes = s.availableBikes;
                      best = s;
                    }
                  }
                  if (best != null) _openStation(best);
                },
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: AppTheme.primary.withValues(alpha: 0.4), blurRadius: 16, offset: const Offset(0, 4)),
                    ],
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.electric_bike, color: Colors.white, size: 30),
                      SizedBox(height: 2),
                      Text('Book', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        // Scrim (tap to close)
        if (_selectedStation != null)
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _scrimAnim,
              builder: (context, child) => GestureDetector(
                onTap: _closeStation,
                child: Container(
                  color: Colors.black.withValues(alpha: _scrimAnim.value * 0.3),
                ),
              ),
            ),
          ),
        // Station detail sheet (animated)
        if (_selectedStation != null)
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _sheetSlideAnim,
              builder: (context, child) => FractionalTranslation(
                translation: Offset(0, _sheetSlideAnim.value),
                child: child,
              ),
              child: StationDetailSheet(
                station: _selectedStation!,
                onClose: _closeStation,
                subscriptionState: widget.subscriptionState,
              ),
            ),
          ),
      ],
    );
  }

  // -- Markers --

  List<Widget> _buildMarkers(BuildContext context) {
    final size = MediaQuery.of(context).size;
    const positions = [
      (0.08, 0.20), (0.42, 0.15), (0.12, 0.38), (0.32, 0.30),
      (0.68, 0.24), (0.78, 0.40), (0.48, 0.52), (0.22, 0.62),
      (0.62, 0.67), (0.38, 0.78),
    ];

    return List.generate(mockStations.length, (i) {
      final station = mockStations[i];
      final (x, y) = positions[i % positions.length];
      final count = station.availableBikes;
      final selected = _selectedStation?.id == station.id;

      return Positioned(
        left: size.width * x - 20,
        top: size.height * y - 20,
        child: GestureDetector(
          onTap: () => _openStation(station),
          child: Container(
            width: selected ? 46 : 40,
            height: selected ? 46 : 40,
            decoration: BoxDecoration(
              color: count == 0
                  ? Colors.grey
                  : count <= 3
                      ? AppTheme.red
                      : count <= 6
                          ? AppTheme.primary
                          : AppTheme.green,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: selected ? 3 : 2),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 4, offset: const Offset(0, 2)),
              ],
            ),
            child: Center(
              child: Text('$count', style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      );
    });
  }

  // Small helpers

  Widget _filterChip(int index, IconData icon, String label) {
    final isActive = _selectedFilter == index;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => setState(() => _selectedFilter = index),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? AppTheme.primary : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 4, offset: const Offset(0, 1)),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: isActive ? Colors.white : AppTheme.textSecondary),
              const SizedBox(width: 6),
              Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: isActive ? Colors.white : AppTheme.textSecondary)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _circleButton(IconData icon) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 6, offset: const Offset(0, 2)),
          ],
        ),
        child: Icon(icon, color: AppTheme.textPrimary, size: 22),
      ),
    );
  }
}
