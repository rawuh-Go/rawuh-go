import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class AssigmentScreen extends StatefulWidget {
  @override
  State<AssigmentScreen> createState() => _AssigmentScreenState();
}

class _AssigmentScreenState extends State<AssigmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 0.95),
        body: SafeArea(
            child: Column(children: [
          // AppBar section with back button and leaveType
          Padding(
            padding: const EdgeInsets.only(
                top: 30, left: 16, right: 30), //jarak atas
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MainScreen()),
                    );
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                Text(
                  'Assigment',
                  style: GoogleFonts.dmSans(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 40), // Empty space for alignment
              ],
            ),
          ),
        ])));
  }
}
