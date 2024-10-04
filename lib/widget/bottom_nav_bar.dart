import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildNavBarItem(
              'assets/img/main_page/home.png', 0), // Gambar dari assets
          buildNavBarItem(Icons.access_time, 1), // Icon
          const SizedBox(width: 20), // Space for the floating action button
          buildNavBarItem(Icons.list_rounded, 3), // Icon
          buildNavBarItem(Icons.person, 4), // Icon
        ],
      ),
    );
  }

  // Build item in bottom navigation bar
  Widget buildNavBarItem(dynamic iconOrImage, int index) {
    return ClipOval(
      child: Material(
        color: Colors.transparent, // Background transparent to show ripple only
        child: InkWell(
          onTap: () => onItemTapped(index),
          child: Padding(
            padding: const EdgeInsets.all(8.0), // Adjust padding if necessary
            child: iconOrImage is IconData
                ? Icon(
                    iconOrImage,
                    size: 30, // Atur ukuran ikon sesuai kebutuhan
                    color: selectedIndex == index
                        ? const Color(0xFF2A5867)
                        : Colors.grey,
                  )
                : Image.asset(
                    iconOrImage, // Path gambar dari assets
                    height: 25, // Ukuran gambar
                    width: 25, // Ukuran gambar
                    color: selectedIndex == index
                        ? const Color(0xFF2A5867)
                        : Colors.grey, // Warna gambar jika dipilih
                  ),
          ),
        ),
      ),
    );
  }
}
