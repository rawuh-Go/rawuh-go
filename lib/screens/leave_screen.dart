import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';
import 'applyleave_screen.dart';
import 'detailleave_screen.dart';

class LeaveScreen extends StatefulWidget {
  @override
  State<LeaveScreen> createState() => _LeaveScreenState();
}

class _LeaveScreenState extends State<LeaveScreen> {
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
                    'Leave',
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

            // Leave cards section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView(
                  children: const [
                    LeaveCard(
                      date: 'Tuesday, 8 September 2024',
                      leaveType: 'Sick Leave',
                      reason: 'Opname di Rs harapan',
                      startDate: '8 Sep 2024',
                      endDate: '',
                      attachmentCount: 1,
                      status: 'Approved',
                      statusColor: Colors.green,
                    ),
                    LeaveCard(
                      date: 'Thursday, 19 September 2024',
                      leaveType: 'Marriage Leave',
                      reason: 'Cuti menikah 3 hari',
                      startDate: '27 Sep 2024',
                      endDate: '29 Sep 2024',
                      attachmentCount: 1,
                      status: 'Pending',
                      statusColor: Colors.orange,
                    ),
                    LeaveCard(
                      date: 'Wednesday, 11 September 2024',
                      leaveType: 'Sick Leave',
                      reason: 'Sakit flu',
                      startDate: '11 Aug 2024',
                      endDate: '',
                      attachmentCount: 0,
                      status: 'Rejected',
                      statusColor: Colors.red,
                    ),
                  ],
                ),
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
  final String date;
  final String leaveType;
  final String reason;
  final String startDate;
  final String endDate;
  final int attachmentCount;
  final String status;
  final Color statusColor;

  const LeaveCard({
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
                      date: date,
                      leaveType: leaveType,
                      reason: reason,
                      startDate: startDate,
                      endDate: endDate,
                      attachmentCount: attachmentCount,
                      status: status,
                      statusColor: statusColor,
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
