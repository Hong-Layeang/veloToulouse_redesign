import 'package:flutter/material.dart';
import 'package:velo_toulouse/model/station.dart';

class StationDetailViewModel extends ChangeNotifier {
  final Station station;
  
  late List<SlotView> _availableSlots;
  
  StationDetailViewModel({required this.station}) {
    _initializeAvailableSlots();
  }

  List<SlotView> get availableSlots => _availableSlots;
  int get availableBikesCount => _availableSlots.length;

  void _initializeAvailableSlots() {
    _availableSlots = station.slots
        .where((slot) => slot.isAvailable)
        .map(
          (slot) => SlotView(
            code: slot.slotNumber,
            bikeName: slot.bikeName,
            bikeImage: slot.bikeImage,
            bikeColor: slot.bikeColor ?? _extractBikeColor(slot.bikeName),
          ),
        )
        .toList();
  }

  String? _extractBikeColor(String? bikeName) {
    final normalized = bikeName?.toLowerCase();
    if (normalized == null || normalized.isEmpty) return null;

    const supportedColors = ['black', 'blue', 'green', 'red', 'yellow'];
    for (final color in supportedColors) {
      if (normalized.contains(color)) return color;
    }
    return null;
  }

  int getGridCrossAxisCount(double width) {
    if (width >= 560) return 4;
    if (width >= 390) return 3;
    return 2;
  }

  void selectSlot(SlotView slot) {
    // This can be expanded for booking logic
    notifyListeners();
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
