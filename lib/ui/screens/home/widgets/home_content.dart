import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velo_toulouse/ui/screens/home/view_model/home_view_model.dart';
import 'package:velo_toulouse/ui/screens/home/widgets/map_view.dart';
import 'package:velo_toulouse/ui/screens/subscription/subscriptions_screen.dart';
import 'package:velo_toulouse/ui/states/ride_state.dart';
import 'package:velo_toulouse/ui/theme/app_theme.dart';
import 'package:velo_toulouse/ui/utils/async_value.dart';

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
    switch (homeViewModel.stationsValue.state) {
      case AsyncValueState.loading:
        return const Center(child: CircularProgressIndicator());
      case AsyncValueState.error:
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
      case AsyncValueState.success:
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
                      color: Colors.black.withValues(alpha: 0.1),
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
                            rideState.getRideRemainingTimeString(),
                            style: TextStyle(
                              color: rideState.rideRemainingTime.inMinutes < 5
                                  ? Colors.orange
                                  : Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => rideState.endRide(),
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
