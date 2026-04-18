import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:velo_toulouse/data/dtos/subscription_dto.dart';
import 'package:velo_toulouse/data/repositories/firebase_database_config.dart';
import 'package:velo_toulouse/data/repositories/subscription/subscription_repository.dart';
import 'package:velo_toulouse/model/subscription.dart';

class SubscriptionRepositoryFirebase implements SubscriptionRepository {
  SubscriptionRepositoryFirebase({FirebaseDatabase? database, FirebaseApp? app})
    : _database =
          database ??
          FirebaseDatabase.instanceFor(
            app: app ?? Firebase.app(),
            databaseURL: FirebaseDatabaseConfig.databaseUrl,
          );

  final FirebaseDatabase _database;

  DatabaseReference get _activeSubscriptionRef =>
      _database.ref('appState/activeSubscriptionId');

  @override
  Future<String?> fetchActiveSubscriptionId() async {
    final DataSnapshot snapshot = await _activeSubscriptionRef.get();
    if (!snapshot.exists || snapshot.value == null) {
      return null;
    }
    return snapshot.value.toString();
  }

  @override
  Future<void> saveActiveSubscriptionId(String subscriptionId) async {
    await _activeSubscriptionRef.set(subscriptionId);
  }

  @override
  Future<void> clearActiveSubscriptionId() async {
    await _activeSubscriptionRef.remove();
  }

  @override
  Future<List<Subscription>> fetchSubscriptions() async {
    final DataSnapshot snapshot = await _database.ref('subscriptions').get();
    if (!snapshot.exists || snapshot.value == null) {
      return <Subscription>[];
    }

    final Map<String, dynamic> data = Map<String, dynamic>.from(
      snapshot.value! as Map,
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
