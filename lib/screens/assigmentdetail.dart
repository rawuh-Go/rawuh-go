import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AssigmentDetail extends StatefulWidget {
  @override
  State<AssigmentDetail> createState() => _AssigmentDetailState();
}

class _AssigmentDetailState extends State<AssigmentDetail> {
  List<Widget> sections = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.95),
      body: SafeArea(
        child: Column(
          children: [
            // AppBar section with back button and title
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 16, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    splashColor: Colors.grey.withOpacity(0.3),
                    highlightColor: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Assignment Detail',
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

            const SizedBox(height: 18),

            // Expanded and Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 4,
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Assignment title
                        Text(
                          'Crypto Wallet App Design',
                          style: GoogleFonts.dmSans(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Assigned by, Due Date, and Project Team in vertical layout
                        _buildVerticalInfo(
                            Icons.person, 'Assigned by', 'Julianto R.I'),
                        const SizedBox(height: 16),
                        _buildVerticalInfo(
                            Icons.calendar_today, 'Due Date', '20 June'),
                        const SizedBox(height: 16),
                        _buildVerticalInfo(Icons.group, 'Project Team', '',
                            icons: [
                              CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/img/main_page/user (1).png'), // Example image
                                radius: 12,
                              ),
                              const SizedBox(width: 4),
                              CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/img/main_page/user_avatar.png'), // Example image
                                radius: 12,
                              ),
                            ]),

                        const SizedBox(height: 24),

                        // Project Details
                        Text(
                          'Project Details',
                          style: GoogleFonts.dmSans(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s.',
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Default Project Sections
                        _buildSection('Section 1', true),
                        const SizedBox(height: 16),
                        _buildSection('Section 2', false),

                        const SizedBox(height: 16),

                        // Dynamically added sections
                        Column(
                          children: sections,
                        ),

                        const SizedBox(height: 16),

                        // Add Section button
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                sections
                                    .add(_buildSection('New Section', false));
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2A5867),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Add Section',
                              style: GoogleFonts.dmSans(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
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

  // Method to build the vertical info with icon and text
  Widget _buildVerticalInfo(IconData icon, String label, String text,
      {List<Widget>? icons}) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.center, // Center the items vertically
      children: [
        // Background circular with white icon
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF2A5867), // Background color
          ),
          padding: const EdgeInsets.all(8), // Padding around the icon
          child: Icon(icon, size: 24, color: Colors.white), // White icon
        ),
        const SizedBox(width: 12),
        // Column for label and text
        Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align text to the start
          children: [
            Text(
              label,
              style: GoogleFonts.dmSans(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            icons == null
                ? Text(
                    text,
                    style: GoogleFonts.dmSans(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  )
                : Row(children: icons),
          ],
        ),
      ],
    );
  }

  // Method to build the section for project report
  Widget _buildSection(String title, bool hasAttachment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.dmSans(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    hasAttachment ? '1 Attachment(s)' : '0 Attachment(s)',
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      color: Colors.grey[700],
                    ),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: hasAttachment
                              ? Colors.grey[400]
                              : const Color(0xFF2A5867),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                        ),
                        child: Text(
                          'Upload file',
                          style: GoogleFonts.dmSans(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: hasAttachment
                              ? Colors.grey[400]
                              : const Color(0xFF2A5867),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                        ),
                        child: Text(
                          'Submit',
                          style: GoogleFonts.dmSans(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (hasAttachment)
                const Text(
                  'Waiting for Approval',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
