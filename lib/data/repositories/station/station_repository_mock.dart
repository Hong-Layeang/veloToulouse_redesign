import 'package:velo_toulouse/data/repositories/station/station_repository.dart';
import 'package:velo_toulouse/models/bike_slot.dart';
import 'package:velo_toulouse/models/station.dart';

class StationRepositoryMock implements StationRepository {
  late final List<Station> _stations;

  StationRepositoryMock() {
    _initializeStations();
  }

  void _initializeStations() {
    _stations = <Station>[
      Station(
        id: 'station_1',
        name: 'Independence Monument',
        latitude: 11.5564,
        longitude: 104.9282,
        availableSlots: 4,
        totalSlots: 10,
        slots: _generateSlots('station_1', 10, 4),
      ),
      Station(
        id: 'station_2',
        name: 'Sisowath Quay Riverside',
        latitude: 11.5700,
        longitude: 104.9310,
        availableSlots: 6,
        totalSlots: 10,
        slots: _generateSlots('station_2', 10, 6),
      ),
      Station(
        id: 'station_3',
        name: 'Royal Palace',
        latitude: 11.5640,
        longitude: 104.9316,
        availableSlots: 3,
        totalSlots: 12,
        slots: _generateSlots('station_3', 12, 3),
      ),
      Station(
        id: 'station_4',
        name: 'Wat Phnom',
        latitude: 11.5765,
        longitude: 104.9223,
        availableSlots: 5,
        totalSlots: 10,
        slots: _generateSlots('station_4', 10, 5),
      ),
      Station(
        id: 'station_5',
        name: 'Central Market (Phsar Thmei)',
        latitude: 11.5697,
        longitude: 104.9213,
        availableSlots: 2,
        totalSlots: 14,
        slots: _generateSlots('station_5', 14, 2),
      ),
      Station(
        id: 'station_6',
        name: 'Russian Market (Phsar Toul Tom Poung)',
        latitude: 11.5437,
        longitude: 104.9201,
        availableSlots: 7,
        totalSlots: 12,
        slots: _generateSlots('station_6', 12, 7),
      ),
      Station(
        id: 'station_7',
        name: 'Orussey Market',
        latitude: 11.5608,
        longitude: 104.9177,
        availableSlots: 4,
        totalSlots: 10,         
        slots: _generateSlots('station_7', 10, 4),
      ),  
      Station(
        id: 'station_8',
        name: 'Olympic Stadium',
        latitude: 11.5595,
        longitude: 104.9122,
        availableSlots: 8,
        totalSlots: 15,
        slots: _generateSlots('station_8', 15, 8),
      ),
      Station(
        id: 'station_9',
        name: 'National Museum',
        latitude: 11.5647,
        longitude: 104.9303,
        availableSlots: 5,
        totalSlots: 10,
        slots: _generateSlots('station_9', 10, 5),
      ),
      Station(
        id: 'station_10',
        name: 'Wat Ounalom',
        latitude: 11.5695,
        longitude: 104.9307,
        availableSlots: 3,
        totalSlots: 8,
        slots: _generateSlots('station_10', 8, 3),
      ),
      Station(
        id: 'station_11',
        name: 'Wat Langka',
        latitude: 11.5552,
        longitude: 104.9232,
        availableSlots: 6,
        totalSlots: 10,
        slots: _generateSlots('station_11', 10, 6),
      ),
      Station(
        id: 'station_12',
        name: 'BKK Market',
        latitude: 11.5517,
        longitude: 104.9198,
        availableSlots: 4,
        totalSlots: 12,
        slots: _generateSlots('station_12', 12, 4),
      ),
      Station(
        id: 'station_13',
        name: 'Tuol Sleng Genocide Museum',
        latitude: 11.5492,
        longitude: 104.9176,
        availableSlots: 5,
        totalSlots: 10,
        slots: _generateSlots('station_13', 10, 5),
      ),
      Station(
        id: 'station_14',
        name: 'Hun Sen Park',
        latitude: 11.5507,
        longitude: 104.9304,
        availableSlots: 9,
        totalSlots: 15,
        slots: _generateSlots('station_14', 15, 9),
      ),
      Station(
        id: 'station_15',
        name: 'Koh Pich (Diamond Island)',
        latitude: 11.5469,
        longitude: 104.9372,
        availableSlots: 7,
        totalSlots: 14,
        slots: _generateSlots('station_15', 14, 7),
      ),
      Station(
        id: 'station_16',
        name: 'NagaWorld',
        latitude: 11.5545,
        longitude: 104.9329,
        availableSlots: 6,
        totalSlots: 12,
        slots: _generateSlots('station_16', 12, 6),
      ),
      Station(
        id: 'station_17',
        name: 'Aeon Mall Phnom Penh',
        latitude: 11.5502,
        longitude: 104.9323,
        availableSlots: 10,
        totalSlots: 20,
        slots: _generateSlots('station_17', 20, 10),
      ),
      Station(
        id: 'station_18',
        name: 'Chroy Changvar Bridge',
        latitude: 11.5829,
        longitude: 104.9357,
        availableSlots: 4,
        totalSlots: 10,
        slots: _generateSlots('station_18', 10, 4),
      ),
      Station(
        id: 'station_19',
        name: 'Royal University of Phnom Penh',
        latitude: 11.5685,
        longitude: 104.8898,
        availableSlots: 8,
        totalSlots: 16,
        slots: _generateSlots('station_19', 16, 8),
      ),
      Station(
        id: 'station_20',
        name: 'Aeon Mall Sen Sok City',
        latitude: 11.6042,
        longitude: 104.8869,
        availableSlots: 11,
        totalSlots: 20,
        slots: _generateSlots('station_20', 20, 11),
      ),
      Station(
        id: 'station_21',
        name: 'Stung Meanchey',
        latitude: 11.5246,
        longitude: 104.9097,
        availableSlots: 5,
        totalSlots: 10,
        slots: _generateSlots('station_21', 10, 5),
      ),
    ];
  }

