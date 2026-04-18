import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:velo_toulouse/data/dtos/bike_dto.dart';
import 'package:velo_toulouse/data/dtos/bike_slot_dto.dart';
import 'package:velo_toulouse/data/repositories/bike/bike_repository.dart';
import 'package:velo_toulouse/data/repositories/firebase_database_config.dart';
import 'package:velo_toulouse/model/bike.dart';
import 'package:velo_toulouse/model/bike_slot.dart';

class BikeRepositoryFirebase implements BikeRepository {
  BikeRepositoryFirebase({FirebaseDatabase? database, FirebaseApp? app})
    : _database =
          database ??
          FirebaseDatabase.instanceFor(
            app: app ?? Firebase.app(),
            databaseURL: FirebaseDatabaseConfig.databaseUrl,
          );

  final FirebaseDatabase _database;

  @override
  Future<List<Bike>> fetchBikes() async {
    final DataSnapshot snapshot = await _database.ref('bikes').get();
    if (!snapshot.exists || snapshot.value == null) {
      return <Bike>[];
    }

    final Map<String, dynamic> data = Map<String, dynamic>.from(
      snapshot.value! as Map,
    );

    return data.values
        .map(
          (dynamic bikeRaw) => BikeDTO.fromJson(
            Map<String, dynamic>.from(bikeRaw as Map),
          ).toModel(),
        )
        .toList();
  }

  @override
  Future<Bike?> fetchBikeById(String id) async {
    final DataSnapshot snapshot = await _database.ref('bikes/$id').get();
    if (!snapshot.exists || snapshot.value == null) {
      return null;
    }

    final Map<String, dynamic> bikeJson = Map<String, dynamic>.from(
      snapshot.value! as Map,
    );

    return BikeDTO.fromJson(bikeJson).toModel();
  }

  @override
  Future<List<BikeSlot>> fetchBikeSlots() async {
    final DataSnapshot snapshot = await _database.ref('stations').get();
    if (!snapshot.exists || snapshot.value == null) {
      return <BikeSlot>[];
    }

    final Map<String, dynamic> stationsData = Map<String, dynamic>.from(
      snapshot.value! as Map,
    );

    final List<BikeSlot> slots = <BikeSlot>[];

    for (final dynamic stationRaw in stationsData.values) {
      final Map<String, dynamic> stationJson = Map<String, dynamic>.from(
        stationRaw as Map,
      );
      final dynamic slotsRaw = stationJson['slots'];
      if (slotsRaw is! Map) {
        continue;
      }

      for (final dynamic slotRaw in slotsRaw.values) {
        final Map<String, dynamic> slotJson = Map<String, dynamic>.from(
          slotRaw as Map,
        );
        slots.add(BikeSlotDTO.fromJson(slotJson).toModel());
      }
    }

    return slots;
  }

  @override
  Future<BikeSlot?> fetchBikeSlotById(String id) async {
    final List<BikeSlot> allSlots = await fetchBikeSlots();
    for (final BikeSlot slot in allSlots) {
      if (slot.id == id) {
        return slot;
      }
    }
    return null;
  }
}
