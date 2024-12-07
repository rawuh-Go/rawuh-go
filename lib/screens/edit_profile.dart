import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_rawuhgo/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  final int userId;
  const EditProfileScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  UserModel? userProfile;
  bool isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId =
        prefs.getInt('user_id'); // Ambil user_id dari SharedPreferences

    if (userId == null) {
      print("User not logged in or user_id not found.");
      return;
    }

    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/users/$userId'));

    if (response.statusCode == 200) {
      setState(() {
        userProfile = UserModel.fromJson(json.decode(response.body));
        isLoading = false; // Set loading ke false setelah data diambil
      });
    } else {
      print("Failed to fetch user profile: ${response.statusCode}");
      setState(() {
        isLoading = false; // Set loading ke false saat terjadi error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.95),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                // Back button with "Profile" text
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        splashColor: Colors.grey.withOpacity(0.3),
                        highlightColor: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Edit Profile',
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

                const SizedBox(height: 20),

                // Profile Picture with Edit Icon
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: userProfile?.image != null
                          ? NetworkImage(userProfile!.image!)
                          : const AssetImage(
                                  'assets/img/main_page/user_avatar.png')
                              as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: const Color(0xFF212A2E),
                        radius: 16,
                        child: const Icon(
                          Icons.edit,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Profile Information
                isLoading
                    ? const CircularProgressIndicator() // Loader saat data belum tersedia
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ProfileDetail(
                              label: 'Name', value: userProfile!.name),
                          ProfileDetail(
                              label: 'Email', value: userProfile!.email),
                          ProfileDetail(
                              label: 'Gender', value: userProfile!.gender),
                          ProfileDetail(
                              label: 'Address', value: userProfile!.address),
                          ProfileDetail(
                              label: 'Phone', value: userProfile!.phoneNumber),
                          ProfileDetail(
                              label: 'Country', value: userProfile!.country),
                          ProfileDetail(
                              label: 'Job Position',
                              value: userProfile!.jobPosition),
                          ProfileDetail(
                              label: 'Created At',
                              value: userProfile!.createdAt),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget untuk menampilkan detail profil
class ProfileDetail extends StatelessWidget {
  final String label;
  final String value;

  const ProfileDetail({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label:',
            style: GoogleFonts.dmSans(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.dmSans(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
