import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_rawuhgo/models/attendance_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'detailattendance_screen.dart';

class HistoryScreen extends StatefulWidget {
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Attendance> attendanceData = [];

  @override
  void initState() {
    super.initState();
    fetchAttendanceData(); // Fetch data when the screen is initialized
  }

  Future<void> fetchAttendanceData() async {
    // Ambil user_id dari SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('user_id') ?? 0; // Default ke 0 jika tidak ada

    // Replace with your API endpoint
    final url = 'http://127.0.0.1:8000/api/attendances/user/$userId';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          attendanceData =
              data.map((json) => Attendance.fromJson(json)).toList();
        });
      } else {
        // Handle errors
        print('Error fetching data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.90),
      body: SafeArea(
        child: Column(
          children: [
            // Back button with title History
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 16, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const MainScreen(selectedIndex: 0),
                        ),
                      );
                    },
                    splashColor: Colors.grey.withOpacity(0.3),
                    highlightColor: Colors.grey.withOpacity(0.2),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'History Attendance',
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
            const SizedBox(height: 18),

            // Content for History Attendance
            Expanded(
              child: ListView.builder(
                itemCount: attendanceData.length,
                itemBuilder: (context, index) {
                  final data = attendanceData[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    child: Container(
                      margin:
                          const EdgeInsets.only(bottom: 10), // Jarak antar card
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFF2A5867),
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data.day,
                                style: GoogleFonts.dmSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AttendanceDetailScreen(
                                        attendanceId: data.id,
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildCheckInOutColumn(
                                'CHECK IN',
                                data.checkInStatus,
                                data.checkInTime,
                              ),
                              _buildCheckInOutColumn(
                                'CHECK OUT',
                                data.checkOutStatus,
                                data.checkOutTime,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckInOutColumn(String title, String status, String time) {
    Color statusColor;

    // Assign color based on status
    if (status.toLowerCase() == 'early') {
      statusColor = Colors.green;
    } else if (status.toLowerCase() == 'late') {
      statusColor = Colors.red;
    } else {
      statusColor = Colors.amber;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: GoogleFonts.dmSans(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                status,
                style: GoogleFonts.dmSans(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          time,
          style: GoogleFonts.dmSans(
            fontSize: 12,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
