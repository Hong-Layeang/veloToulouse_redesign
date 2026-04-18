import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:velo_toulouse/data/dtos/station_dto.dart';
import 'package:velo_toulouse/data/repositories/firebase_database_config.dart';
import 'package:velo_toulouse/data/repositories/station/station_repository.dart';
import 'package:velo_toulouse/model/station.dart';

class StationRepositoryFirebase implements StationRepository {
  StationRepositoryFirebase({FirebaseDatabase? database})
    : _database =
          database ??
          FirebaseDatabase.instanceFor(
            app: Firebase.app(),
            databaseURL: FirebaseDatabaseConfig.databaseUrl,
          );

  final FirebaseDatabase _database;

  @override
  Future<List<Station>> fetchStations() async {
    final DataSnapshot snapshot = await _database.ref('stations').get();
    if (!snapshot.exists || snapshot.value == null) {
      return <Station>[];
    }

    final Map<String, dynamic> data = Map<String, dynamic>.from(
      snapshot.value! as Map,
    );

    return data.values
        .map((dynamic stationRaw) => _mapStationFromRealtime(stationRaw))
        .toList();
  }

  @override
  Future<Station?> fetchStationById(String id) async {
    final DataSnapshot snapshot = await _database.ref('stations/$id').get();
    if (!snapshot.exists || snapshot.value == null) {
      return null;
    }

    return _mapStationFromRealtime(snapshot.value);
  }

  Station _mapStationFromRealtime(dynamic stationRaw) {
    final Map<String, dynamic> stationJson = Map<String, dynamic>.from(
      stationRaw as Map,
    );

    final dynamic slotsRaw = stationJson['slots'];
    if (slotsRaw is Map) {
      stationJson['slots'] = slotsRaw.values
          .map((dynamic slot) => Map<String, dynamic>.from(slot as Map))
          .toList();
    }

    return StationDTO.fromJson(stationJson).toModel();
  }
}
