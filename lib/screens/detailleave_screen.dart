import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_rawuhgo/screens/leave_screen.dart';

class DetailLeaveScreen extends StatelessWidget {
  static const routeName = '/detail-leave-screen';

  final String date;
  final String title;
  final String description;
  final String leaveDate;
  final int attachmentCount;
  final String status;
  final Color statusColor;

  const DetailLeaveScreen({
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
    return Scaffold(
      backgroundColor: Colors.white,
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
                    'Leave Detail',
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
            const SizedBox(height: 20),
            // Detail content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Date Section
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFF00695C),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              date,
                              style: GoogleFonts.dmSans(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Title and Description
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(description),
                        const SizedBox(height: 20),
                        // Leave Date Section
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              leaveDate,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Attachments if any
                        if (attachmentCount > 0)
                          Row(
                            children: [
                              const Icon(Icons.attach_file, size: 18),
                              const SizedBox(width: 8),
                              Text('$attachmentCount Attachment(s)'),
                            ],
                          ),
                        const SizedBox(height: 20),
                        // Status
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
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
                        const SizedBox(height: 20),
                        // Additional Information
                        Text(
                          'Further leave details can be shown here. Add any extra information or actions.',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
