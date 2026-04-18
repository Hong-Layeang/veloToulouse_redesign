import 'package:velo_toulouse/model/station.dart';
import 'package:velo_toulouse/ui/states/ride_state.dart';
import 'package:flutter/foundation.dart';

class StationDetailViewModel extends ChangeNotifier {
  final Station station;
  final RideState rideState;

  StationDetailViewModel({required this.station, required this.rideState}) {
    rideState.addListener(_onRideStateChanged);
  }

  List<SlotView> get availableSlots => station.slots
      .where(
        (slot) =>
            slot.isAvailable &&
            !rideState.isSlotRented(station.id, slot.slotNumber),
      )
      .map(
        (slot) => SlotView(
          code: slot.slotNumber,
          bikeName: slot.bikeName,
          bikeImage: slot.bikeImage,
          bikeColor: slot.bikeColor ?? _extractBikeColor(slot.bikeName),
        ),
      )
      .toList();

  int get availableBikesCount => availableSlots.length;
  void _onRideStateChanged() => notifyListeners();

  String? _extractBikeColor(String? bikeName) {
    final normalized = bikeName?.toLowerCase();
    if (normalized == null || normalized.isEmpty) return null;

    const supportedColors = ['black', 'blue', 'green', 'red', 'yellow'];
    for (final color in supportedColors) {
      if (normalized.contains(color)) return color;
    }
    return null;
  }

  @override
  void dispose() {
    rideState.removeListener(_onRideStateChanged);
    super.dispose();
  }

}

class SlotView {
  final String code;
  final String? bikeName;
  final String? bikeImage;
  final String? bikeColor;

  SlotView({
    required this.code,
    required this.bikeName,
    required this.bikeImage,
    required this.bikeColor,
  });
}
