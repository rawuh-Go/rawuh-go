import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const routeName = '/change-password';

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _changePassword() {
    if (_formKey.currentState!.validate()) {
      // Logika untuk mengubah kata sandi
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password changed successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
      body: SafeArea(
        child: Column(children: [
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
                      icon: Icon(Icons.arrow_back_ios, color: Colors.black),
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
                  'Edit Profile',
                  style: GoogleFonts.dmSans(
                    color: Colors.black,
                    fontSize: 18, // Adjust the font size as needed
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 48), // Placeholder to balance the Row
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
