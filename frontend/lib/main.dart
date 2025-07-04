import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/tracking_screen.dart';
import 'screens/education_screen.dart';
import 'screens/profile.dart';
import 'screens/home_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Damkarin',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Arial',
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/tracking': (context) => const TrackingScreen(),
        '/education': (context) => const Education(),
        '/profile': (context) => const Profile(),
        '/home': (context) => Home(),
        // '/unit': (context) => const Unit(),
      },
    );
  }
}
