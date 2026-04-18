import 'dart:async';

import 'package:flutter/material.dart';

class ActiveRide {
  final String bikeSlotId;
  final String stationId;
  final DateTime startTime;

  const ActiveRide({
    required this.bikeSlotId,
    required this.stationId,
    required this.startTime,
  });

  Duration get elapsedTime => DateTime.now().difference(startTime);
}

class RideState extends ChangeNotifier {
  ActiveRide? _currentRide;
  Timer? _ticker;

  ActiveRide? get currentRide => _currentRide;
  bool get hasActiveRide => _currentRide != null;
  Duration get rideElapsedTime => _currentRide?.elapsedTime ?? Duration.zero;

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (hasActiveRide) {
        notifyListeners();
      }
    });
  }

  void _stopTicker() {
    _ticker?.cancel();
    _ticker = null;
  }

  // Start a new ride when bike is booked
  bool startRide(String bikeSlotId, String stationId) {
    if (hasActiveRide) {
      return false;
    }

    _currentRide = ActiveRide(
      bikeSlotId: bikeSlotId,
      stationId: stationId,
      startTime: DateTime.now(),
    );
    _startTicker();
    notifyListeners();
    return true;
  }

  // End the current ride
  void endRide() {
    _currentRide = null;
    _stopTicker();
    notifyListeners();
  }

  @override
  void dispose() {
    _stopTicker();
    super.dispose();
  }

  // Get current ride duration
  String getRideDurationString() {
    if (_currentRide == null) return '00:00';
    final duration = rideElapsedTime;
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
