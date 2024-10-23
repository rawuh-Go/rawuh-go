import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'change_password.dart';
import 'edit_profile.dart';
import 'login_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userName = '';
  String jobPosition = '';

  void initState() {
    super.initState();
    _loadUserData();
  }

  // Fungsi untuk mengambil data user dari SharedPreferences
  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userData = prefs.getString('user_data');

    if (userData != null) {
      var user = jsonDecode(userData);
      setState(() {
        userName = user['name'] ?? 'User Name';
        jobPosition = user['job_position'] ?? 'Job Position';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.50),
      body: SafeArea(
        child: Column(
          children: [
            // Back button dengan teks Profile
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 16, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainScreen(
                                selectedIndex:
                                    0)), // Provide a default index or the desired index
                      );
                    },

                    splashColor:
                        Colors.grey.withOpacity(0.3), // Efek splash abu-abu
                    highlightColor: Colors.grey
                        .withOpacity(0.2), // Warna abu-abu ketika ditekan
                    borderRadius: BorderRadius.circular(
                        10), // Menambahkan sedikit radius untuk tampilan lebih halus
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Profile',
                    style: GoogleFonts.dmSans(
                      color: Colors.black,
                      fontSize: 18,
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
              clipBehavior: Clip.none,
              children: [
                // Box untuk profil
                Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                    color: const Color(0xFF212A2E),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        '$userName',
                        style: GoogleFonts.dmSans(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '$jobPosition',
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
                  left: (MediaQuery.of(context).size.width / 2) - 60,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2, // Border putih di sekeliling foto
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 25,
                      backgroundImage:
                          AssetImage('assets/img/main_page/user_avatar.png'),
                    ),
                  ),
                ),

                // Kotak hijau untuk status dan office hours berada setengah di dalam dan setengah di luar
                Positioned(
                  bottom: -10, // Membuat kotak sebagian keluar dari box profil
                  left: (MediaQuery.of(context).size.width *
                      0.05), // Menempatkan kotak di dalam margin yang sesuai
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A5867),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Status:',
                              style: GoogleFonts.dmSans(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'WFA',
                              style: GoogleFonts.dmSans(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'office hours:',
                              style: GoogleFonts.dmSans(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '08:00 - 16:00',
                              style: GoogleFonts.dmSans(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Jarak antara box profil dan menu di bawahnya
            const SizedBox(height: 0.02),
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
    );
  }

  Widget buildMenuItem(
      BuildContext context, IconData icon, String text, Widget destination) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFFF1F3F6),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(icon, color: const Color(0xFF2A5867)),
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

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white, // Set background color to white
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Rounded corners
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
                  color: const Color(0xFF2A5867), // Yellow color as per image
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
