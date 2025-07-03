import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:frontend/widgets/bottomBar.dart';

class Education extends StatefulWidget {
  const Education({super.key});

  @override
  State<Education> createState() => _EducationState();
}

class _EducationState extends State<Education> {
  int _currentIndex = 2;

  void _onTabTapped(int index) {
    if (index != _currentIndex) {
      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, '/home');
          break;
        case 1:
          Navigator.pushReplacementNamed(context, '/unit');
          break;
        case 3:
          Navigator.pushReplacementNamed(context, '/profile');
          break;
      }
    }
  }

  void _showEmergencyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Panggilan Darurat"),
          content: const Text("Hubungi 112 sekarang?"),
          actions: [
            TextButton(
              child: const Text("Tidak"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: const Text("Ya"),
              onPressed: () async {
                Navigator.of(context).pop();
                final Uri url = Uri.parse("tel:112");
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                }
              },
            ),
          ],
        );
      },
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
                  Text('Rayla, Jakarta Selatan',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500))
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
              const Text('Artikel', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
              const Text('Fakta Unik', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              faktaItem('Alat pemadam api ada beberapa jenis'),
              faktaItem('Warna api menunjukkan suhu yang berbeda'),
              faktaItem('Asap lebih mematikan daripada api'),
              const SizedBox(height: 16),
              const Text('Tutorial', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              tutorialItem("Cara Menggunakan Alat Pemadam Api yang Benar",
                  "https://img.youtube.com/vi/x5Rjjlrw0ao/hqdefault.jpg",
                  "https://youtu.be/x5Rjjlrw0ao"),
              const SizedBox(height: 12),
              tutorialItem("Apa yang Harus Kita Lakukan Saat Terjadi Kebakaran",
                  "https://img.youtube.com/vi/NihNPyDagKE/hqdefault.jpg",
                  "https://youtu.be/NihNPyDagKE"),
              const SizedBox(height: 12),
              tutorialItem("Penanggulangan Kebakaran Menggunakan Alat Tradisional",
                  "https://img.youtube.com/vi/pJGq9nAiBrE/hqdefault.jpg",
                  "https://youtu.be/pJGq9nAiBrE"),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _currentIndex,
        onTap: _onTabTapped,
        onEmergencyPressed: _showEmergencyDialog,
      ),
    );
  }

  Widget _chipItem(String label) {
    return SizedBox(
      width: 130,
      child: Chip(
        label: Center(
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.w800)),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(
                      child: Text(
                        "Tips Pencegahan Kebakaran",
                        style: TextStyle(fontWeight: FontWeight.bold),
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
          const Icon(Icons.search, size: 24),
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
          throw 'Could not launch $youtubeUrl';
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
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  const Positioned(
                    bottom: 8,
                    right: 8,
                    child: Icon(Icons.bookmark_border, size: 20),
                  ),
                ],
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
