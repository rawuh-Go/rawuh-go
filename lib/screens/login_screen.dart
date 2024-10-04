import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart'; // Import MainScreen

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isOpen = true;
  bool isRememberMeChecked = false;

  @override
  Widget build(BuildContext context) {
    // Mengambil ukuran layar
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Menyesuaikan ukuran font dan padding berdasarkan ukuran layar
    double titleFontSize = screenWidth * 0.08; // Menyesuaikan ukuran judul
    double fieldWidth = screenWidth * 0.8; // Menyesuaikan lebar text field
    double buttonHeight =
        screenHeight * 0.07; // Menyesuaikan tinggi tombol login


    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.1), // Responsif padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo or image in the center
                Center(
                  child: Image.asset("assets/img/loginScreen/login_page.png"),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                // Title
                Text(
                  "Login",
                  style: GoogleFonts.poppins(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                // Username text field
                Container(
                  width: fieldWidth,
                  height: screenHeight * 0.07,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    cursorColor: Color(0xFF2A5867),
                    decoration: InputDecoration(
                      hintText: "username",
                      hintStyle: GoogleFonts.mulish(
                          fontSize: 16, fontWeight: FontWeight.w400),
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/img/icons/form1.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                // Password text field
                Container(
                  width: fieldWidth,
                  height: screenHeight * 0.07,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    obscureText: isOpen,
                    cursorColor: Color(0xFF2A5867),
                    decoration: InputDecoration(
                      hintText: "password",
                      hintStyle: GoogleFonts.mulish(
                          fontSize: 16, fontWeight: FontWeight.w400),
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      border: InputBorder.none,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/img/icons/form2.png',
                          width: 20,
                          height: 20,
                        ),
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            isOpen = !isOpen;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: isOpen
                              ? Icon(Icons.visibility_off_outlined)
                              : Icon(Icons.remove_red_eye_outlined),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                // Remember me checkbox
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "remember me",
                      style: GoogleFonts.poppins(
                          fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                    Checkbox(
                      value: isRememberMeChecked,
                      onChanged: (value) {
                        setState(() {
                          isRememberMeChecked = value ?? false;
                        });
                      },
                      activeColor: Color(0xFF2A5867),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                // Login button
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => MainScreen()),
                    );
                  },
                  child: Container(
                    height: buttonHeight,
                    width: fieldWidth,
                    decoration: BoxDecoration(
                      color: Color(0xFF2A5867),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "Login",
                        style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                // Forgot password and contact admin row
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "forgot password?",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "contact admin",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
