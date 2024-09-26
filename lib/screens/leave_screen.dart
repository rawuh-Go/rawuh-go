import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaveScreen extends StatefulWidget {
  static const routeName = '/leave-screen';

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
            // AppBar section with back button and title
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Back',
                          style: GoogleFonts.dmSans(
                            color: Colors.black,
                            fontSize: 16,
                          ),
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
                      title: 'Sick Leave',
                      description: 'Opname di Rs harapan',
                      leaveDate: '8 Sep 2024',
                      attachmentCount: 1,
                      status: 'Approved',
                      statusColor: Colors.green,
                    ),
                    LeaveCard(
                      date: 'Thursday, 19 September 2024',
                      title: 'Marriage Leave',
                      description: 'Cuti menikah 3 hari',
                      leaveDate: '27 Sep 2024 - 29 Sep 2024',
                      attachmentCount: 1,
                      status: 'Pending',
                      statusColor: Colors.orange,
                    ),
                    LeaveCard(
                      date: 'Wednesday, 11 September 2024',
                      title: 'Sick Leave',
                      description: 'Sakit flu',
                      leaveDate: '11 Aug 2024',
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
          // Add new leave request action
        },
        backgroundColor: Colors.yellow[700],
        child: const Icon(Icons.add),
      ),
    );
  }
}

class LeaveCard extends StatelessWidget {
  final String date;
  final String title;
  final String description;
  final String leaveDate;
  final int attachmentCount;
  final String status;
  final Color statusColor;

  const LeaveCard({
    required this.date,
    required this.title,
    required this.description,
    required this.leaveDate,
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
            margin:
                EdgeInsets.zero, // Align the card content to the date header
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: InkWell(
              onTap: () {
                // Navigate to detail page for leave
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main content with title, description, and leave date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(description),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.calendar_today, size: 16),
                                  const SizedBox(width: 4),
                                  Text(leaveDate),
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
                    const SizedBox(height: 8),
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
