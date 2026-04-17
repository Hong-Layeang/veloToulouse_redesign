import 'package:flutter/material.dart';
import 'main_common.dart';
import 'data/repositories/bike/bike_repository_mock.dart';
import 'data/repositories/station/station_repository_mock.dart';
import 'data/repositories/subscription/subscription_repository_mock.dart';

// Note: Currently using mock repositories for development
void main() {
  runApp(
    VeloToulouseApp(
      bikeRepository: BikeRepositoryMock(),
      stationRepository: StationRepositoryMock(),
      subscriptionRepository: SubscriptionRepositoryMock(),
    ),
  );
}
