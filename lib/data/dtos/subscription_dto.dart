import '../../model/subscription.dart';

class SubscriptionDTO {
  final String id;
  final String label;
  final String description;
  final double price;
  final int durationSeconds;
  final int rideDurationSeconds;

  SubscriptionDTO({
    required this.id,
    required this.label,
    required this.description,
    required this.price,
    required this.durationSeconds,
    required this.rideDurationSeconds,
  });

  factory SubscriptionDTO.fromJson(Map<String, dynamic> json) {
    return SubscriptionDTO(
      id: json['id'],
      label: json['label'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      durationSeconds: json['durationSeconds'],
      rideDurationSeconds: json['rideDurationSeconds'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'label': label,
    'description': description,
    'price': price,
    'durationSeconds': durationSeconds,
    'rideDurationSeconds': rideDurationSeconds,
  };

  Subscription toModel() => Subscription(
    id: id,
    label: label,
    description: description,
    price: price,
    duration: Duration(seconds: durationSeconds),
    rideDuration: Duration(seconds: rideDurationSeconds),
  );
}
