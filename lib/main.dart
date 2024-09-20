import 'package:flutter/material.dart';

import './screens/mainpage.dart';
import './screens/profile_screen.dart';
import './screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        Mainpage.routeName: (ctx) => Mainpage(),
        ProfileScreen.routeName: (ctx) => ProfileScreen(),
      },
    );
  }
}
