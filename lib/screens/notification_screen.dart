import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_rawuhgo/screens/history_screen.dart';
import 'package:mobile_rawuhgo/screens/mainpage.dart';
import 'package:mobile_rawuhgo/screens/profile_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = '/notification-screen';

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int _selectedIndex = 2; // Set the initial index to 2 for NotificationScreen

  final List<Widget> _screens = [
    Mainpage(),
    HistoryScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index != 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => _screens[index],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.95),
      body: SafeArea(
        child: Column(
          children: [
            // Back button dengan teks Notification
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 16, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    splashColor:
                        Colors.grey.withOpacity(0.3), // Efek splash abu-abu
                    highlightColor: Colors.grey
                        .withOpacity(0.2), // Warna abu-abu ketika ditekan
                    borderRadius: BorderRadius.circular(
                        10), // Menambahkan sedikit radius untuk tampilan lebih halus
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                        SizedBox(width: 1), // Jarak antara ikon dan teks
                        Text(
                          'Back',
                          style: GoogleFonts.dmSans(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Notifications',
                    style: GoogleFonts.dmSans(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            const SizedBox(height: 60),

            // Content for Notifications
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: 10, // Example item count
            //     itemBuilder: (context, index) {
            //       return ListTile(
            //         title: Text('Notification ${index + 1}'),
            //         subtitle: Text('Details of notification ${index + 1}'),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Meminta izin kamera
          PermissionStatus cameraStatus = await Permission.camera.request();
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
                    content: Text('Izin lokasi diperlukan untuk melanjutkan')),
              );
            }
          } else {
            // Tampilkan pesan jika izin kamera ditolak
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Izin kamera diperlukan untuk melanjutkan')),
            );
          }
        },
        backgroundColor: const Color(0xFFFEC922),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        child: const Icon(
          Icons.camera_alt,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildIconButton(0, Icons.home),
            _buildIconButton(1, Icons.access_time),
            const SizedBox(width: 48), // Space for the FloatingActionButton
            _buildIconButton(2, Icons.notifications),
            _buildIconButton(3, Icons.person),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(int index, IconData icon) {
    return IconButton(
      onPressed: () {
        _onItemTapped(index);
      },
      icon: Icon(
        icon,
        color: _selectedIndex == index ? Colors.amber : Colors.grey,
      ),
    );
  }
}

class CameraScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Screen'),
      ),
      body: const Center(
        child: Text('Ini adalah layar kamera'),
      ),
    );
  }
}
