import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velo_toulouse/data/repositories/station/station_repository.dart';
import 'package:velo_toulouse/ui/screens/home/view_model/home_view_model.dart';
import 'package:velo_toulouse/ui/screens/home/widgets/home_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) => HomeViewModel(
        stationRepository: context.read<StationRepository>(),
      ),
      child: const HomeContent(),
    );
  }
}
