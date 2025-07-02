import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Image.asset(
                'images/logo-damkar.png', // Ganti dengan logo sesuai kebutuhan
                height: 120,
              ),
              const SizedBox(height: 20),
              const Text(
                'Silahkan isi nomor telepon terdaftar',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: '+62-896-3586-7110',
                  border: const UnderlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // TODO: handle login
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text('Masuk'),
              ),
              const SizedBox(height: 10),
              const Text('atau'),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                icon: const Icon(Icons.g_mobiledata),
                label: const Text('Masuk dengan google'),
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
              ),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                icon: const Icon(FontAwesomeIcons.facebookF),
                label: const Text('Masuk dengan facebook'),
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(
                  top: 35.0,
                ), // Jarak dari elemen atas
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Belum punya akun? ",
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    GestureDetector(
                      onTap: () {
                        // TODO: Arahkan ke Register Screen
                        //Navigator.push(
                          //context,
                          //MaterialPageRoute(
                            //builder: (context) => registerScreen(),
                          //),
                        //);
                      },
                      child: const Text(
                        "Daftar",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
