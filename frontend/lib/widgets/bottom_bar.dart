import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;
  final VoidCallback onEmergencyPressed;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
    required this.onEmergencyPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          // Background navbar
          Container(
            height: 80,
            decoration: const BoxDecoration(
              color: Color(0xFF002E6D),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navItem(Icons.home, "Beranda", 0),
                _navItem(Icons.fire_truck, "Unit", 1),
                const SizedBox(width: 60), 
                _navItem(Icons.menu_book, "Edukasi", 2),
                _navItem(Icons.person, "Akun", 3),
              ],
            ),
          ),

          Positioned(
            top: -30,
            child: FloatingActionButton(
              onPressed: onEmergencyPressed,
              backgroundColor: Colors.red,
              elevation: 8,
              shape: const CircleBorder(),
              child: const Icon(Icons.phone, size: 28, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isSelected ? Colors.red : Colors.white),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.red : Colors.white,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
