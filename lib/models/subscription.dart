enum PassType { day, monthly, annual }

class SubscriptionPlan {
  final String id;
  final String name;
  final PassType type;
  final double pricePerMonth;
  final List<String> features;

  const SubscriptionPlan({
    required this.id,
    required this.name,
    required this.type,
    required this.pricePerMonth,
    required this.features,
  });

  String get priceLabel {
    switch (type) {
      case PassType.day:
        return '€${pricePerMonth.toStringAsFixed(2)}';
      case PassType.monthly:
        return '€${pricePerMonth.toStringAsFixed(2)}/month';
      case PassType.annual:
        return '€${pricePerMonth.toStringAsFixed(2)}/year';
    }
  }

  Duration get duration {
    switch (type) {
      case PassType.day:
        return const Duration(days: 1);
      case PassType.monthly:
        return const Duration(days: 30);
      case PassType.annual:
        return const Duration(days: 365);
    }
  }
}

class ActiveSubscription {
  final SubscriptionPlan plan;
  final DateTime startDate;
  final DateTime expirationDate;

  const ActiveSubscription({
    required this.plan,
    required this.startDate,
    required this.expirationDate,
  });

  bool get isExpired => DateTime.now().isAfter(expirationDate);
  bool get isActive => !isExpired;
}
