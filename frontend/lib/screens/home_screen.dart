import 'package:flutter/material.dart';
import 'package:frontend/widgets/bottomBar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
              SizedBox(height: 24),
              Text('KAMI SIAP MEMBANTU',style: TextStyle(
               fontWeight: FontWeight.bold, fontSize: 24,color: Color(0xFF3F3D56) 
                ),
              ),
              const SizedBox(height: 4),
              TextField(
                decoration: InputDecoration(
                  hintText: "Lokasi Damkar terdekat",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
              SizedBox(height: 8,),
              Text('Lokasi langsung', style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF3F3D56)
              ),)
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
