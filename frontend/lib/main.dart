import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/tracking_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Damkar',
      theme: ThemeData(primarySwatch: Colors.red),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/tracking': (context) => const TrackingScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}