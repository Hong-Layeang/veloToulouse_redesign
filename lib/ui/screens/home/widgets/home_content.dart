import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velo_toulouse/ui/screens/home/view_model/home_view_model.dart';
import 'package:velo_toulouse/ui/screens/home/widgets/map_view.dart';
import 'package:velo_toulouse/ui/screens/subscription/subscriptions_screen.dart';
import 'package:velo_toulouse/ui/screens/ride_end/ride_end_screen.dart';
import 'package:velo_toulouse/ui/states/ride_state.dart';
import 'package:velo_toulouse/ui/theme/app_theme.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final homeViewModel = context.watch<HomeViewModel>();

    return Scaffold(
      body: _buildBody(context, homeViewModel),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: homeViewModel.currentTabIndex,
        onTap: (index) => homeViewModel.setTabIndex(index),
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

  Widget _buildBody(BuildContext context, HomeViewModel homeViewModel) {
    switch (homeViewModel.status) {
      case HomeStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case HomeStatus.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(homeViewModel.errorMessage ?? 'An error occurred'),
            ],
          ),
        );
      case HomeStatus.success:
        final rideState = context.watch<RideState>();
        return Column(
          children: [
            // Show active ride timer if ride is active
            if (rideState.hasActiveRide)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: AppTheme.primary,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Active Ride',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            rideState.getRideDurationString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final Duration duration = rideState.currentRideDuration;
                        rideState.endRide();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => RideEndScreen(duration: duration),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppTheme.primary,
                      ),
                      child: const Text(
                        'End Ride',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: IndexedStack(
                index: homeViewModel.currentTabIndex,
                children: [
                  MapView(stations: homeViewModel.stations),
                  const SubscriptionsScreenWrapper(),
                ],
              ),
            ),
          ],
        );
    }
  }
}
