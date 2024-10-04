import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../color_scheme.dart';
import '../main.dart';
import 'detailattendance_screen.dart';

class HistoryScreen extends StatefulWidget {
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.90),
      body: SafeArea(
        child: Column(
          children: [
            // Back button dengan teks History
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
                        MaterialPageRoute(builder: (context) => MainScreen()),
                      );
                    },
                    splashColor:
                        Colors.grey.withOpacity(0.3), // Efek splash abu-abu
                    highlightColor: Colors.grey
                        .withOpacity(0.2),
                    child: Row(
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

            const SizedBox(height: 20),

            // Content for History Attendance
            Expanded(
              child: ListView.builder(
                itemCount:
                    attendanceData.length, // Number of attendance records
                itemBuilder: (context, index) {
                  final data = attendanceData[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color:
                            Colors.white, // Set background color menjadi putih
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(
                              0xFF2A5867), // Tambahkan border abu-abu
                          width: 1.0, // Set tebal border
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data['day'],
                                style: GoogleFonts.dmSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: 8, // Adjust the spacing as needed
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AttendanceDetailScreen(data: data),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildCheckInOutColumn(
                                'CHECK IN',
                                data['check_in_status'],
                                data['check_in_time'],
                                data['check_in_color'],
                              ),
                              _buildCheckInOutColumn(
                                'CHECK OUT',
                                data['check_out_status'],
                                data['check_out_time'],
                                data['check_out_color'],
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

  Widget _buildCheckInOutColumn(
      String title, String status, String time, Color statusColor) {
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

// Sample attendance data
final List<Map<String, dynamic>> attendanceData = [
  {
    'day': 'Monday, 09 September 2024',
    'check_in_status': 'Leaves',
    'check_in_time': '-',
    'check_in_color': Colors.amber,
    'check_out_status': 'Leaves',
    'check_out_time': '-',
    'check_out_color': Colors.amber,
  },
  {
    'day': 'Friday, 09 September 2024',
    'check_in_status': 'early',
    'check_in_time': '08:00:00 WIB',
    'check_in_color': Colors.green,
    'check_out_status': 'early',
    'check_out_time': '16:44:05 WIB',
    'check_out_color': Colors.green,
  },
  {
    'day': 'Monday, 09 September 2024',
    'check_in_status': 'early',
    'check_in_time': '08:10:00 WIB',
    'check_in_color': Colors.green,
    'check_out_status': 'late',
    'check_out_time': '17:09:00 WIB',
    'check_out_color': Colors.red,
  },
  {
    'day': 'Monday, 09 September 2024',
    'check_in_status': 'early',
    'check_in_time': '08:10:00 WIB',
    'check_in_color': Colors.green,
    'check_out_status': 'late',
    'check_out_time': '17:09:00 WIB',
    'check_out_color': Colors.red,
  },
  {
    'day': 'Monday, 09 September 2024',
    'check_in_status': 'early',
    'check_in_time': '08:10:00 WIB',
    'check_in_color': Colors.green,
    'check_out_status': 'late',
    'check_out_time': '17:09:00 WIB',
    'check_out_color': Colors.red,
  },
];
