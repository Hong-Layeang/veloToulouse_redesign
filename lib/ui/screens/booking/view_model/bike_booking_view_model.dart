import 'package:velo_toulouse/model/station.dart';
import 'package:velo_toulouse/ui/states/ride_state.dart';

class BikeBookingViewModel {
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
  }

  void completeSwipeAndRent() {
    rideState.startRide(slotCode, station.id);
  }
}
