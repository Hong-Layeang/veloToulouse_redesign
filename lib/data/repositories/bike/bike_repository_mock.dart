import 'package:velo_toulouse/data/repositories/bike/bike_repository.dart';
import 'package:velo_toulouse/models/bike.dart';
import 'package:velo_toulouse/models/bike_slot.dart';

class BikeRepositoryMock implements BikeRepository {
  final List<Bike> _bikes = [];
  final List<BikeSlot> _bikeSlots = [];

  @override
  Future<List<Bike>> fetchBikes() async {
    return Future.delayed(Duration(seconds: 3), () {
      return _bikes;
    });
  }

  @override
  Future<Bike?> fetchBikeById(String id) async {
    return Future.delayed(Duration(seconds: 3), () {
      return _bikes.firstWhere(
        (bike) => bike.id == id,
        orElse: () => throw Exception("No bike with id $id in the database"),
      );
    });
  }

  @override
  Future<List<BikeSlot>> fetchBikeSlots() async {
    return Future.delayed(Duration(seconds: 3), () {
      return _bikeSlots;
    });
  }

  @override
  Future<BikeSlot?> fetchBikeSlotById(String id) async {
    return Future.delayed(Duration(seconds: 3), () {
      return _bikeSlots.firstWhere(
        (slot) => slot.id == id,
        orElse: () => throw Exception("No bike slot with id $id in the database"),
      );
    });
  }
}

