import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplyLeaveScreen extends StatefulWidget {
  const ApplyLeaveScreen({Key? key}) : super(key: key);

  @override
  _ApplyLeaveScreenState createState() => _ApplyLeaveScreenState();
}

class _ApplyLeaveScreenState extends State<ApplyLeaveScreen> {
  final _leaveTypeController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _reasonController = TextEditingController();
  final List<String> leaveType = [
    'Sick Leave',
    'Personal Leave',
    'Annual Leave',
    'Marriage Leave',
  ];
  String? _selectedLeaveType;
  List<String> uploadedFiles = [];

  @override
  void initState() {
    super.initState();
    // Set the current date for Start Date and End Date
    DateTime currentDate = DateTime.now();
    _startDateController.text =
        "${currentDate.toLocal()}".split(' ')[0]; // Format: YYYY-MM-DD
    _endDateController.text = "${currentDate.add(Duration(days: 1)).toLocal()}"
        .split(' ')[0]; // End date: Next day
  }

  void pickFile() {
    // Placeholder function for file picking
    // You can implement file picker functionality here
    setState(() {
      uploadedFiles.add("example-file.pdf"); // Example file
    });
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white, // Set background color to white
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // Rounded corners
          ),
          content: SizedBox(
            width: 300, // Width of the dialog
            child: Column(
              mainAxisSize: MainAxisSize.min, // To size the dialog content
              children: [
                Center(
                  child: Text(
                    "Your request has been sent!",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center, // Center the text
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    "Wait for Approval",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center, // Center the text
                  ),
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/img/main_page/applyscreen.png', // Path to your image
                  height: 100, // Adjust height as needed
                  width: 100, // Adjust width as needed
                  fit: BoxFit.cover, // Fit the image
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.pushNamed(
                        context, '/leave-detail'); // Navigate to Leave Detail
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF2A5867), // Set button color to green
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(24.0), // Rounded corners
                    ),
                  ),
                  child: const Text(
                    "Check Status",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.95),
      body: SafeArea(
        child: Column(
          children: [
            // AppBar section with back button and "Leave Detail" title
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
                    'Apply Leave',
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
                              "Leave Application Form",
                              style: GoogleFonts.dmSans(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Leave Type Dropdown
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: DropdownButtonFormField<String>(
                            value: _selectedLeaveType,
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
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Reason input field
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            controller: _reasonController,
                            decoration: const InputDecoration(
                              labelText: 'Reason',
                              border: OutlineInputBorder(),
                            ),
                            maxLines: 3,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Start Date input field
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            controller: _startDateController,
                            decoration: const InputDecoration(
                              labelText: 'Start Date',
                              suffixIcon: Icon(Icons.calendar_today),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // End Date input field
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            controller: _endDateController,
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
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Text(file),
                                );
                              }).toList(),
                            ),
                          ),
                        const SizedBox(height: 20),
                        // Save Button
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            width: double
                                .infinity, // Makes the button width as wide as the parent container
                            child: ElevatedButton(
                              onPressed: () {
                                _showConfirmationDialog(
                                    context); // Show the dialog here
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2A5867),
                                padding: const EdgeInsets.symmetric(
                                    vertical:
                                        16.0), // Vertical padding for better button height
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      24.0), // Optional: To add rounded corners to the button
                                ),
                              ),
                              child: const Text(
                                'Apply Leave',
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
      ),
    );
  }
}
