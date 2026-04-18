import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velo_toulouse/model/station.dart';
import 'package:velo_toulouse/ui/states/ride_state.dart';
import 'package:velo_toulouse/ui/states/subscription_state.dart';
import 'view_model/bike_booking_view_model.dart';
import 'widgets/bike_booking_content.dart';

class BikeBookingScreen extends StatelessWidget {
  final Station station;
  final String slotCode;
  final String? bikeName;
  final String? bikeImage;
  final String? bikeColor;

  const BikeBookingScreen({
    super.key,
    required this.station,
    required this.slotCode,
    this.bikeName,
    this.bikeImage,
    this.bikeColor,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BikeBookingViewModel>(
      create: (context) => BikeBookingViewModel(
        station: station,
        slotCode: slotCode,
        bikeName: bikeName,
        bikeImage: bikeImage,
        bikeColor: bikeColor,
        rideState: context.read<RideState>(),
        subscriptionState: context.read<SubscriptionState>(),
      ),
      child: const BikeBookingContent(),
    );
  }
}
