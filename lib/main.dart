import 'package:flutter/material.dart';
import 'package:mobile_rawuhgo/screens/change_password.dart';
import 'package:mobile_rawuhgo/screens/leave_screen.dart';
import 'package:mobile_rawuhgo/screens/notification_screen.dart';

import './screens/assigment_screen.dart'; // Import AssignmentScreen
import './screens/history_screen.dart'; // Import HistoryScreen
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
        '/change-password': (ctx) => ChangePasswordScreen(),
        '/notification-screen': (ctx) => NotificationScreen(),
        '/leave-screen': (ctx) => LeaveScreen(), // Tambahkan route leave-screen
        '/assigment-screen': (ctx) =>
            AssigmentScreen(), // Tambahkan route assignment-screen
        '/history-screen': (ctx) =>
            HistoryScreen(), // Tambahkan route history-screen
      },
    );
  }
}
