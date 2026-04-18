import 'package:velo_toulouse/model/subscription.dart';

class SubscriptionDto {
  static const String labelKey = 'label';
  static const String descriptionKey = 'description';
  static const String priceKey = 'price';
  static const String durationInDaysKey = 'durationInDays';
  static const String rideDurationInMinutesKey = 'rideDurationInMinutes';

  static Subscription fromJson(String id, Map<String, dynamic> json) {
    return Subscription(
      id: id,
      label: (json[labelKey] as String?) ?? '',
      description: (json[descriptionKey] as String?) ?? '',
      price: ((json[priceKey] as num?) ?? 0).toDouble(),
      duration: Duration(days: ((json[durationInDaysKey] as num?) ?? 0).toInt()),
      rideDuration: Duration(
        minutes: ((json[rideDurationInMinutesKey] as num?) ?? 30).toInt(),
      ),
    );
  }
}