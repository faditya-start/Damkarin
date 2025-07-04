import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditAkunPageState createState() => _EditAkunPageState();
}

class _EditAkunPageState extends State<EditProfile> {
  bool notifikasi = true;

  final TextEditingController namaController =
      TextEditingController(text: 'Rayla Thoriq');
  final TextEditingController hpController =
      TextEditingController(text: '+62-896-3586-7110');
  final TextEditingController emailController =
      TextEditingController(text: 'Railal123@gmail.com');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: 140,
              width: double.infinity,
              color: Color(0xFF302E96),
              padding: EdgeInsets.only(top: 20, left: 8, right: 16),
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    'Informasi Akun',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            Transform.translate(
              offset: Offset(0, -40),
              child: Center(
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
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Color(0xFFFFFFFF),
                        child: Icon(
                          Icons.person,
                          size: 80,
                          color: Color(0xFFCBC2C2),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.edit, size: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // Nama
                  const Text('Nama Pengguna'),
                  const SizedBox(height: 6),
                  TextField(
                    controller: namaController,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 12),

                  // Nomor HP
                  const Text('Nomor HP'),
                  const SizedBox(height: 6),
                  TextField(
                    controller: hpController,
                    keyboardType: TextInputType.phone,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 12),

                  // Email
                  const Text('Email'),
                  const SizedBox(height: 6),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration:
                        const InputDecoration(border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 20),

                  // Notifikasi
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Notifikasi',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Terima notifikasi terbaru'),
                        ],
                      ),
                      Switch(
                        value: notifikasi,
                        onChanged: (v) => setState(() => notifikasi = v),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Bahasa
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Bahasa',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Indonesia'),
                        ],
                      ),
                      const Text('Default'),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Tombol Simpan
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final nama = namaController.text;
                        final hp = hpController.text;
                        final email = emailController.text;

                        print('Nama: $nama');
                        print('Nomor HP: $hp');
                        print('Email: $email');
                        print('Notifikasi: ${notifikasi ? "Aktif" : "Nonaktif"}');

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Perubahan berhasil disimpan'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        minimumSize: const Size.fromHeight(48),
                      ),
                      child: const Text(
                        'Simpan perubahan',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
