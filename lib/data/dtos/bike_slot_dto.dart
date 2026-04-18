import '../../model/bike_slot.dart';

class BikeSlotDTO {
  final String id;
  final String slotNumber;
  final bool isAvailable;
  final String? bikeId;
  final String? bikeName;

  BikeSlotDTO({
    required this.id,
    required this.slotNumber,
    required this.isAvailable,
    this.bikeId,
    this.bikeName,
  });

  factory BikeSlotDTO.fromJson(Map<String, dynamic> json) {
    return BikeSlotDTO(
      id: json['id'],
      slotNumber: json['slotNumber'],
      isAvailable: json['isAvailable'],
      bikeId: json['bikeId'],
      bikeName: json['bikeName'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'slotNumber': slotNumber,
    'isAvailable': isAvailable,
    'bikeId': bikeId,
    'bikeName': bikeName,
  };

  BikeSlot toModel() => BikeSlot(
    id: id,
    slotNumber: slotNumber,
    isAvailable: isAvailable,
    bikeId: bikeId,
    bikeName: bikeName,
  );
}
