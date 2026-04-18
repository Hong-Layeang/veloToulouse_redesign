import 'package:velo_toulouse/model/bike.dart';
import 'package:velo_toulouse/model/bike_slot.dart';

class BikeDto {
  static const String nameKey = 'name';

  static Bike fromJson(String id, Map<String, dynamic> json) {
    return Bike(
      id: id,
      name: (json[nameKey] as String?) ?? '',
    );
  }
}

class BikeSlotDto {
  static const String slotNumberKey = 'slotNumber';
  static const String isAvailableKey = 'isAvailable';
  static const String bikeIdKey = 'bikeId';
  static const String bikeNameKey = 'bikeName';

  static BikeSlot fromJson(String id, Map<String, dynamic> json) {
    final bikeId = json[bikeIdKey] as String?;
    final bikeName = json[bikeNameKey] as String?;

    return BikeSlot(
      id: id,
      slotNumber: (json[slotNumberKey] as String?) ?? id,
      isAvailable: (json[isAvailableKey] as bool?) ?? false,
      bikeId: bikeId,
      bikeName: bikeName,
      bike: bikeId != null && bikeName != null
          ? Bike(id: bikeId, name: bikeName)
          : null,
    );
  }
}