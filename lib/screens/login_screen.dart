import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isOpen = true;
  bool isRememberMeChecked = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUsername = prefs.getString('username');
    String? savedPassword = prefs.getString('password');
    bool? rememberMe = prefs.getBool('remember_me') ?? false;

    if (rememberMe) {
      setState(() {
        _usernameController.text = savedUsername ?? '';
        _passwordController.text = savedPassword ?? '';
        isRememberMeChecked = true;
      });
    }
  }

  Future<void> _saveUserData(String username, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (isRememberMeChecked) {
      await prefs.setString('username', username);
      await prefs.setString('password', password);
      await prefs.setBool('remember_me', true);
    } else {
      await prefs.remove('username');
      await prefs.remove('password');
      await prefs.setBool('remember_me', false);
    }
  }

  Future<void> login() async {
    setState(() {
      isLoading = true;
    });

    try {
      var response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/login/users'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': _usernameController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print('Login successful, Token: ${data['access_token']}');

        SharedPreferences prefs = await SharedPreferences.getInstance();
        // Simpan semua data pengguna dalam bentuk JSON
        await prefs.setString('access_token', data['access_token']);
        await prefs.setString('user_data', jsonEncode(data['user']));
        // Simpan user_id ke SharedPreferences
        await prefs.setInt(
            'user_id', data['user']['id']); // Simpan user_id di sini

        // Simpan username dan password jika Remember Me dicentang
        _saveUserData(_usernameController.text, _passwordController.text);

        // Redirect ke MainScreen atau HomeScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainScreen(selectedIndex: 0)),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Login Failed'),
            content: Text('Invalid username or password'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      }
    } catch (error) {
      print('Error during login: $error');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Login Error'),
          content: Text('An error occurred. Please try again later.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double titleFontSize = screenWidth * 0.08;
    double fieldWidth = screenWidth * 0.8;
    double buttonHeight = screenHeight * 0.07;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset("assets/img/loginScreen/login_page.png"),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  "Login",
                  style: GoogleFonts.poppins(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                buildTextField("username", _usernameController,
                    'assets/img/icons/form1.png'),
                SizedBox(height: screenHeight * 0.05),
                buildTextField("password", _passwordController,
                    'assets/img/icons/form2.png',
                    isPassword: true),
                SizedBox(height: screenHeight * 0.02),
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
                SizedBox(height: screenHeight * 0.05),
                buildLoginButton(buttonHeight, fieldWidth),
                SizedBox(height: screenHeight * 0.03),
                buildForgotPassword(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String hint, TextEditingController controller, String iconPath,
      {bool isPassword = false}) {
    return Container(
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
        controller: controller,
        obscureText: isPassword ? isOpen : false,
        cursorColor: Color(0xFF2A5867),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle:
              GoogleFonts.mulish(fontSize: 16, fontWeight: FontWeight.w400),
          contentPadding: EdgeInsets.symmetric(vertical: 10),
          border: InputBorder.none,
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(iconPath, width: 20, height: 20),
          ),
          suffixIcon: isPassword
              ? InkWell(
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
                )
              : null,
        ),
      ),
    );
  }

  Widget buildLoginButton(double buttonHeight, double fieldWidth) {
    return InkWell(
      onTap: () {
        if (!isLoading) login();
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
    );
  }

  Widget buildForgotPassword() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "forgot password?",
            style:
                GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          SizedBox(width: 10),
          InkWell(
            onTap: () {
              // Aksi untuk "contact admin"
            },
            child: Text(
              "contact admin",
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Color(0xFF2A5867),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
