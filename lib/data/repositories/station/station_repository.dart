import 'package:velo_toulouse/models/station/station.dart';

abstract class StationRepository {
  Future<List<Station>> fetchStations();
  
  Future<Station?> fetchStationById(String id);
}
