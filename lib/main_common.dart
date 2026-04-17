import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velo_toulouse/data/repositories/bike/bike_repository.dart';
import 'package:velo_toulouse/data/repositories/station/station_repository.dart';
import 'package:velo_toulouse/data/repositories/subscription/subscription_repository.dart';
import 'ui/theme/app_theme.dart';
import 'ui/screens/home/home_screen.dart';
import 'ui/states/subscription_state.dart';
import 'ui/states/ride_state.dart';

class VeloToulouseApp extends StatelessWidget {
  /// Repositories for dependency injection
  final BikeRepository bikeRepository;
  final StationRepository stationRepository;
  final SubscriptionRepository subscriptionRepository;

  const VeloToulouseApp({
    super.key,
    required this.bikeRepository,
    required this.stationRepository,
    required this.subscriptionRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Data layer repositories
        Provider<BikeRepository>(create: (_) => bikeRepository),
        Provider<StationRepository>(create: (_) => stationRepository),
        Provider<SubscriptionRepository>(create: (_) => subscriptionRepository),

        // Global state management
        ChangeNotifierProvider(create: (_) => SubscriptionState()),
        ChangeNotifierProvider(create: (_) => RideState()),
      ],
      child: MaterialApp(
        title: 'VeloToulouse',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.theme,
        home: const HomeScreen(),
      ),
    );
  }
}
