import 'package:flutter/material.dart';
import 'package:velo_toulouse/model/station.dart';
import 'package:velo_toulouse/ui/states/ride_state.dart';

class BikeBookingViewModel extends ChangeNotifier {
  final Station station;
  final String slotCode;
  final String? bikeName;
  final String? bikeImage;
  final String? bikeColor;
  final RideState rideState;

  BikeBookingViewModel({
    required this.station,
    required this.slotCode,
    required this.rideState,
    this.bikeName,
    this.bikeImage,
    this.bikeColor,
  });

  String get displayBikeName {
    if (bikeName?.trim().isNotEmpty == true) {
      return '$slotCode ${bikeName!.trim()}';
    }
    return 'Bike - Slot $slotCode';
  }

  String get resolvedBikeColor {
    return bikeColor ?? _extractBikeColor(bikeName);
  }

  String _extractBikeColor(String? name) {
    final normalized = name?.toLowerCase();
    if (normalized == null || normalized.isEmpty) return 'black';

    const supportedColors = ['black', 'blue', 'green', 'red', 'yellow'];
    for (final color in supportedColors) {
      if (normalized.contains(color)) return color;
    }
    return 'black';
  }

  bool get canStartRide => !rideState.hasActiveRide;

  String get activeRideMessage {
    return 'End your current ride first to unlock another bike.';
  }

  String getColorImagePath(String? color) {
    final colorLower = color?.toLowerCase().trim() ?? 'black';
    const colorImages = {
      'black': 'assets/images/velu_black_bike.jpg',
      'blue': 'assets/images/velu_blue_bike.jpg',
      'green': 'assets/images/velu_green_bike.jpg',
      'red': 'assets/images/velu_red_bike.jpg',
      'yellow': 'assets/images/velu_yellow_bike.jpg',
    };
    return colorImages[colorLower] ?? 'assets/images/velu_black_bike.jpg';
  }

  void changeBike() {
    // This will be implemented to open a bike selection modal
    notifyListeners();
  }

  bool completeSwipeAndRent() {
    final bool started = rideState.startRide(slotCode, station.id);
    if (started) {
      notifyListeners();
    }
    return started;
  }
}
