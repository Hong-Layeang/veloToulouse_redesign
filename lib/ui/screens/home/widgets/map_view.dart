import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:velo_toulouse/model/station.dart';
import '../../station_detail/station_detail_screen.dart';

const LatLng _fallbackCenter = LatLng(11.5564, 104.9282);

@immutable
class MapFilterState {
  final String searchText;

  const MapFilterState({this.searchText = ''});

  MapFilterState copyWith({String? searchText}) {
    return MapFilterState(searchText: searchText ?? this.searchText);
  }
}

class MapViewPresenter {
  const MapViewPresenter._();

  static int availableBikeCount(Station station) {
    return station.slots.where((slot) => slot.isAvailable).length;
  }

  static List<Station> filterStations(
    List<Station> allStations,
    MapFilterState filters,
  ) {
    return allStations.where((station) {
      final query = filters.searchText.trim().toLowerCase();
      return query.isEmpty || station.name.toLowerCase().contains(query);
    }).toList();
  }

  static LatLng resolveMapCenter({
    required List<Station> filteredStations,
    required List<Station> allStations,
  }) {
    if (filteredStations.isNotEmpty) {
      return LatLng(
        filteredStations.first.latitude,
        filteredStations.first.longitude,
      );
    }

    if (allStations.isNotEmpty) {
      return LatLng(allStations.first.latitude, allStations.first.longitude);
    }

    return _fallbackCenter;
  }
}

class MapView extends StatefulWidget {
  final List<Station> stations;
  final void Function(BuildContext context, Station station)? onStationTap;

  const MapView({super.key, required this.stations, this.onStationTap});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  MapFilterState _filterState = const MapFilterState();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Station> _filteredStations() {
    return MapViewPresenter.filterStations(widget.stations, _filterState);
  }

  LatLng _resolveMapCenter(List<Station> filteredStations) {
    return MapViewPresenter.resolveMapCenter(
      filteredStations: filteredStations,
      allStations: widget.stations,
    );
  }

  void _handleStationTap(Station station) {
    final onStationTap = widget.onStationTap;

    if (onStationTap != null) {
      onStationTap(context, station);
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => StationDetailScreen(station: station)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredStations = _filteredStations();
    final mapCenter = _resolveMapCenter(filteredStations);

    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(initialCenter: mapCenter, initialZoom: 13),
            children: [
              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
                userAgentPackageName: 'com.velo.toulouse.app',
              ),
              MarkerLayer(
                markers: filteredStations.map((station) {
                  final availableBikes = MapViewPresenter.availableBikeCount(
                    station,
                  );
                  final hasAnyBikes = availableBikes > 0;

                  return Marker(
                    point: LatLng(station.latitude, station.longitude),
                    width: 56,
                    height: 56,
                    child: GestureDetector(
                      onTap: () => _handleStationTap(station),
                      child: _StationMarker(
                        availableBikes: availableBikes,
                        hasAnyBikes: hasAnyBikes,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          Positioned(
            top: 12,
            left: 12,
            right: 12,
            child: SafeArea(
              child: Column(
                children: [
                  Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(8),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _filterState = _filterState.copyWith(
                            searchText: value,
                          );
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search station',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 16,
            bottom: 88,
            child: SafeArea(
              child: Material(
                color: Colors.white,
                shape: const CircleBorder(),
                elevation: 5,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () {
                    _mapController.move(mapCenter, 14);
                  },
                  child: const SizedBox(
                    width: 54,
                    height: 54,
                    child: Icon(
                      Icons.my_location,
                      color: Color(0xFF111111),
                      size: 26,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StationMarker extends StatelessWidget {
  final int availableBikes;
  final bool hasAnyBikes;

  const _StationMarker({
    required this.availableBikes,
    required this.hasAnyBikes,
  });

  @override
  Widget build(BuildContext context) {
    final markerColor = hasAnyBikes
        ? const Color(0xFFFF7B2C)
        : const Color(0xFF8C6A4A);

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: markerColor,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: hasAnyBikes
                ? const [
                    BoxShadow(
                      color: Color(0x66FF7B2C),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              '$availableBikes',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 2,
          child: Icon(Icons.place, size: 16, color: markerColor),
        ),
      ],
    );
  }
}
