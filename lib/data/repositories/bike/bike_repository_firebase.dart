import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:velo_toulouse/data/dtos/bike_dto.dart';
import 'package:velo_toulouse/data/dtos/bike_slot_dto.dart';
import 'package:velo_toulouse/data/repositories/bike/bike_repository.dart';
import 'package:velo_toulouse/data/repositories/firebase_database_config.dart';
import 'package:velo_toulouse/model/bike.dart';
import 'package:velo_toulouse/model/bike_slot.dart';

class BikeRepositoryFirebase implements BikeRepository {
  BikeRepositoryFirebase({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  @override
  Future<List<Bike>> fetchBikes() async {
    final Uri uri = FirebaseDatabaseConfig.nodeUri('bikes');
    final http.Response response = await _client.get(
      uri,
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load bikes (HTTP ${response.statusCode}). '
        'Check Realtime Database rules and endpoint: $uri',
      );
    }

    if (response.body == 'null') {
      return <Bike>[];
    }

    final Map<String, dynamic> data = Map<String, dynamic>.from(
      json.decode(response.body) as Map,
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
    final Uri uri = FirebaseDatabaseConfig.nodeUri('bikes/$id');
    final http.Response response = await _client.get(
      uri,
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load bike $id (HTTP ${response.statusCode}). '
        'Check Realtime Database rules and endpoint: $uri',
      );
    }

    if (response.body == 'null') {
      return null;
    }

    final Map<String, dynamic> bikeJson = Map<String, dynamic>.from(
      json.decode(response.body) as Map,
    );

    return BikeDTO.fromJson(bikeJson).toModel();
  }

  @override
  Future<List<BikeSlot>> fetchBikeSlots() async {
    final Uri uri = FirebaseDatabaseConfig.nodeUri('stations');
    final http.Response response = await _client.get(
      uri,
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load bike slots (HTTP ${response.statusCode}). '
        'Check Realtime Database rules and endpoint: $uri',
      );
    }

    if (response.body == 'null') {
      return <BikeSlot>[];
    }

    final Map<String, dynamic> stationsData = Map<String, dynamic>.from(
      json.decode(response.body) as Map,
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
