import 'package:flutter/foundation.dart';
import 'package:velo_toulouse/model/bike_slot.dart';
import 'package:velo_toulouse/model/station.dart';
import 'package:velo_toulouse/ui/states/ride_state.dart';
import 'package:velo_toulouse/ui/states/subscription_state.dart';

class BikeBookingViewModel extends ChangeNotifier {
  final Station station;
  final String slotCode;
  final String? bikeName;
  final RideState rideState;
  final SubscriptionState subscriptionState;
  String _selectedSlotCode;
  String? _selectedBikeName;

  void _onSubscriptionStateChanged() {
    notifyListeners();
  }

  BikeBookingViewModel({
    required this.station,
    required this.slotCode,
    required this.rideState,
    required this.subscriptionState,
    this.bikeName,
  })  : _selectedSlotCode = slotCode,
        _selectedBikeName = bikeName {
    subscriptionState.addListener(_onSubscriptionStateChanged);

    final available = availableSlots;
    if (available.isEmpty) {
      return;
    }

    final matching = available.where((slot) => slot.slotNumber == slotCode);
    final selectedSlot = matching.isNotEmpty ? matching.first : available.first;
    _selectedSlotCode = selectedSlot.slotNumber;
    _selectedBikeName = selectedSlot.bikeName;
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

  bool get hasActiveSubscription => subscriptionState.hasActiveSubscription;

  bool get hasActiveRide => rideState.hasActiveRide;

  String get activeRideMessage => rideState.activeRideMessage;

  String get subscriptionSummary {
    final activePlan = subscriptionState.activeSubscription?.plan;
    if (activePlan == null) {
      return 'No active subscription';
    }
    return '${activePlan.label}\nRide limit: ${activePlan.rideDuration.inMinutes} min';
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
    notifyListeners();
    return true;
  }

  bool completeSwipeAndRent() {
    if (rideState.hasActiveRide) {
      return false;
    }

    final activePlan = subscriptionState.activeSubscription?.plan;
    if (activePlan == null) {
      return false;
    }

    final maxRideDuration = activePlan.rideDuration;
    return rideState.startRide(_selectedSlotCode, station.id, maxRideDuration);
  }

  @override
  void dispose() {
    subscriptionState.removeListener(_onSubscriptionStateChanged);
    super.dispose();
  }
}
