import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:velo_toulouse/data/dtos/subscription_dto.dart';
import 'package:velo_toulouse/data/repositories/firebase_database_config.dart';
import 'package:velo_toulouse/data/repositories/subscription/subscription_repository.dart';
import 'package:velo_toulouse/model/subscription.dart';

class SubscriptionRepositoryFirebase implements SubscriptionRepository {
  SubscriptionRepositoryFirebase({http.Client? client})
    : _client = client ?? http.Client();

  final http.Client _client;

  @override
  Future<String?> fetchActiveSubscriptionId() async {
    final Uri uri = FirebaseDatabaseConfig.nodeUri('appState/activeSubscriptionId');
    final http.Response response = await _client.get(
      uri,
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load active subscription id (HTTP ${response.statusCode}). '
        'Check Realtime Database rules and endpoint: $uri',
      );
    }

    if (response.body == 'null') {
      return null;
    }

    final dynamic value = json.decode(response.body);
    return value?.toString();
  }

  @override
  Future<void> saveActiveSubscriptionId(String subscriptionId) async {
    final Uri uri = FirebaseDatabaseConfig.nodeUri('appState/activeSubscriptionId');
    final http.Response response = await _client.put(
      uri,
      headers: <String, String>{'Content-Type': 'application/json'},
      body: json.encode(subscriptionId),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to save active subscription id (HTTP ${response.statusCode}). '
        'Check Realtime Database rules and endpoint: $uri',
      );
    }
  }

  @override
  Future<void> clearActiveSubscriptionId() async {
    final Uri uri = FirebaseDatabaseConfig.nodeUri('appState/activeSubscriptionId');
    final http.Response response = await _client.delete(
      uri,
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to clear active subscription id (HTTP ${response.statusCode}). '
        'Check Realtime Database rules and endpoint: $uri',
      );
    }
  }

  @override
  Future<List<Subscription>> fetchSubscriptions() async {
    final Uri uri = FirebaseDatabaseConfig.nodeUri('subscriptions');
    final http.Response response = await _client.get(
      uri,
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Failed to load subscriptions (HTTP ${response.statusCode}). '
        'Check Realtime Database rules and endpoint: $uri',
      );
    }

    if (response.body == 'null') {
      return <Subscription>[];
    }

    final Map<String, dynamic> data = Map<String, dynamic>.from(
      json.decode(response.body) as Map,
    );

    return data.values
        .map(
          (dynamic subRaw) => SubscriptionDTO.fromJson(
            Map<String, dynamic>.from(subRaw as Map),
          ).toModel(),
        )
        .toList();
  }
}
