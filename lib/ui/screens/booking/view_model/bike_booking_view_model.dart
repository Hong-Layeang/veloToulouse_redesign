import 'package:flutter/foundation.dart';
import 'package:velo_toulouse/model/bike_slot.dart';
import 'package:velo_toulouse/model/station.dart';
import 'package:velo_toulouse/ui/states/ride_state.dart';
import 'package:velo_toulouse/ui/states/subscription_state.dart';

class BikeBookingViewModel extends ChangeNotifier {
  final Station station;
  final String slotCode;
  final String? bikeName;
  final String? bikeColor;
  final RideState rideState;
  final SubscriptionState subscriptionState;
  String _selectedSlotCode;
  String? _selectedBikeName;
  String? _selectedBikeColor;

  void _onSubscriptionStateChanged() {
    notifyListeners();
  }

  BikeBookingViewModel({
    required this.station,
    required this.slotCode,
    required this.rideState,
    required this.subscriptionState,
    this.bikeName,
    this.bikeColor,
  })  : _selectedSlotCode = slotCode,
        _selectedBikeName = bikeName,
        _selectedBikeColor = bikeColor {
    subscriptionState.addListener(_onSubscriptionStateChanged);

    final available = availableSlots;
    if (available.isEmpty) {
      return;
    }

    final matching = available.where((slot) => slot.slotNumber == slotCode);
    final selectedSlot = matching.isNotEmpty ? matching.first : available.first;
    _selectedSlotCode = selectedSlot.slotNumber;
    _selectedBikeName = selectedSlot.bikeName;
    _selectedBikeColor = selectedSlot.bikeColor ?? _extractBikeColor(selectedSlot.bikeName);
  }

  List<BikeSlot> get availableSlots => station.slots
      .where(
        (slot) =>
            slot.isAvailable &&
            !rideState.isSlotRented(station.id, slot.slotNumber),
      )
      .toList();

  String get displayBikeName {
    if (_selectedBikeName?.trim().isNotEmpty == true) {
      return '$_selectedSlotCode ${_selectedBikeName!.trim()}';
    }
    return 'Bike - Slot $_selectedSlotCode';
  }

  String get resolvedBikeColor {
    return _selectedBikeColor ?? _extractBikeColor(_selectedBikeName);
  }

  bool get hasActiveSubscription => subscriptionState.hasActiveSubscription;

  String get subscriptionSummary {
    final activePlan = subscriptionState.activeSubscription?.plan;
    if (activePlan == null) {
      return 'No active subscription';
    }
    return '${activePlan.label}\nRide limit: ${activePlan.rideDuration.inMinutes} min';
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

  bool changeBike() {
    final available = availableSlots;
    if (available.length <= 1) {
      return false;
    }

    final currentIndex = available.indexWhere(
      (slot) => slot.slotNumber == _selectedSlotCode,
    );
    final nextIndex = currentIndex < 0
        ? 0
        : (currentIndex + 1) % available.length;
    final nextSlot = available[nextIndex];

    _selectedSlotCode = nextSlot.slotNumber;
    _selectedBikeName = nextSlot.bikeName;
    _selectedBikeColor = nextSlot.bikeColor ?? _extractBikeColor(nextSlot.bikeName);
    notifyListeners();
    return true;
  }

  bool completeSwipeAndRent() {
    final activePlan = subscriptionState.activeSubscription?.plan;
    if (activePlan == null) {
      return false;
    }

    final maxRideDuration = activePlan.rideDuration;
    rideState.startRide(_selectedSlotCode, station.id, maxRideDuration);
    return true;
  }

  @override
  void dispose() {
    subscriptionState.removeListener(_onSubscriptionStateChanged);
    super.dispose();
  }
}
