import 'package:flutter/material.dart';
import '../widgets/map.dart';
import 'emergency_call_screen.dart';
import 'education_screen.dart';
import 'profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 0;
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
  String _currentArea = 'Jakarta';

  final List<Map<String, dynamic>> _newsData = [
    {
      'title':
          'Damkar Jakarta Berhasil Padamkan Kebakaran di Gedung Perkantoran',
      'summary':
          'Tim pemadam kebakaran berhasil memadamkan api dalam waktu 2 jam tanpa korban jiwa.',
      'date': '15 Januari 2024',
      'image': 'assets/images/Fire_Truck.jpeg',
      'category': 'Berita Utama',
    },
    {
      'title': 'Pelatihan Pencegahan Kebakaran untuk Warga Jakarta Selatan',
      'summary':
          'Program edukasi pencegahan kebakaran dilaksanakan di 10 kelurahan.',
      'date': '12 Januari 2024',
      'image': 'assets/images/rescue_car.png',
      'category': 'Edukasi',
    },
    {
      'title': 'Damkar Tambah 5 Unit Mobil Pemadam Baru',
      'summary':
          'Penambahan armada untuk meningkatkan pelayanan darurat di wilayah Jakarta.',
      'date': '10 Januari 2024',
      'image': 'assets/images/water_tanker.jpeg',
      'category': 'Pengadaan',
    },
  ];

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EmergencyCallScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Education()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Profile()),
        );
        break;
    }
  }

  Widget _buildNewsSection() {
    return Column(
      children: [
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _newsData.length,
            itemBuilder: (context, index) {
              final news = _newsData[index];
              return Container(
                width: 280,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: Image.asset(
                        news['image'],
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 100,
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.image_not_supported,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                // ignore: deprecated_member_use
                                color: const Color(0xFFE53E3E).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                news['category'],
                                style: const TextStyle(
                                  color: Color(0xFFE53E3E),
                                  fontSize: 9,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            // Title
                            Text(
                              news['title'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Color(0xFF3F3D56),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 3),
                            Expanded(
                              child: Text(
                                news['summary'],
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 11,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            // Date
                            Text(
                              news['date'],
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Fitur berita lengkap akan segera hadir!'),
                  backgroundColor: Color(0xFFE53E3E),
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFE53E3E)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: const Text(
              'Lihat Semua Berita',
              style: TextStyle(
                color: Color(0xFFE53E3E),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
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
                              const Icon(
                                Icons.local_fire_department,
                                color: Colors.redAccent,
                              ),
                              const SizedBox(width: 12),
                              Expanded(child: Text(station)),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
              const SizedBox(height: 12),
              OSMMapWidget(onLocationChanged: _onLocationChanged),
              const SizedBox(height: 24),
              const Text(
                'Berita Terkini Pemadam Kebakaran',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3F3D56),
                ),
              ),
              const SizedBox(height: 16),
              _buildNewsSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFFE53E3E),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(
            icon: Icon(Icons.emergency),
            label: 'Darurat',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Edukasi'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
