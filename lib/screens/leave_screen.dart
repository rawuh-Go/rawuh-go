import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_rawuhgo/models/leave_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'applyleave_screen.dart';
import 'detailleave_screen.dart';

class LeaveScreen extends StatefulWidget {
  @override
  State<LeaveScreen> createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen> {
  List<Leave> leaveData = [];

  @override
  void initState() {
    super.initState();
    fetchLeaveData(); // Fetch data when the screen is initialized
  }

  Future<void> fetchLeaveData() async {
    // Ambil user_id dari SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt('user_id') ?? 0; // Default ke 0 jika tidak ada

    // Replace with your API endpoint
    final url = 'http://localhost:8000/api/leaves/user/$userId';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          leaveData = data.map((json) => Leave.fromJson(json)).toList();
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
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.95),
      body: SafeArea(
        child: Column(
          children: [
            // AppBar section with back button and leaveType
            Padding(
              padding: const EdgeInsets.only(
                  top: 30, left: 16, right: 30), // Jarak atas
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainScreen(
                              selectedIndex:
                                  0), // Provide a default index or the desired index
                        ),
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
                    'Leave',
                    style: GoogleFonts.dmSans(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 48), // Empty space for alignment
                ],
              ),
            ),
            const SizedBox(width: 18),

            // Leave cards section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: leaveData.isNotEmpty
                    ? ListView.builder(
                        itemCount: leaveData.length,
                        itemBuilder: (context, index) {
                          final leave = leaveData[index];
                          return LeaveCard(
                            leaveId: leave.id,
                            date: leave.tanggal, // Replace with your date field
                            leaveType: leave
                                .typeLeave, // Replace with leave type field
                            reason: leave.reason, // Replace with reason field
                            startDate: leave
                                .tanggalMulai, // Replace with start date field
                            endDate: leave.tanggalSelesai ??
                                '', // Replace with end date
                            attachmentCount: leave.attachment != null
                                ? 1
                                : 0, // Check for attachments
                            status: leave.status, // Replace with status field
                            statusColor: getStatusColor(
                                leave.status), // Use helper for status color
                          );
                        },
                      )
                    : Container(), // Empty container if data is empty
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to ApplyLeaveScreen when the button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ApplyLeaveScreen(),
            ),
          );
        },
        backgroundColor: const Color(0xFF2A5867),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        shape: const CircleBorder(),
      ),
    );
  }
}

class LeaveCard extends StatelessWidget {
  final int leaveId;
  final String date;
  final String leaveType;
  final String reason;
  final String startDate;
  final String endDate;
  final int attachmentCount;
  final String status;
  final Color statusColor;

  const LeaveCard({
    required this.leaveId,
    required this.date,
    required this.leaveType,
    required this.reason,
    required this.startDate,
    required this.endDate,
    required this.attachmentCount,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25), // Provides space for date header
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFEDF2F3),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: Column(
        children: [
          // Date header with the same width as the card content
          Container(
            width:
                double.infinity, // Ensures the date header spans the card width
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFF2A5867),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Center(
              child: Text(
                date,
                style: GoogleFonts.dmSans(
                  color: const Color(0xFFEDF2F3),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Card content
          Card(
            color: Colors.white,
            margin:
                EdgeInsets.zero, // Align the card content to the date header
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: InkWell(
              onTap: () {
                // Navigate to detail page for leave
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailLeaveScreen(
                      leaveId: leaveId,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main content with leaveType, reason, and leave date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                leaveType,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(reason),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.calendar_today, size: 16),
                                  const SizedBox(width: 4),
                                  Text(startDate),
                                  const SizedBox(
                                      width:
                                          10), // Space between startDate and endDate
                                  const Text('-'), // Separator
                                  const SizedBox(width: 10),
                                  Text(endDate),
                                ],
                              ),
                              if (attachmentCount > 0)
                                Row(
                                  children: [
                                    const Icon(Icons.attach_file, size: 16),
                                    const SizedBox(width: 4),
                                    Text('$attachmentCount Attachment(s)'),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        // Icon forward_ios added here
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey, // Adjust color as needed
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Status section at the bottom right
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              color: statusColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Helper function to get color based on status
Color getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'approve':
      return Colors.green;
    case 'pending':
      return Colors.orange;
    case 'rejected':
      return Colors.red;
    default:
      return Colors.grey;
  }
}
