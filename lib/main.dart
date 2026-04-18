import 'package:flutter/material.dart';
import 'main_common.dart';
import 'data/repositories/bike/bike_repository_firebase.dart';
import 'data/repositories/station/station_repository_firebase.dart';
import 'data/repositories/subscription/subscription_repository_firebase.dart';

// Default entry point uses Firebase realtime data repositories.
void main() {
  runApp(
    VeloToulouseApp(
      bikeRepository: BikeRepositoryFirebase(),
      stationRepository: StationRepositoryFirebase(),
      subscriptionRepository: SubscriptionRepositoryFirebase(),
    ),
  );
}
