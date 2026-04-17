import 'package:flutter/material.dart';

import '../../../models/station.dart';
import '../../theme/app_theme.dart';

class BikeBookingScreen extends StatelessWidget {
  final Station station;
  final String slotCode;
  final String? bikeName;
  final String? bikeImage;
  final String? bikeColor;

  const BikeBookingScreen({
    super.key,
    required this.station,
    required this.slotCode,
    this.bikeName,
    this.bikeImage,
    this.bikeColor,
  });

  String? _extractBikeColor(String? name) {
    final normalized = name?.toLowerCase();
    if (normalized == null || normalized.isEmpty) return null;

    const supportedColors = ['black', 'blue', 'green', 'red', 'yellow'];
    for (final color in supportedColors) {
      if (normalized.contains(color)) return color;
    }
    return null;
  }

  /// Get asset image path based on bike color
  String _getColorImagePath(String? color) {
    if (color == null) return 'assets/images/velu_black_bike.jpg';
    
    final colorLower = color.toLowerCase().trim();
    const colorImages = {
      'black': 'assets/images/velu_black_bike.jpg',
      'blue': 'assets/images/velu_blue_bike.jpg',
      'green': 'assets/images/velu_green_bike.jpg',
      'red': 'assets/images/velu_red_bike.jpg',
      'yellow': 'assets/images/velu_yellow_bike.jpg',
    };
    return colorImages[colorLower] ?? 'assets/images/velu_black_bike.jpg';
  }

  @override
  Widget build(BuildContext context) {
    final resolvedBikeColor = bikeColor ?? _extractBikeColor(bikeName);
    final displayBikeName = bikeName?.trim().isNotEmpty == true
        ? '$slotCode ${bikeName!.trim()}'
        : 'Bike - Slot $slotCode';

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Column(
          children: [
            /// 🔹 HEADER
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: AppTheme.textPrimary,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Container(
                      height: 46,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: AppTheme.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: AppTheme.divider,
                          width: 1.2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: AppTheme.textSecondary,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              station.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: AppTheme.textPrimary,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// 🔹 CONTENT
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// 🔹 BIKE IMAGE (FIXED)
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: AppTheme.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppTheme.divider, width: 1.2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.asset(
                          _getColorImagePath(resolvedBikeColor),
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.directions_bike,
                                size: 80,
                                color: AppTheme.primary,
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// STATION INFO
                    Text(
                      station.id.toUpperCase(),
                      style: const TextStyle(
                        color: AppTheme.textSecondary,
                        fontSize: 16,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      station.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppTheme.textPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// BIKE NAME CARD
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: AppTheme.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppTheme.divider, width: 1.2),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              displayBikeName,
                              style: const TextStyle(
                                color: AppTheme.textPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Change',
                              style: TextStyle(
                                color: AppTheme.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// PASS
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'YOUR PASS',
                        style: TextStyle(
                          color: AppTheme.textSecondary,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppTheme.divider, width: 1.2),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.wallet_membership, size: 36, color: AppTheme.primary),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Unlimited 45 min rides\nValid for 1 year',
                              style: TextStyle(fontSize: 14, color: AppTheme.textPrimary),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// 🔹 RESPONSIVE BUTTON (FIXED)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 18),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  final buttonHeight = (width * 0.14).clamp(56.0, 64.0);
                  final thumbSize = (buttonHeight - 10).clamp(46.0, 54.0);
                  final swipeFontSize = (buttonHeight * 0.33).clamp(16.0, 20.0);

                  return Container(
                    height: buttonHeight,
                    decoration: BoxDecoration(
                      color: AppTheme.primary,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 12),

                        Container(
                          width: thumbSize,
                          height: thumbSize,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(100),
                          ),
                          child: const Icon(
                            Icons.chevron_right,
                            color: AppTheme.primary,
                            size: 22,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Text(
                            'Swipe to Ride',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: swipeFontSize,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        const SizedBox(width: 16),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
