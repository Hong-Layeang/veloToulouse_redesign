import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'main_common.dart';
import 'data/repositories/bike/bike_repository_firebase.dart';
import 'data/repositories/station/station_repository_firebase.dart';
import 'data/repositories/subscription/subscription_repository_firebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    VeloToulouseApp(
      bikeRepository: BikeRepositoryFirebase(),
      stationRepository: StationRepositoryFirebase(),
      subscriptionRepository: SubscriptionRepositoryFirebase(),
    ),
  );
}
