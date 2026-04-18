import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:velo_toulouse/data/config/firebase_config.dart';
import 'package:velo_toulouse/data/dtos/subscription_dto.dart';
import 'package:velo_toulouse/model/subscription.dart';

import 'subscription_repository.dart';

class SubscriptionRepositoryFirebase implements SubscriptionRepository {
  final Uri _activeSubscriptionUri = FirebaseConfig.baseUri.replace(
    path: '/users/demo_user/activeSubscriptionId.json',
  );
  final Uri _subscriptionsUri = FirebaseConfig.baseUri.replace(
    path: '/subscriptions.json',
  );

  @override
  Future<String?> fetchActiveSubscriptionId() async {
    final response = await http.get(_activeSubscriptionUri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load active subscription');
    }

    final dynamic decoded = json.decode(response.body);
    return decoded is String ? decoded : null;
  }

  @override
  Future<void> saveActiveSubscriptionId(String subscriptionId) async {
    final response = await http.put(
      _activeSubscriptionUri,
      body: json.encode(subscriptionId),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to save active subscription');
    }
  }

  @override
  Future<void> clearActiveSubscriptionId() async {
    final response = await http.delete(_activeSubscriptionUri);

    if (response.statusCode != 200) {
      throw Exception('Failed to clear active subscription');
    }
  }

  @override
  Future<List<Subscription>> fetchSubscriptions() async {
    final response = await http.get(_subscriptionsUri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load subscriptions');
    }

    final dynamic decoded = json.decode(response.body);
    if (decoded == null) {
      return <Subscription>[];
    }
    if (decoded is! Map<String, dynamic>) {
      throw Exception('Invalid subscriptions data format');
    }

    final result = decoded.entries
        .map((entry) => SubscriptionDto.fromJson(entry.key, entry.value as Map<String, dynamic>))
        .toList();
    result.sort((a, b) => a.duration.compareTo(b.duration));
    return result;
  }
}