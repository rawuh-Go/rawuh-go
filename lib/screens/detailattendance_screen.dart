import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_rawuhgo/models/attendance_model.dart';

class AttendanceDetailScreen extends StatefulWidget {
  final int attendanceId;

  const AttendanceDetailScreen({required this.attendanceId});

  @override
  _AttendanceDetailScreenState createState() => _AttendanceDetailScreenState();
}

class _AttendanceDetailScreenState extends State<AttendanceDetailScreen> {
  Attendance? attendanceDetail;

  @override
  void initState() {
    super.initState();
    fetchAttendanceDetail(); // Panggil data saat inisialisasi layar
  }

  Future<void> fetchAttendanceDetail() async {
    final url = 'http://127.0.0.1:8000/api/attendances/${widget.attendanceId}';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          attendanceDetail = Attendance.fromJson(data); // Parse data ke model
        });
      }
      // Di sini tidak ada penanganan error, sehingga pesan tidak ditampilkan
    } catch (e) {
      print('Error: $e'); // Anda bisa menghapus atau menyesuaikan ini
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.95),
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
                        children: const [
                          Icon(Icons.arrow_back_ios, color: Colors.black),
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
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              attendanceDetail != null
                  ? Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // Tanggal
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2A5867),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  attendanceDetail!.day,
                                  style: GoogleFonts.dmSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Detail CHECK IN
                            _buildAttendanceDetailCard(
                              'CHECK IN',
                              attendanceDetail!.checkInStatus,
                              attendanceDetail!.checkInTime,
                              '${attendanceDetail!.datangLatitude}, ${attendanceDetail!.datangLongitude}',
                              'Your Address for Check In',
                              Colors.green,
                              Icons.login_rounded,
                            ),
                            const SizedBox(height: 16),
                            // Detail CHECK OUT
                            _buildAttendanceDetailCard(
                              'CHECK OUT',
                              attendanceDetail!.checkOutStatus,
                              attendanceDetail!.checkOutTime,
                              '${attendanceDetail!.pulangLatitude}, ${attendanceDetail!.pulangLongitude}',
                              'Your Address for Check Out',
                              Colors.red,
                              Icons.logout_rounded,
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox
                      .shrink(), // Menghilangkan tampilan jika tidak ada data
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAttendanceDetailCard(
    String title,
    String statusText,
    String time,
    String position,
    String address,
    Color statusColor,
    IconData iconData,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
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
                    iconData,
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
                ],
              ),
              // Tampilkan hanya satu status
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusText == 'late' ? Colors.red : Colors.green,
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
          // Address
          Text(
            'Address: $address',
            style: GoogleFonts.dmSans(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
