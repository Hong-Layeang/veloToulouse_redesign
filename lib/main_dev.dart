import 'package:flutter/material.dart';
import 'main_common.dart';
import 'data/repositories/bike/bike_repository_mock.dart';
import 'data/repositories/station/station_repository_mock.dart';
import 'data/repositories/subscription/subscription_repository_mock.dart';

// Development entry point with mock repositories
void main() {
  runApp(
    VeloToulouseApp(
      bikeRepository: BikeRepositoryMock(),
      stationRepository: StationRepositoryMock(),
      subscriptionRepository: SubscriptionRepositoryMock(),
    ),
  );
}
