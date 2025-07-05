import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/education_screen.dart';
import 'screens/profile.dart';
import 'screens/home_screen.dart';
import 'screens/unit_screen.dart';
import 'widgets/bottomBar.dart';

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
        '/main': (context) => MainScaffold(),
      },
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});
  
  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Home(),
    UnitScreen(),
    Education(),
    Profile(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
      body: _pages[_selectedIndex],
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: _onTabTapped,
        onEmergencyPressed: _onEmergencyPressed,
      ),
    );
  }
}
