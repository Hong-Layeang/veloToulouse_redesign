import 'package:velo_toulouse/data/repositories/subscription/subscription_repository.dart';
import 'package:velo_toulouse/model/subscription.dart';

class SubscriptionRepositoryMock implements SubscriptionRepository {
  String? _activeSubscriptionId;

  @override
  Future<String?> fetchActiveSubscriptionId() async {
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _activeSubscriptionId,
    );
  }

  @override
  Future<void> saveActiveSubscriptionId(String subscriptionId) async {
    return Future.delayed(const Duration(milliseconds: 300), () {
      _activeSubscriptionId = subscriptionId;
    });
  }

  @override
  Future<void> clearActiveSubscriptionId() async {
    return Future.delayed(const Duration(milliseconds: 300), () {
      _activeSubscriptionId = null;
    });
  }

  @override
  Future<List<Subscription>> fetchSubscriptions() async {
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => <Subscription>[
        Subscription(
          id: 'day_pass',
          label: 'Day Pass',
          description: 'Unlimited 30 minutes rides\nValid for 24 hours',
          price: 3,
          duration: const Duration(days: 1),
          rideDuration: const Duration(minutes: 30),
        ),
        Subscription(
          id: 'monthly_pass',
          label: 'Monthly Pass - Best Deal',
          description: 'Unlimited 45 minutes rides\nValid for 1 month',
          price: 25,
          duration: const Duration(days: 30),
          rideDuration: const Duration(minutes: 45),
        ),
        Subscription(
          id: 'annual_pass',
          label: 'Annual Pass',
          description: 'Unlimited 45 minutes rides\nValid for 1 year',
          price: 50,
          duration: const Duration(days: 365),
          rideDuration: const Duration(minutes: 45),
        ),
      ],
    );
  }
}
