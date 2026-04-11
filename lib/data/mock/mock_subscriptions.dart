import '../../models/subscription.dart';

const List<SubscriptionPlan> availablePlans = [
  SubscriptionPlan(
    id: 'day',
    name: 'JOURNÉE',
    type: PassType.day,
    pricePerMonth: 1.70,
    features: [
      'Ride without limit for 24h',
      'First 30 mins free (mechanical bike)',
      'First 30 mins for €1 (electric bike)',
    ],
  ),
  SubscriptionPlan(
    id: 'monthly',
    name: 'MENSUEL',
    type: PassType.monthly,
    pricePerMonth: 9.78,
    features: [
      'First 30 mins free (electric bike)',
      'Up to 7 trips per day',
      'Unlimited trips (mechanical bike)',
    ],
  ),
  SubscriptionPlan(
    id: 'annual',
    name: 'ANNUEL',
    type: PassType.annual,
    pricePerMonth: 15.00,
    features: [
      'All monthly benefits',
      'Priority bike access',
      'Free first 45 mins (all bikes)',
    ],
  ),
];
