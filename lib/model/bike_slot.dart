import 'package:velo_toulouse/model/bike.dart';

class BikeSlot {
  final String id;
  final String slotNumber;
  final bool isAvailable;
  final Bike? bike;
  final String? bikeId;
  final String? bikeName;

  const BikeSlot({
    required this.id,
    required this.slotNumber,
    required this.isAvailable,
    this.bike,
    this.bikeId,
    this.bikeName,
  });

  @override
  String toString() {
    return 'BikeSlot(id: $id, slotNumber: $slotNumber, isAvailable: $isAvailable, bikeId: $bikeId, bikeName: $bikeName, bike: $bike)';
  }
}
