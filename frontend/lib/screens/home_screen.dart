import 'package:flutter/material.dart';
import '../widgets/map.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _allStations = [
    'Pos Damkar Papanggo',
    'Pos Damkar Podomoro',
    'Pos Damkar Gaya Motor',
    'Pos Damkar Walikota',
    'Pos Damkar Danau Sunter',
    'Pos Damkar Tanah Abang',
    'Pos Damkar Menteng',
    'Pos Damkar Senen',
    'Pos Damkar Kemayoran',
    'Pos Damkar Pancoran',
    'Pos Damkar Tebet',
    'Pos Damkar Pasar Minggu',
    'Pos Damkar Mampang',
    'Pos Damkar Kebayoran Baru',
    'Pos Damkar Grogol Petamburan',
    'Pos Damkar Taman Sari',
    'Pos Damkar Tambora',
    'Pos Damkar Matraman',
    'Pos Damkar Pulogadung',
    'Pos Damkar Jatinegara',
  ];
  List<String> _filteredStations = [];
  // late LocationData _currentLocation; // Unused field
  String _currentArea = 'Jakarta'; // Default area

  void _getCurrentLocation() async {
    // final Location location = Location();
    try {
      // _currentLocation = await location.getLocation();
      // Peta akan otomatis menampilkan lokasi user karena trackMyPosition: true
    } catch (e) {
      // print("Error getting location: $e");
    }
  }

  void _onLocationChanged(String areaName) {
    setState(() {
      _currentArea = areaName;
    });
  }

  void _filterStations() {
    final keyword = _searchController.text.toLowerCase();
    setState(() {
      if (keyword.isEmpty) {
        _filteredStations = List.from(_allStations);
      } else {
        _filteredStations = _allStations
            .where((station) => station.toLowerCase().contains(keyword))
            .toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _filteredStations = List.from(_allStations);
    _searchController.addListener(_filterStations);
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on_outlined, color: Colors.black),
                const SizedBox(width: 8),
                Text(
                  'Rayla, $_currentArea',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'KAMI SIAP MEMBANTU',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Color(0xFF3F3D56),
              ),
            ),
            const SizedBox(height: 4),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Lokasi Damkar terdekat",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Lokasi langsung',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Color(0xFF3F3D56),
              ),
            ),
            const SizedBox(height: 12),
            _searchController.text.isEmpty
                ? const SizedBox.shrink()
                : _filteredStations.isEmpty
                    ? const Text(
                        'Tidak ditemukan.',
                        style: TextStyle(color: Colors.redAccent),
                      )
                    : Column(
                        children: _filteredStations.map((station) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.local_fire_department, color: Colors.redAccent),
                                const SizedBox(width: 12),
                                Expanded(child: Text(station)),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
            const SizedBox(height: 12),
            OSMMapWidget(onLocationChanged: _onLocationChanged),
            // ... [Rekomendasi Edukasi] ...
          ],
        ),
      ),
    );
  }
}