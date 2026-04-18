import 'package:flutter/material.dart';
import 'package:velo_toulouse/model/station.dart';
import 'package:velo_toulouse/data/repositories/station/station_repository.dart';
import 'package:velo_toulouse/ui/utils/async_value.dart';

class HomeViewModel extends ChangeNotifier {
  final StationRepository stationRepository;

  AsyncValue<List<Station>> _stationsValue = AsyncValue<List<Station>>.loading();
  int _currentTabIndex = 0;

  AsyncValue<List<Station>> get stationsValue => _stationsValue;
  List<Station> get stations => _stationsValue.data ?? const <Station>[];
  String? get errorMessage => _stationsValue.error?.toString();
  int get currentTabIndex => _currentTabIndex;

  HomeViewModel({required this.stationRepository}) {
    _init();
  }

  Future<void> _init() async {
    _stationsValue = AsyncValue<List<Station>>.loading();
    notifyListeners();

    try {
      final stations = await stationRepository.fetchStations();
      _stationsValue = AsyncValue<List<Station>>.success(stations);
    } catch (e) {
      _stationsValue = AsyncValue<List<Station>>.error(e);
    }
    notifyListeners();
  }

  void setTabIndex(int index) {
    _currentTabIndex = index;
    notifyListeners();
  }
}
