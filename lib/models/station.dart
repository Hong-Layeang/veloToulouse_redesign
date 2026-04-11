import 'bike.dart';

class Station {
  final String id;
  final String name;
  final List<Bike> bikes;
  final int totalDocks;

  const Station({
    required this.id,
    required this.name,
    required this.bikes,
    required this.totalDocks,
  });

  int get availableBikes => bikes.where((b) => b.isAvailable).length;
  int get availableDocks => totalDocks - bikes.length;

  Bike? get recommendedBike {
    final available = bikes.where((b) => b.isAvailable).toList();
    if (available.isEmpty) return null;
    // Prefer electric with highest battery
    final electric = available.where((b) => b.type == BikeType.electric).toList();
    if (electric.isNotEmpty) {
      electric.sort((a, b) => (b.batteryPercent ?? 0).compareTo(a.batteryPercent ?? 0));
      return electric.first;
    }
    return available.first;
  }
}
