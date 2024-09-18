import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import '../color_scheme.dart';
import '../screens/mainpage.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isOpen = true;
  bool isRememberMeChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset("assets/img/loginScreen/login_page.png"),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Login",
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 45,
                ),
                Container(
                  width: 290,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white, // Warna putih agar bagian dalam bersih
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey), // Warna border
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Warna shadow
                        spreadRadius:
                            2, // Mengatur seberapa jauh shadow menyebar
                        blurRadius: 6, // Blur untuk shadow yang lebih halus
                        offset: Offset(0, 3), // Membuat bayangan sedikit turun
                      ),
                    ],
                  ),
                  child: TextField(
                    cursorColor: Color(0xFF2A5867), // Warna kursor
                    decoration: InputDecoration(
                      hintText: "username",
                      hintStyle: GoogleFonts.mulish(
                          fontSize: 20, fontWeight: FontWeight.w400),
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      border: InputBorder.none, // Menghilangkan border default
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(
                            8.0), // Menyesuaikan padding ikon
                        child: Image.asset(
                          'assets/img/icons/form1.png', // Ikon dari asset
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 33,
                ),
                Container(
                  width: 290,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2), // Warna shadow
                        spreadRadius:
                            2, // Mengatur seberapa jauh shadow menyebar
                        blurRadius: 6, // Blur untuk shadow yang lebih halus
                        offset: Offset(0, 3), // Membuat bayangan sedikit turun
                      ),
                    ],
                  ),
                  child: TextField(
                    cursorColor: Color(0xFF2A5867),
                    decoration: InputDecoration(
                      hintText: "........",
                      hintStyle: GoogleFonts.mulish(
                          fontSize: 20, fontWeight: FontWeight.w400),
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
                  height: 13,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "remember me",
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    Checkbox(
                      value: isRememberMeChecked,
                      onChanged: (value) {
                        setState(() {
                          isRememberMeChecked = value ?? false;
                        });
                      },
                      activeColor:
                          Color(0xFF2A5867), // Warna checkbox saat aktif
                    ),
                  ],
                ),
                SizedBox(
                  height: 47,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(Mainpage.routeName);
                  },
                  child: Container(
                    height: 50,
                    width: 291,
                    decoration: BoxDecoration(
                      color: ColButton,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        "Login",
                        style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: ColBackground),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 27,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "forgot password?",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "contact admin",
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.amber,
                            fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
