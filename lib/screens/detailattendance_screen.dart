import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AttendanceDetailScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  AttendanceDetailScreen({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.90),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30),
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
                          const SizedBox(width: 1),
                          Text(
                            'Back',
                            style: GoogleFonts.dmSans(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Attendance Detail',
                      style: GoogleFonts.dmSans(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                        width:
                            48), // You can add another widget here if needed for right side alignment
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Tanggal
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A5867),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    data['day'],
                    style: GoogleFonts.dmSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Wrap the rest of the content in SingleChildScrollView
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Detail CHECK IN
                      _buildAttendanceDetailCard(
                        'CHECK IN',
                        'early',
                        '08:00:00 WIB',
                        '-7.760040, 110.408550',
                        'Jl. Ring Road Utara, Ngringin, Condongcatur',
                        data['check_in_status'],
                        Colors.green,
                        'assets/img/main_page/absen.png',
                      ),
                      const SizedBox(height: 16),
                      // Detail CHECK OUT
                      _buildAttendanceDetailCard(
                        'CHECK OUT',
                        'late',
                        '17:09:00 WIB',
                        '-7.760040, 110.408550',
                        'Jl. Ring Road Utara, Ngringin, Condongcatur',
                        data['check_out_status'],
                        Colors.red,
                        'assets/img/main_page/absen.png', // Attachment image path
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk menampilkan detail check-in/check-out
  Widget _buildAttendanceDetailCard(
    String title,
    String status,
    String time,
    String position,
    String address,
    String statusText,
    Color statusColor,
    String attachmentPath,
  ) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header dengan ikon dan status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    title == 'CHECK IN'
                        ? Icons.login_rounded
                        : Icons.logout_rounded,
                    color: statusColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: GoogleFonts.dmSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      statusText,
                      style: GoogleFonts.dmSans(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                status == 'early' ? 'early' : 'late',
                style: GoogleFonts.dmSans(
                  fontSize: 12,
                  color: status == 'early' ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Time
          Text(
            'Time: $time',
            style: GoogleFonts.dmSans(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          // Position
          Text(
            'Position: $position',
            style: GoogleFonts.dmSans(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          // Distance
          Text(
            'Distance: 27 Meter',
            style: GoogleFonts.dmSans(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          // Address
          Text(
            'Address: $address',
            style: GoogleFonts.dmSans(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          // Attachment
          Row(
            children: [
              Text(
                'Attachment: ',
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  attachmentPath,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
