import 'package:flutter/material.dart';
import '../screens/home_screen.dart';

class OtpDialog extends StatefulWidget {
  const OtpDialog({super.key});

  @override
  State<OtpDialog> createState() => _OtpDialogState();
}

class _OtpDialogState extends State<OtpDialog> {
  final List<TextEditingController> _otpControllers =
      List.generate(4, (_) => TextEditingController());

  void _checkOtpAndNavigate() {
    final otp = _otpControllers.map((c) => c.text).join();
    if (otp.length == 4) {
      Navigator.pop(context); // Tutup dialog
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Kode OTP", style: TextStyle(color: Colors.red)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "4 digit kode dikirim via SMS atau WhatsApp",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(4, (index) {
              return SizedBox(
                width: 40,
                child: TextField(
                  controller: _otpControllers[index],
                  maxLength: 1,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  onChanged: (_) => _checkOtpAndNavigate(),
                  decoration: const InputDecoration(counterText: ''),
                ),
              );
            }),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {
              // TODO: implement Kirim Ulang OTP
            },
            child: const Text("Kirim ulang"),
          ),
        ],
      ),
    );
  }
}
