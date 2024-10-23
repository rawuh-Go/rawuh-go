import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'assigmentdetail.dart';
// Import screen detail

class AssignmentScreen extends StatelessWidget {
  final List<Map<String, String>> assignments = [
    {
      'title': 'Crypto Wallet App Design',
      'assignedBy': 'Julianto R.I',
      'dueDate': '20 June',
      'status': 'Ongoing', // Contoh status
    },
    {
      'title': 'AI Chatbot Implementation',
      'assignedBy': 'Rina S.',
      'dueDate': '25 June',
      'status': 'Pending', // Contoh status
    },
    {
      'title': 'E-commerce App Development',
      'assignedBy': 'Rudi A.',
      'dueDate': '30 June',
      'status': 'Done', // Contoh status
    },
    // Add more assignments as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.90),
      body: SafeArea(
        child: Column(
          children: [
            // Custom AppBar
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
                    'Assignments',
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

            const SizedBox(height: 18), // Space below AppBar

            // List of assignments
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                  itemCount: assignments.length,
                  itemBuilder: (context, index) {
                    final assignment = assignments[index];
                    return _buildAssignmentCard(context, assignment);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssignmentCard(
      BuildContext context, Map<String, String> assignment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15), // Spacing antara kartu
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFF2A5867),
          width: 1.0,
        ),
      ),
      child: InkWell(
        onTap: () {
          // Navigasi ke detail screen saat kartu diklik
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AssigmentDetail(),
            ),
          );
        },
        borderRadius:
            BorderRadius.circular(12), // Menjaga border radius untuk InkWell
        splashColor: Colors.grey.withOpacity(0.3), // Efek splash saat diklik
        highlightColor:
            Colors.grey.withOpacity(0.2), // Efek highlight saat ditekan
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row untuk Assigned by dan ikon panah
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Bagian Assigned by dan Due Date
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          assignment['title']!,
                          style: GoogleFonts.dmSans(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Assigned by: ${assignment['assignedBy']}',
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Due Date: ${assignment['dueDate']}',
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Ikon panah di sebelah kanan
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey, // Atur warna sesuai kebutuhan
                  ),
                ],
              ),

              const SizedBox(height: 8), // Space between due date and status

              // Status di bawah due date dengan rata kanan
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(assignment['status']!)
                        .withOpacity(0.3), // Background sedikit transparan
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    assignment['status']!,
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color:
                          _getStatusColor(assignment['status']!), // Warna teks
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk mendapatkan warna sesuai dengan status
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'ongoing':
        return Colors.yellow; // Warna kuning untuk ongoing
      case 'pending':
        return Colors.red; // Warna merah untuk pending
      case 'done':
        return Colors.green; // Warna hijau untuk done
      default:
        return Colors.grey; // Default warna abu-abu
    }
  }
}
