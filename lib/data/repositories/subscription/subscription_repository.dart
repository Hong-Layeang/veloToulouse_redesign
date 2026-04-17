import 'package:velo_toulouse/model/subscription.dart';

abstract class SubscriptionRepository {
  Future<String?> fetchActiveSubscriptionId();

  Future<void> saveActiveSubscriptionId(String subscriptionId);

  Future<void> clearActiveSubscriptionId();

  Future<List<Subscription>> fetchSubscriptions();
}
