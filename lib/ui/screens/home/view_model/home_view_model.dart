import 'package:flutter/material.dart';
import 'package:velo_toulouse/model/station.dart';
import 'package:velo_toulouse/data/repositories/station/station_repository.dart';

enum HomeStatus { loading, success, error }

class HomeViewModel extends ChangeNotifier {
  final StationRepository stationRepository;

  HomeStatus _status = HomeStatus.loading;
  List<Station> _stations = [];
  String? _errorMessage;
  int _currentTabIndex = 0;

  HomeStatus get status => _status;
  List<Station> get stations => _stations;
  String? get errorMessage => _errorMessage;
  int get currentTabIndex => _currentTabIndex;

  HomeViewModel({required this.stationRepository}) {
    _init();
  }

  Future<void> _init() async {
    try {
      _status = HomeStatus.loading;
      notifyListeners();

      _stations = await stationRepository.fetchStations();
      _status = HomeStatus.success;
    } catch (e) {
      _status = HomeStatus.error;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }

  void setTabIndex(int index) {
    _currentTabIndex = index;
    notifyListeners();
  }
}
