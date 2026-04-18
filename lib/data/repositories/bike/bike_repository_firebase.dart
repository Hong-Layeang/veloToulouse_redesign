import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:velo_toulouse/data/config/firebase_config.dart';
import 'package:velo_toulouse/data/dtos/bike_dto.dart';
import 'package:velo_toulouse/model/bike.dart';
import 'package:velo_toulouse/model/bike_slot.dart';

import 'bike_repository.dart';

class BikeRepositoryFirebase implements BikeRepository {
  final Uri _bikesUri = FirebaseConfig.baseUri.replace(path: '/bikes.json');
  final Uri _bikeSlotsUri = FirebaseConfig.baseUri.replace(path: '/bikeSlots.json');

  @override
  Future<List<Bike>> fetchBikes() async {
    final response = await http.get(_bikesUri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load bikes');
    }

    final dynamic decoded = json.decode(response.body);
    if (decoded == null) {
      return <Bike>[];
    }
    if (decoded is! Map<String, dynamic>) {
      throw Exception('Invalid bikes data format');
    }

    return decoded.entries
        .map((entry) => BikeDto.fromJson(entry.key, entry.value as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Bike?> fetchBikeById(String id) async {
    final response = await http.get(
      FirebaseConfig.baseUri.replace(path: '/bikes/$id.json'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load bike');
    }

    final dynamic decoded = json.decode(response.body);
    if (decoded == null) {
      return null;
    }
    if (decoded is! Map<String, dynamic>) {
      throw Exception('Invalid bike data format');
    }

    return BikeDto.fromJson(id, decoded);
  }

  @override
  Future<List<BikeSlot>> fetchBikeSlots() async {
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

    return decoded.entries
        .map((entry) => BikeSlotDto.fromJson(entry.key, entry.value as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<BikeSlot?> fetchBikeSlotById(String id) async {
    final response = await http.get(
      FirebaseConfig.baseUri.replace(path: '/bikeSlots/$id.json'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load bike slot');
    }

    final dynamic decoded = json.decode(response.body);
    if (decoded == null) {
      return null;
    }
    if (decoded is! Map<String, dynamic>) {
      throw Exception('Invalid bike slot data format');
    }

    return BikeSlotDto.fromJson(id, decoded);
  }
}