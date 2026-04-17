class Subscription {
  final String id;
  final String label;
  final String description;
  final double price;
  final Duration duration;

  /// Maximum allowed time per individual ride.
  final Duration rideDuration;

  Subscription({
    required this.id,
    required this.label,
    required this.description,
    required this.price,
    required this.duration,
    required this.rideDuration,
  });
}
