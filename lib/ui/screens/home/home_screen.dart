import 'package:flutter/material.dart';
import 'package:velo_toulouse/ui/screens/home/widgets/map_view.dart';
import '../../../data/repositories/station/station_repository_mock.dart';
import '../../../models/station/station.dart';
import '../../states/subscription_state.dart';
import '../subscription/subscriptions_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final SubscriptionState _subscriptionState = SubscriptionState();
  late final Future<List<Station>> _stationsFuture;

  @override
  void initState() {
    super.initState();
    _stationsFuture = StationRepositoryMock().fetchStations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Station>>(
        future: _stationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final stations = snapshot.data ?? const <Station>[];
          return IndexedStack(
            index: _currentIndex,
            children: [
              MapView(stations: stations),
              SubscriptionsScreen(subscriptionState: _subscriptionState),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            activeIcon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.euro_outlined),
            activeIcon: Icon(Icons.euro),
            label: 'Subscriptions',
          ),
        ],
      ),
    );
  }
}
