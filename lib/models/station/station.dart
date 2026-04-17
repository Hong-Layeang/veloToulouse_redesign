
import 'package:velo_toulouse/models/bike_slot/bike_slot.dart';

class Station {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final int totalSlots;
  final int availableSlots;
  final BikeSlot? bikeslot;
  final List<BikeSlot> slots;

  const Station({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.totalSlots,
    required this.availableSlots,
    this.bikeslot,
    this.slots = const <BikeSlot>[],
  });

  @override
  String toString() {
    return 'Station(id: $id, name: $name, latitude: $latitude, longitude: $longitude, totalSlots: $totalSlots, availableSlots: $availableSlots, bikeslot: $bikeslot)';
  }  
}
