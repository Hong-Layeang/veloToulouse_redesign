enum BikeType { electric, mechanical }

enum BikeCondition { good, charging, maintenance }

class Bike {
  final String id;
  final String name;
  final BikeType type;
  final BikeCondition condition;
  final int? batteryPercent;

  const Bike({
    required this.id,
    required this.name,
    required this.type,
    required this.condition,
    this.batteryPercent,
  });

  bool get isAvailable => condition != BikeCondition.maintenance && condition != BikeCondition.charging;
}
