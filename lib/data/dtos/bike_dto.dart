import 'package:velo_toulouse/model/bike.dart';
import 'package:velo_toulouse/model/bike_slot.dart';

class BikeDto {
  static const String nameKey = 'name';
  static const String imageUrlKey = 'imageUrl';

  static Bike fromJson(String id, Map<String, dynamic> json) {
    return Bike(
      id: id,
      name: (json[nameKey] as String?) ?? '',
      imageUrl: (json[imageUrlKey] as String?) ?? '',
    );
  }
}

class BikeSlotDto {
  static const String slotNumberKey = 'slotNumber';
  static const String isAvailableKey = 'isAvailable';
  static const String bikeIdKey = 'bikeId';
  static const String bikeNameKey = 'bikeName';
  static const String bikeImageKey = 'bikeImage';

  static BikeSlot fromJson(String id, Map<String, dynamic> json) {
    final bikeId = json[bikeIdKey] as String?;
    final bikeName = json[bikeNameKey] as String?;
    final bikeImage = json[bikeImageKey] as String?;

    return BikeSlot(
      id: id,
      slotNumber: (json[slotNumberKey] as String?) ?? id,
      isAvailable: (json[isAvailableKey] as bool?) ?? false,
      bikeId: bikeId,
      bikeName: bikeName,
      bikeImage: bikeImage,
      bike: bikeId != null && bikeName != null && bikeImage != null
          ? Bike(id: bikeId, name: bikeName, imageUrl: bikeImage)
          : null,
    );
  }
}