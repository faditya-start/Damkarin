import 'package:flutter/material.dart';
import 'home_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _otpControllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: const [
                Icon(Icons.lock, color: Colors.red),
                SizedBox(width: 8),
                Text("Kode OTP", style: TextStyle(color: Colors.red)),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Gunakan kode berikut untuk verifikasi:",
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 8),
                Center(
                  child: Text(
                    "0814",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 4,
                    ),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        );
      }
    });
  }

  void _checkOtpAndNavigate() {
    try {
      final otp = _otpControllers.map((c) => c.text).join();
      if (otp.length == 4 && mounted) {
        // Tambahkan delay kecil untuk memastikan UI stabil
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted && context.mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          }
        });
      }
    } catch (e) {
      debugPrint('Navigation error: $e');
    }
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verifikasi OTP')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const Text(
              'Kode OTP',
              style: TextStyle(
                fontSize: 24,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              '4 digit kode verifikasi dikirimkan melalui SMS atau WhatsApp.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return SizedBox(
                  width: 50,
                  child: TextField(
                    controller: _otpControllers[index],
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    keyboardType: TextInputType.number,
                    onChanged: (_) => _checkOtpAndNavigate(),
                    decoration: const InputDecoration(
                      counterText: '',
                      enabledBorder: UnderlineInputBorder(),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // TODO: kirim ulang kode otp
              },
              child: const Text("Kirim ulang"),
            ),
          ],
        ),
      ),
    );
  }
}
