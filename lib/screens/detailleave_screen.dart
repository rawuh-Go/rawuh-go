import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'editleave_screen.dart';

class DetailLeaveScreen extends StatefulWidget {
  final String date;
  final String leaveType;
  final String reason;
  final String startDate;
  final String endDate;
  final int attachmentCount;
  final String status;
  final Color statusColor;
  final String adminNotes;
  final List<String> attachments; // List of attachment file names

  const DetailLeaveScreen({
    Key? key,
    required this.date,
    required this.leaveType,
    required this.reason,
    required this.startDate,
    required this.endDate,
    required this.attachmentCount,
    required this.status,
    required this.statusColor,
    this.adminNotes = 'Get Well Soon!',
    this.attachments = const ['image.jpg'],
  }) : super(key: key);

  @override
  _DetailLeaveScreenState createState() => _DetailLeaveScreenState();
}

class _DetailLeaveScreenState extends State<DetailLeaveScreen> {
  late TextEditingController leaveTypes;
  late TextEditingController reasonController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  List<String> uploadedFiles = [];

  @override
  void initState() {
    super.initState();
    leaveTypes = TextEditingController(text: widget.leaveType);
    reasonController = TextEditingController(text: widget.reason);
    startDateController = TextEditingController(text: widget.startDate);
    endDateController = TextEditingController(text: widget.endDate);
    uploadedFiles = widget.attachments; // Initialize with provided attachments
  }

  @override
  void dispose() {
    leaveTypes.dispose();
    reasonController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  // Function to pick file
  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg', 'pdf'],
    );

    if (result != null) {
      setState(() {
        uploadedFiles.add(result.files.single.name);
      });
    }
  }

  // Function to view file
  void viewFile(String fileName) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Viewing $fileName'),
        content: Text('This is where you would preview the file content.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.95),
      body: SafeArea(
        child: Column(
          children: [
            // AppBar section with back button and title
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
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
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
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

            // Main content section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildDetailCard(),
                      const SizedBox(height: 20),
                      _buildStatusCard(),
                      const SizedBox(height: 20),
                      _buildEditButton(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for the detail card section
  Widget _buildDetailCard() {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(widget.date),
          _buildDetailTile('Leave Type', widget.leaveType),
          _buildDetailTile('Reason', widget.reason),
          _buildDetailTile('Start Date', widget.startDate),
          _buildDetailTile('End Date', widget.endDate),
          _buildAttachmentsSection(),
        ],
      ),
    );
  }

  // Widget for the status and admin notes section
  Widget _buildStatusCard() {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatus(),
            const SizedBox(height: 10),
            _buildAdminNotes(),
          ],
        ),
      ),
    );
  }

  // Widget for the edit button
  Widget _buildEditButton() {
    return ElevatedButton(
      onPressed: () {
        // Navigate to EditLeaveScreen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditLeaveScreen(
              date: widget.date,
              leaveType: widget.leaveType,
              reason: widget.reason,
              startDate: widget.startDate,
              endDate: widget.endDate,
              attachmentCount: widget.attachmentCount,
              status: widget.status,
              statusColor: widget.statusColor,
            ),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2A5867),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
      child: const Text(
        'Edit Leave',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Helper widget for the header section
  Widget _buildHeader(String date) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2A5867),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Center(
        child: Text(
          date,
          style: GoogleFonts.dmSans(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Helper widget for detail tiles
  Widget _buildDetailTile(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
      ),
    );
  }

  // Helper widget for the attachments section
  Widget _buildAttachmentsSection() {
    return uploadedFiles.isNotEmpty
        ? Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Attachments:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...List.generate(widget.attachmentCount, (index) {
                  if (index < uploadedFiles.length) {
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.insert_drive_file,
                            color: Colors.grey),
                        title: Text(uploadedFiles[index]),
                        trailing: TextButton(
                          onPressed: () => viewFile(uploadedFiles[index]),
                          child: const Text('View'),
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),
              ],
            ),
          )
        : const SizedBox.shrink();
  }

  // Helper widget for the status section
  Widget _buildStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Status:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: widget.statusColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            widget.status,
            style: TextStyle(
              color: widget.statusColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // Helper widget for the admin notes section
  Widget _buildAdminNotes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Notes:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Text(widget.adminNotes),
      ],
    );
  }
}
