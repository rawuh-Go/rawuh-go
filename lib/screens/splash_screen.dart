import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Menunda navigasi ke LoginPage selama 3 detik
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.only(top: 189),
          child: Column(
            children: [
              Container(
                child: Image.asset('assets/img/splashScreen/splashScreen.png'),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Rawuh-Go",
                style: GoogleFonts.dmSans(
                    fontSize: 32, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