  List<BikeSlot>  _generateSlots(
    String stationId,
    int totalSlots,
    int availableSlots,
  ) {
    final List<BikeSlot> slots = <BikeSlot>[];
    final List<String> prefixes = <String>['A', 'B', 'C', 'D'];
    final List<String> bikeNames = <String>[
      'Velo Red',
      'Velo Blue',
      'Velo Yellow',
      'Velo Green',
      'Velo Black',
    ];
    final List<String> bikeImages = <String>[
      'https://www.cincinnatiexperience.com/wp-content/uploads/2020/05/Cincy-Redbikes.jpg',
      'https://thumbnails.thecrimson.com/photos/2022/11/30/233645_1360004.JPG.2000x1333_q95_crop-smart_upscale.jpg',
      'https://vanderbilthustler.com/wp-content/uploads/2018/03/IMG-7187.jpg',
      'https://www.cincinnatiexperience.com/wp-content/uploads/2020/05/Cincy-Greenbikes.jpg',
      'https://www.cincinnatiexperience.com/wp-content/uploads/2020/05/Cincy-Blackbikes.jpg',
    ];

    for (int i = 0; i < totalSlots; i++) {
      final String prefix = prefixes[i ~/ 5];
      final int number = (i % 5) + 1;
      final String slotNumber = '$prefix$number';
      final bool isAvailable = i < availableSlots;
      final int bikeIndex = i % bikeNames.length;

      slots.add(
        BikeSlot(
          id: '${stationId}_slot_$i',
          slotNumber: slotNumber,
          isAvailable: isAvailable,
          bikeId: 'bike_${i + 1}',
          bikeName: bikeNames[bikeIndex],
          bikeImage: bikeImages[bikeIndex],
        ),
      );
    }

    return slots;
  }

  @override
  Future<List<Station>> fetchStations() async {
    return Future.delayed(Duration(seconds: 3), () {
      return _stations;
    });
  }

  @override
  Future<Station?> fetchStationById(String id) async {
    return Future.delayed(Duration(seconds: 3), () {
      return _stations.firstWhere(
        (station) => station.id == id,
        orElse: () => throw Exception("No station with id $id in the database"),
      );
    });
  }
}
