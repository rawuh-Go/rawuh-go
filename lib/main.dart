import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'screens/assigment_screen.dart';
import 'screens/camera_screen.dart';
import 'screens/change_password.dart';
import 'screens/history_screen.dart';
import 'screens/home_screen.dart';
import 'screens/leave_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/todolist_screen.dart';
import 'widget/bottom_nav_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rawuh-Go App',
      home: SplashScreen(),
      routes: {
        '/home': (context) => MainScreen(selectedIndex: 0),
        '/history': (context) =>
            HistoryScreen(), // Tambahkan route untuk HistoryScreen
        '/camera': (context) => CameraScreen(),
        '/todolist-screen': (context) => TodolistScreen(),
        '/profile': (context) => ProfileScreen(),
        '/change-password': (context) => ChangePasswordScreen(),
        '/leave-screen': (context) =>
            LeaveScreen(), // Tambahkan route leave-screen
        '/assigment-screen': (context) => AssignmentScreen(),

        // Tambahkan route assignment-screen
      }, // Start with the SplashScreen
    );
  }
}

class MainScreen extends StatefulWidget {
  final int selectedIndex; // Define the selectedIndex property

  const MainScreen({Key? key, required this.selectedIndex}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _selectedIndex;

  final List<Widget> _pages = [
    HomeScreen(),
    HistoryScreen(),
    CameraScreen(),
    TodolistScreen(),
    ProfileScreen(),
  ];
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(
            bottom: 2), // Adjust bottom margin if necessary
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Shadow color
              spreadRadius: 1, // Spread radius
              blurRadius: 20, // Blur radius
              offset: const Offset(0, 5), // Shadow offset
            ),
          ],
        ),
        child: ClipOval(
          child: Material(
            color: const Color(0xFF2A5867), // Floating action button color
            elevation:
                0, // Elevation inside the button is 0 because we are handling shadow via the Container
            child: InkWell(
              onTap: () async {
                // Menambahkan async karena kita menggunakan await

                // Meminta izin kamera
                PermissionStatus cameraStatus =
                    await Permission.camera.request();

                if (cameraStatus.isGranted) {
                  // Jika izin kamera diberikan, meminta izin lokasi
                  PermissionStatus locationStatus =
                      await Permission.location.request();

                  if (locationStatus.isGranted) {
                    // Jika izin lokasi diberikan, arahkan ke CameraScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CameraScreen(),
                      ),
                    );
                  } else {
                    // Tampilkan pesan jika izin lokasi ditolak
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Izin lokasi diperlukan untuk melanjutkan'),
                      ),
                    );
                  }
                } else {
                  // Tampilkan pesan jika izin kamera ditolak
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Izin kamera diperlukan untuk melanjutkan'),
                    ),
                  );
                }
              },
              child: const SizedBox(
                width: 56,
                height: 56,
                child: Icon(
                  Icons.camera_alt,
                  size: 28,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
