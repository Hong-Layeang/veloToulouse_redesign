import 'dart:async';

import 'package:flutter/material.dart';

class ActiveRide {
  final String bikeSlotId;
  final String stationId;
  final DateTime startTime;
  final Duration? maxDuration; 

  const ActiveRide({
    required this.bikeSlotId,
    required this.stationId,
    required this.startTime,
    this.maxDuration,
  });

  Duration get elapsedTime => DateTime.now().difference(startTime);
  
  Duration get remainingTime {
    if (maxDuration == null) return Duration.zero;
    final remaining = maxDuration! - elapsedTime;
    return remaining.isNegative ? Duration.zero : remaining;
  }
}

class RideState extends ChangeNotifier {
  ActiveRide? _currentRide;
  Timer? _ticker;
  final Set<String> _rentedSlotKeys = <String>{};

  String _slotKey(String stationId, String slotId) => '$stationId::$slotId';

  ActiveRide? get currentRide => _currentRide;
  bool get hasActiveRide => _currentRide != null;
  Duration get rideElapsedTime => _currentRide?.elapsedTime ?? Duration.zero;
  Duration get rideRemainingTime => _currentRide?.remainingTime ?? Duration.zero;
  Set<String> get rentedSlotKeys => _rentedSlotKeys;

  bool isSlotRented(String stationId, String slotId) {
    return _rentedSlotKeys.contains(_slotKey(stationId, slotId));
  }

  // Start a new ride when bike is booked
  void startRide(String bikeSlotId, String stationId, [Duration? maxDuration]) {
    _currentRide = ActiveRide(
      bikeSlotId: bikeSlotId,
      stationId: stationId,
      startTime: DateTime.now(),
      maxDuration: maxDuration,
    );
    _rentedSlotKeys.add(_slotKey(stationId, bikeSlotId));
    _startTicker();
    notifyListeners();
  }

  // End the current ride
  void endRide() {
    _currentRide = null;
    _stopTicker();
    notifyListeners();
  }

  // Get current ride duration
  String getRideDurationString() {
    if (_currentRide == null) return '00:00';
    final duration = rideElapsedTime;
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  // Get remaining ride time
  String getRideRemainingTimeString() {
    if (_currentRide == null || _currentRide!.maxDuration == null) return '00:00';
    final duration = rideRemainingTime;
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_currentRide == null) return;
      notifyListeners();
    });
  }

  void _stopTicker() {
    _ticker?.cancel();
    _ticker = null;
  }

  @override
  void dispose() {
    _stopTicker();
    super.dispose();
  }
}
