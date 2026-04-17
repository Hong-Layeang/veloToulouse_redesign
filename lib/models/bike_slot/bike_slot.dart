import 'package:velo_toulouse/models/bike/bike.dart';

class BikeSlot {
  final String id;
  final String slotNumber;
  final bool isAvailable;
  final Bike? bike;
  final String? bikeId;
  final String? bikeName;
  final String? bikeImage;
  final String? bikeColor;

  const BikeSlot({
    required this.id,
    required this.slotNumber,
    required this.isAvailable,
    this.bike,
    this.bikeId,
    this.bikeName,
    this.bikeImage,
    this.bikeColor,
  });

  @override
  String toString() {
    return 'BikeSlot(id: $id, slotNumber: $slotNumber, isAvailable: $isAvailable, bikeId: $bikeId, bikeName: $bikeName, bikeColor: $bikeColor, bike: $bike)';
  }
}
