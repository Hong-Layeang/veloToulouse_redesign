import '../../model/station.dart';
import 'bike_slot_dto.dart';

class StationDTO {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final int totalSlots;
  final int availableSlots;
  final List<BikeSlotDTO> slots;

  StationDTO({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.totalSlots,
    required this.availableSlots,
    required this.slots,
  });

  factory StationDTO.fromJson(Map<String, dynamic> json) {
    return StationDTO(
      id: json['id'],
      name: json['name'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      totalSlots: json['totalSlots'],
      availableSlots: json['availableSlots'],
      slots: (json['slots'] as List<dynamic>)
          .map((slot) => BikeSlotDTO.fromJson(slot))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'latitude': latitude,
    'longitude': longitude,
    'totalSlots': totalSlots,
    'availableSlots': availableSlots,
    'slots': slots.map((s) => s.toJson()).toList(),
  };

  Station toModel() => Station(
    id: id,
    name: name,
    latitude: latitude,
    longitude: longitude,
    totalSlots: totalSlots,
    availableSlots: availableSlots,
    slots: slots.map((s) => s.toModel()).toList(),
  );
}
