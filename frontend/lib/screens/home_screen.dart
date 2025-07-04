import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../services/map_service.dart';
import '../widgets/bottomBar.dart';
import '../widgets/map.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final List<String> _allStations = [
      'Damkar Pancoran',
      'Damkar Tebet', 
      'Damkar Pasar Minggu',
      'Damkar Mampang',
      'Damkar Tanjung Priok',
      'Damkar Tanah Abang',
      'Damkar Kemayoran',
      'Damkar Kebayoran Baru',
    ];
  final List<String> _filteredStations = [];
  late LocationData currentUserLocation;

  @override
  void initState() {
    super.initState();
    _filteredStations.clear();
    _filteredStations.addAll(_allStations);
    _searchController.addListener(_filterStations);
    _getCurrentLocation(); // Ambil lokasi pengguna
  }

  void _getCurrentLocation() async {
    try {
      currentUserLocation = await LocationService().getCurrentLocation();
    } catch (e) {
      debugPrint("Error getting location: $e");
    }
  }

  void _filterStations() {
    final keyword = _searchController.text.toLowerCase();
    setState(() {
      _filteredStations.clear();
      if (keyword.isEmpty) {
        _filteredStations.addAll(_allStations);
      } else {
        _filteredStations.addAll(
          _allStations.where((station) => station.toLowerCase().contains(keyword)),
        );
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  final int _currentIndex = 0;
  void _onTabTapped(int index) {
    // Implementasi navigasi bawah
  }

  void _onEmergencyPressed() {
    // Tombol darurat
  }

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Lokasi
              Row(
                children: const [
                  Icon(Icons.location_on_outlined, color: Colors.black),
                  SizedBox(width: 8),
                  Text(
                    'Rayla, Jakarta Selatan',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Judul "KAMI SIAP MEMBANTU"
              const Text(
                'KAMI SIAP MEMBANTU',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Color(0xFF3F3D56),
                ),
              ),
              const SizedBox(height: 4),

              // Search Bar
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "Lokasi Damkar terdekat",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Daftar Lokasi Damkar
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

              // Integrasi Tracking Screen (Peta)
              const SizedBox(height: 12),
              MapWidget(),

              // Rekomendasi Edukasi
              const SizedBox(height: 16),
              const Text(
                'Rekomendasi',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3F3D56),
                ),
              ),
              // ... [Isi rekomendasi seperti di gambar]
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        onEmergencyPressed: _onEmergencyPressed,
        onTap: _onTabTapped,
        selectedIndex: _currentIndex,
      ),
    );
  }
}