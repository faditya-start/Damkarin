import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'emergency_call_screen.dart';
import 'profile.dart';

class Education extends StatefulWidget {
  const Education({super.key});

  @override
  State<Education> createState() => _EducationState();
}

class _EducationState extends State<Education> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    Widget destination;
    switch (index) {
      case 0:
        Navigator.pop(context);
        return;
      case 1:
        destination = const EmergencyCallScreen();
        break;
      case 3:
        destination = const Profile();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => destination),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edukasi',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFE53E3E),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
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
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: "Mau baca apa hari ini?",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _chipItem("Tersimpan (2)"),
                  const SizedBox(width: 8),
                  _chipItem("Riwayat (3)"),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Artikel',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    buildArticleCard('images/1.jpeg'),
                    const SizedBox(width: 8),
                    buildArticleCard('images/2.jpeg'),
                    const SizedBox(width: 8),
                    buildArticleCard('images/3.jpeg'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Fakta Unik',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              faktaItem('Alat pemadam api ada beberapa jenis'),
              faktaItem('Warna api menunjukkan suhu yang berbeda'),
              faktaItem('Asap lebih mematikan daripada api'),
              const SizedBox(height: 16),
              const Text(
                'Tutorial',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              tutorialItem(
                "Cara Menggunakan Alat Pemadam Api yang Benar",
                "https://img.youtube.com/vi/x5Rjjlrw0ao/hqdefault.jpg",
                "https://youtu.be/x5Rjjlrw0ao",
              ),
              const SizedBox(height: 12),
              tutorialItem(
                "Apa yang Harus Kita Lakukan Saat Terjadi Kebakaran",
                "https://img.youtube.com/vi/NihNPyDagKE/hqdefault.jpg",
                "https://youtu.be/NihNPyDagKE",
              ),
              const SizedBox(height: 12),
              tutorialItem(
                "Penanggulangan Kebakaran Menggunakan Alat Tradisional",
                "https://img.youtube.com/vi/pJGq9nAiBrE/hqdefault.jpg",
                "https://youtu.be/pJGq9nAiBrE",
              ),
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

  Widget _chipItem(String label) {
    return SizedBox(
      width: 130,
      child: Chip(
        label: Center(
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ),
        backgroundColor: const Color(0xFFD9D9D9),
      ),
    );
  }

  Widget buildArticleCard(String imagePath) {
    return SizedBox(
      width: 230,
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: const Color(0xFFF8F8F8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                imagePath,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: const [
                    Expanded(
                      child: Text(
                        "Tips Pencegahan Kebakaran",
                        style: TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(Icons.bookmark_border, size: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget faktaItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.info_outline, size: 24),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget tutorialItem(String title, String imageUrl, String youtubeUrl) {
    return GestureDetector(
      onTap: () async {
        final Uri url = Uri.parse(youtubeUrl);
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Tidak bisa membuka link')));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.grey[100],
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              child: Image.network(
                imageUrl,
                height: 70,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
