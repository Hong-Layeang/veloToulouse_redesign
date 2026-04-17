import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velo_toulouse/model/station.dart';
import 'view_model/station_detail_view_model.dart';
import 'widgets/station_detail_content.dart';

class StationDetailScreen extends StatelessWidget {
  final Station station;

  const StationDetailScreen({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StationDetailViewModel>(
      create: (context) => StationDetailViewModel(station: station),
      child: const StationDetailContent(),
    );
  }
}
