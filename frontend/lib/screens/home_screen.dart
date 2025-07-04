import 'package:flutter/material.dart';
import 'package:frontend/widgets/bottomBar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final TextEditingController _searchController = TextEditingController();

  List<String> _allStations = [
    'Damkar Pancoran',
    'Damkar Tebet',
    'Damkar Pasar Minggu',
    'Damkar Mampang',
    'Damkar Tanjung Priok',
    'Damkar Tanah Abang',
    'Damkar Kemayoran',
    'Damkar Kebayoran Baru',
  ];

  List<String> _filteredStations = [];

  @override
  void initState() {
    super.initState();
    _filteredStations = List.from(_allStations);
    _searchController.addListener(_filterStations);
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
void dispose() {
  _searchController.dispose();
  super.dispose();
}




  int _currentIndex = 0;

  void _onTabTapped(int index) {
    if (index != _currentIndex) {
      switch (index) {
        case 1:
          Navigator.pushReplacementNamed(context, '/unit');
          break;
        case 2:
          Navigator.pushReplacementNamed(context, '/education');
          break;
        case 3:
          Navigator.pushReplacementNamed(context, '/profile');
          break;
      }
    }
  }

  void _onEmergencyPressed() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Darurat'),
        content: const Text('Menghubungi 112...'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
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

                  
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'MAP',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),

                  
                  SizedBox(height: 16),

                  const Text(
                    'Rekomendasi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3F3D56),
                    ),
                  ),
                  const SizedBox(height: 12),

                  
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Color(0xFFF8F8F8),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'images/1.jpeg',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: const Text('Artikel Edukasi'),
                      subtitle: const Text('Kenali cara mencegah kebakaran!'),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.pushNamed(context, '/education');
                      },
                    ),
                  ),

                  
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF8F8F8),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'images/2.jpeg',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: const Text('Fakta Unik'),
                      subtitle: const Text('Api bukan satu-satunya ancaman'),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.pushNamed(context, '/education');
                      },
                    ),
                  ),

                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF8F8F8),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'images/tutorial.jpeg',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: const Text('Tutorial'),
                      subtitle: const Text('Langkah cepat dan aman saat api muncul'),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.pushNamed(context, '/education');
                      },
                    ),
                  ),

                  
                ],
              ),
            ),
          ),
          bottomNavigationBar: CustomBottomNavBar(
            selectedIndex: _currentIndex,
            onTap: _onTabTapped,
            onEmergencyPressed: _onEmergencyPressed,
          ),
        );
      }
    }
