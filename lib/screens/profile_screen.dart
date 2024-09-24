import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_rawuhgo/screens/change_password.dart';
import 'package:mobile_rawuhgo/screens/edit_profile.dart';
import 'package:mobile_rawuhgo/screens/history_screen.dart';
import 'package:mobile_rawuhgo/screens/login_screen.dart';
import 'package:mobile_rawuhgo/screens/mainpage.dart';
import 'package:mobile_rawuhgo/screens/notification_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile-screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 3; // Set the initial index to 3 for ProfileScreen

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
    if (index != 3) {
      // Hindari push ke ProfileScreen ketika sudah di ProfileScreen
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
            // Back button dengan teks Profile
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 16, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize
                        .min, // Ensures the Row takes up only as much space as needed
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios,
                            color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        'Back',
                        style: GoogleFonts.dmSans(
                          color: Colors.black,
                          fontSize: 15, // Adjust the font size as needed
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Profile',
                    style: GoogleFonts.dmSans(
                      color: Colors.black,
                      fontSize: 18, // Adjust the font size as needed
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 48), // Placeholder to balance the Row
                ],
              ),
            ),

            const SizedBox(
                height: 60), // Jarak antara header dan konten profile

            // Stack untuk foto profil dan box
            Stack(
              clipBehavior: Clip.none, // Supaya gambar di luar box terlihat
              children: [
                // Box untuk profil (ukuran 361 x 170)
                Container(
                  width: 361,
                  height: 160,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F8FF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                          height:
                              80), // Jarak di dalam box agar sesuai dengan foto di atasnya
                      // Nama dan Jabatan
                      Text(
                        'Riky Raharjo',
                        style: GoogleFonts.dmSans(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Software Development',
                        style: GoogleFonts.dmSans(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                // Gambar user yang berada di atas box
                Positioned(
                  top: -50, // Agar gambar berada di luar box
                  left: 110, // Mengatur posisi horizontal
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 5, // Border putih di sekeliling foto
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 65,
                      backgroundImage: AssetImage(
                          'assets/img/main_page/user_avatar.png'), // Gambar profil dari file yang diupload
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
                height: 1), // Jarak antara box profil dan menu di bawahnya

            // Menu Edit Profile, Change Password, Logout
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildMenuItem(context, Icons.person, 'Edit Profile',
                      EditProfileScreen()),
                  buildMenuItem(context, Icons.lock, 'Change Password',
                      ChangePasswordScreen()),
                  buildMenuItem(context, Icons.logout, 'Logout', LoginScreen()),
                ],
              ),
            ),
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

  Widget buildMenuItem(
      BuildContext context, IconData icon, String text, Widget destination) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFFF3F8FF),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.amber),
          title: Text(
            text,
            style:
                GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
          onTap: () {
            if (text == 'Logout') {
              _showLogoutDialog(context);
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => destination),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildIconButton(int index, IconData icon) {
    return IconButton(
      onPressed: () {
        _onItemTapped(index); // Refactor ke metode terpisah
      },
      icon: Icon(
        icon,
        color: _selectedIndex == index ? Colors.amber : Colors.grey,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            'Logout',
            style: GoogleFonts.dmSans(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: GoogleFonts.dmSans(fontSize: 14),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'No',
                style: GoogleFonts.dmSans(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                ); // Navigate to LoginScreen
              },
              child: Text(
                'Yes',
                style: GoogleFonts.dmSans(
                  color: Colors.amber, // Yellow color as per image
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
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
