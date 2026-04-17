import 'package:velo_toulouse/models/bike.dart';
import 'package:velo_toulouse/models/bike_slot.dart';

abstract class BikeRepository {
  // Bike methods
  Future<List<Bike>> fetchBikes();
  
  Future<Bike?> fetchBikeById(String id);
  
  // BikeSlot methods
  Future<List<BikeSlot>> fetchBikeSlots();
  
  Future<BikeSlot?> fetchBikeSlotById(String id);
}
