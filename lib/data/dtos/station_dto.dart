import 'package:velo_toulouse/model/station.dart';

class StationDto {
  static const String nameKey = 'name';
  static const String latitudeKey = 'latitude';
  static const String longitudeKey = 'longitude';
  static const String availableSlotsKey = 'availableSlots';
  static const String totalSlotsKey = 'totalSlots';

  static Station fromJson(String id, Map<String, dynamic> json) {
    return Station(
      id: id,
      name: (json[nameKey] as String?) ?? '',
      latitude: ((json[latitudeKey] as num?) ?? 0).toDouble(),
      longitude: ((json[longitudeKey] as num?) ?? 0).toDouble(),
      availableSlots: (json[availableSlotsKey] as int?) ?? 0,
      totalSlots: (json[totalSlotsKey] as int?) ?? 0,
    );
  }
}