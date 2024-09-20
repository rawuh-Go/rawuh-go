import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/edit-profile';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _phone = '';
  String _position = '';
  String _country = 'Indonesia';
  String _gender = 'Male';
  String _address = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
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
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon:
                                Icon(Icons.arrow_back_ios, color: Colors.black),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Text(
                            'Back',
                            style: GoogleFonts.dmSans(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Edit Profile',
                        style: GoogleFonts.dmSans(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 48), // Placeholder to balance the Row
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // Profile Picture with Edit Icon
                const Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(
                          'assets/img/main_page/user_avatar.png'), // Replace with actual profile image
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.yellow,
                        radius: 16,
                        child: Icon(
                          Icons.edit,
                          size: 18,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // Form fields
                _buildTextField('Full name', 'Riky Raharjo'),
                _buildTextField('Position', 'Software Development'),
                _buildTextField('Email', 'rikyraharjo12@domain.com'),
                _buildTextField('Phone number', '0883-456-7890', isPhone: true),

                Row(
                  children: [
                    Expanded(
                      child: _buildDropdownField(
                          'Country', ['Indonesia'], _country),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _buildDropdownField(
                          'Genre', ['Male', 'Female'], _gender),
                    ),
                  ],
                ),

                _buildTextField(
                    'Address', 'jl. Yos Sudarso no 98, Jakarta Selatan'),

                SizedBox(height: 30),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _showSaveDialog(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.amber, // Yellow color as per image
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'SAVE',
                      style: GoogleFonts.dmSans(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String initialValue,
      {bool isPhone = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.dmSans(
            fontSize: 14,
            color: Colors.grey[600],
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: const Color(0xFFF3F8FF),
        ),
        keyboardType: isPhone ? TextInputType.phone : TextInputType.text,
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> options, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.dmSans(
            fontSize: 14,
            color: Colors.grey[600],
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: const Color(0xFFF3F8FF),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            onChanged: (newValue) {
              setState(() {
                if (label == 'Country') _country = newValue!;
                if (label == 'Genre') _gender = newValue!;
              });
            },
            items: options.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  void _showSaveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            'Save Changes',
            style: GoogleFonts.dmSans(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          content: Text(
            'Are you sure you want to save these changes?',
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
                // Perform save action here
                Navigator.of(context).pop(); // Close the dialog after saving
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
