import 'package:flutter/material.dart';
import '../../states/subscription_state.dart';
import '../subscription/subscriptions_screen.dart';
import 'widgets/map_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final SubscriptionState _subscriptionState = SubscriptionState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          MapView(subscriptionState: _subscriptionState),
          SubscriptionsScreen(subscriptionState: _subscriptionState),
        ],
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
