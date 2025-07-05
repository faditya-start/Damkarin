import 'package:flutter/material.dart';
import 'package:frontend/screens/login_screen.dart';
import 'edit_profile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          children: [
            Container(
              color: const Color(0xFF302E96),
              height: 140,
              width: double.infinity,
              padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
              alignment: Alignment.topLeft,
              child: Row(
                children: const [
                  Icon(Icons.arrow_back, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    'Informasi Akun',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              transform: Matrix4.translationValues(0, -40, 0),
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 70,
                      backgroundColor: Color(0xFFFFFFFF),
                      child: Icon(
                        Icons.person,
                        size: 80,
                        color: Color(0xFFCBC2C2),
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.edit,
                        size: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              'Rayla Thoriq',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Data pribadi', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Expanded(child: Text('No. HP')),
                      Expanded(child: Text('+62-896-3586-7110')),
                    ],
                  ),
                  Row(
                    children: const [
                      Expanded(child: Text('Email')),
                      Expanded(child: Text('Railal123@gmail.com')),
                    ],
                  ),
                  Row(
                    children: const [
                      Expanded(child: Text('Alamat')),
                      Expanded(child: Text('Menteng Atas, Jakarta Selatan')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text('Pengaturan', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Expanded(child: Text('Bahasa')),
                      Expanded(child: Text('Indonesia')),
                    ],
                  ),
                  Row(
                    children: const [
                      Expanded(child: Text('Notifikasi')),
                      Expanded(child: Text('Hidup')),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: SizedBox(
                      width: 270,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EditProfile()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFBCBABD),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: const Text(
                          "Edit informasi akun",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: SizedBox(
                      width: 270,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Yakin ingin keluar dari akun anda?',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 24),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () => Navigator.pop(context),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black54,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                        ),
                                        child: const Text('Tidak', style: TextStyle(color: Colors.white)),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(builder: (context) => LoginScreen()),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                        ),
                                        child: const Text('Ya', style: TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF0F0F),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          minimumSize: const Size.fromHeight(48),
                        ),
                        child: const Text(
                          "Keluar Akun",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
