import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:velo_toulouse/data/dtos/station_dto.dart';
import 'package:velo_toulouse/data/repositories/firebase_database_config.dart';
import 'package:velo_toulouse/data/repositories/station/station_repository.dart';
import 'package:velo_toulouse/model/station.dart';

class StationRepositoryFirebase implements StationRepository {
  StationRepositoryFirebase({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  @override
  Future<List<Station>> fetchStations() async {
    final Uri uri = FirebaseDatabaseConfig.nodeUri('stations');
    final http.Response response = await _client.get(
      uri,
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load stations (HTTP ${response.statusCode}). '
        'Check Realtime Database rules for read access and endpoint: $uri',
      );
    }

    if (response.body == 'null') {
      return <Station>[];
    }

    final Map<String, dynamic> data = Map<String, dynamic>.from(
      json.decode(response.body) as Map,
    );

    return data.values
        .map((dynamic stationRaw) => _mapStationFromRealtime(stationRaw))
        .toList();
  }

  @override
  Future<Station?> fetchStationById(String id) async {
    final Uri uri = FirebaseDatabaseConfig.nodeUri('stations/$id');
    final http.Response response = await _client.get(
      uri,
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load station $id (HTTP ${response.statusCode}). '
        'Check Realtime Database rules for read access and endpoint: $uri',
      );
    }

    if (response.body == 'null') {
      return null;
    }

    return _mapStationFromRealtime(json.decode(response.body));
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
