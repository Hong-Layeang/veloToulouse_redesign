import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:velo_toulouse/data/config/firebase_config.dart';
import 'package:velo_toulouse/data/dtos/station_dto.dart';
import 'package:velo_toulouse/model/bike_slot.dart';
import 'package:velo_toulouse/model/station.dart';

import 'station_repository.dart';

class StationRepositoryFirebase implements StationRepository {
  final Uri _stationsUri = FirebaseConfig.baseUri.replace(path: '/stations.json');
  final Uri _bikeSlotsUri = FirebaseConfig.baseUri.replace(path: '/bikeSlots.json');

  @override
  Future<List<Station>> fetchStations() async {
    final response = await http.get(_stationsUri);
    if (response.statusCode != 200) {
      throw Exception('Failed to load stations');
    }

    final dynamic decoded = json.decode(response.body);
    if (decoded == null) {
      return <Station>[];
    }
    if (decoded is! Map<String, dynamic>) {
      throw Exception('Invalid stations data format');
    }

    final bikeSlots = await _fetchBikeSlots();

    return decoded.entries.map((entry) {
      final station = StationDto.fromJson(entry.key, entry.value as Map<String, dynamic>);
      final stationSlots = bikeSlots
          .where((slot) => slot.id.startsWith('${entry.key}_'))
          .toList();

      return Station(
        id: station.id,
        name: station.name,
        latitude: station.latitude,
        longitude: station.longitude,
        totalSlots: station.totalSlots,
        availableSlots: station.availableSlots,
        slots: stationSlots,
      );
    }).toList();
  }

  @override
  Future<Station?> fetchStationById(String id) async {
    final response = await http.get(
      FirebaseConfig.baseUri.replace(path: '/stations/$id.json'),
    );

    if (response.statusCode == 404) {
      throw Exception('No station with id $id in the database');
    }
    if (response.statusCode != 200) {
      throw Exception('Failed to load station');
    }

    final dynamic decoded = json.decode(response.body);
    if (decoded == null) {
      throw Exception('No station with id $id in the database');
    }
    if (decoded is! Map<String, dynamic>) {
      throw Exception('Invalid station data format');
    }

    final station = StationDto.fromJson(id, decoded);
    final bikeSlots = await _fetchBikeSlots();
    final stationSlots = bikeSlots
        .where((slot) => slot.id.startsWith('${id}_'))
        .toList();

    return Station(
      id: station.id,
      name: station.name,
      latitude: station.latitude,
      longitude: station.longitude,
      totalSlots: station.totalSlots,
      availableSlots: station.availableSlots,
      slots: stationSlots,
    );
  }

  Future<List<BikeSlot>> _fetchBikeSlots() async {
    final response = await http.get(_bikeSlotsUri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load bike slots');
    }

    final dynamic decoded = json.decode(response.body);
    if (decoded == null) {
      return <BikeSlot>[];
    }
    if (decoded is! Map<String, dynamic>) {
      throw Exception('Invalid bike slots data format');
    }

    final slots = <BikeSlot>[];
    for (final entry in decoded.entries) {
      final slotData = entry.value as Map<String, dynamic>;
      final stationId = slotData['stationId'] as String?;
      if (stationId == null) {
        continue;
      }

      slots.add(
        BikeSlot(
          id: '${stationId}_${entry.key}',
          slotNumber: slotData['slotNumber']?.toString() ?? entry.key,
          isAvailable: slotData['isAvailable'] as bool? ?? false,
          bikeId: slotData['bikeId'] as String?,
          bikeName: slotData['bikeName'] as String?,
          bikeImage: slotData['bikeImage'] as String?,
        ),
      );
    }

    return slots;
  }
}