import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditLeaveScreen extends StatefulWidget {
  final String date;
  final String leaveType;
  final String reason;
  final String startDate;
  final String endDate;
  final int attachmentCount;
  final String status;
  final Color statusColor;

  const EditLeaveScreen({
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
  _EditLeaveScreenState createState() => _EditLeaveScreenState();
}

class _EditLeaveScreenState extends State<EditLeaveScreen> {
  late TextEditingController leaveTypes;
  late TextEditingController reasonController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  List<String> uploadedFiles = [];
  String? _selectedLeaveType;

  // Daftar pilihan Leave Type
  final List<String> leaveType = [
    'Sick Leave',
    'Personal Leave',
    'Annual Leave',
    'Marriage Leave',
  ];

  @override
  void initState() {
    super.initState();
    leaveTypes = TextEditingController(text: widget.leaveType);
    reasonController = TextEditingController(text: widget.reason);
    startDateController = TextEditingController(text: widget.startDate);
    endDateController = TextEditingController(text: widget.endDate);
  }

  @override
  void dispose() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 0.95),
        body: SafeArea(
          child: Column(
            children: [
              // AppBar section with back button and leaveTypes
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
                      'Edit Leave ',
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
              const SizedBox(height: 16),
              // Edit content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Card(
                    color: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Date Section
                          Container(
                            width: double.infinity,
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
                                widget.date,
                                style: GoogleFonts.dmSans(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Status Section
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Status:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: widget.statusColor.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
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
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Leave Type Dropdown
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: DropdownButtonFormField<String>(
                              value: _selectedLeaveType ?? leaveTypes.text,
                              decoration: const InputDecoration(
                                labelText: 'Leave Type',
                                border: OutlineInputBorder(),
                              ),
                              items: leaveType.map((String type) {
                                return DropdownMenuItem<String>(
                                  value: type,
                                  child: Text(type),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedLeaveType = newValue;
                                  leaveTypes.text = newValue ?? '';
                                });
                              },
                            ),
                          ),

                          const SizedBox(height: 16),
                          // Editable reason
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: TextField(
                              controller: reasonController,
                              decoration: const InputDecoration(
                                labelText: 'Reason',
                                border: OutlineInputBorder(),
                              ),
                              maxLines: 3,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Editable Leave Date
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: TextField(
                              controller: startDateController,
                              decoration: const InputDecoration(
                                labelText: 'Start Date',
                                suffixIcon: Icon(Icons.calendar_today),
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Editable Leave Date
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: TextField(
                              controller: endDateController,
                              decoration: const InputDecoration(
                                labelText: 'End Date',
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.calendar_today),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // File upload section
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                const Icon(Icons.attach_file, size: 18),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: pickFile,
                                  child: const Text(
                                    'Upload File (png, jpg, pdf)',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF2A5867),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Show uploaded files
                          if (uploadedFiles.isNotEmpty)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: uploadedFiles.map((file) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    child: Text(file),
                                  );
                                }).toList(),
                              ),
                            ),
                          const SizedBox(height: 20),

                          // Save Button
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Save logic here
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2A5867),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                ),
                                child: const Text(
                                  'Update Leave',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
        );
  }
}
