import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_rawuhgo/models/leave_model.dart';

import 'editleave_screen.dart';

class DetailLeaveScreen extends StatefulWidget {
  final int leaveId;

  const DetailLeaveScreen({required this.leaveId});

  @override
  _DetailLeaveScreenState createState() => _DetailLeaveScreenState();
}

class _DetailLeaveScreenState extends State<DetailLeaveScreen> {
  Leave? leaveDetail; // Model untuk menyimpan detail leave

  @override
  void initState() {
    super.initState();
    fetchLeaveDetail(); // Panggil data saat inisialisasi layar
  }

  Future<void> fetchLeaveDetail() async {
    final url =
        'http://127.0.0.1:8000/api/leaves/${widget.leaveId}'; // Gunakan leaveId
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          leaveDetail = Leave.fromJson(data); // Parse data ke model
        });
      } else {
        // Tangani error
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.95),
      body: SafeArea(
        child: leaveDetail == null
            ? const Center(
                child:
                    CircularProgressIndicator()) // Loader saat data belum ada
            : Column(
                children: [
                  // AppBar section with back button and title
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 16, right: 16),
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
                            _buildDetailCard(), // Detil kartu
                            const SizedBox(height: 20),
                            _buildStatusCard(), // Kartu status
                            const SizedBox(height: 20),
                            _buildEditButton(), // Tombol edit
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
          _buildHeader(
              leaveDetail!.tanggal), // Menggunakan tanggal dari leaveDetail
          _buildDetailTile('Leave Type', leaveDetail!.typeLeave),
          _buildDetailTile('Reason', leaveDetail!.reason),
          _buildDetailTile(
              'Start Date', leaveDetail!.tanggalMulai, 12), // Set font size 12
          _buildDetailTile(
              'End Date', leaveDetail!.tanggalSelesai, 12), // Set font size 12
          // Tidak ada attachment di model, bisa dihapus jika tidak ada
        ],
      ),
    );
  }

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
            _buildStatus(
                leaveDetail!.status), // Menggunakan status dari leaveDetail
            const SizedBox(height: 10),
            _buildNotes(leaveDetail!.catatan), // New notes widget
          ],
        ),
      ),
    );
  }

  Widget _buildNotes(String notes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Notes:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text(
          notes.isNotEmpty ? notes : 'No notes available',
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildEditButton() {
    // Cek status, tombol nonaktif jika status approve atau rejected
    bool isEditable = leaveDetail!.status.toLowerCase() != 'approve' &&
        leaveDetail!.status.toLowerCase() != 'rejected';

    return ElevatedButton(
      onPressed: isEditable
          ? () {
              // Navigate to EditLeaveScreen dengan parameter dari leaveDetail
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditLeaveScreen(
                    leaveId: leaveDetail!.id,
                    date: leaveDetail!.tanggal,
                    leaveType: leaveDetail!.typeLeave,
                    reason: leaveDetail!.reason,
                    startDate: leaveDetail!.tanggalMulai,
                    endDate: leaveDetail!.tanggalSelesai,
                    attachmentCount: leaveDetail!
                        .attachmentCount, // Pass the attachment count
                    status: leaveDetail!.status,
                    statusColor:
                        leaveDetail!.getStatusColor(), // Get status color
                  ),
                ),
              );
            }
          : null, // Matikan tombol jika statusnya 'approve' atau 'rejected'
      style: ElevatedButton.styleFrom(
        backgroundColor: isEditable
            ? const Color(0xFF2A5867)
            : Colors.grey, // Ubah warna jika dinonaktifkan
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

  Widget _buildDetailTile(String title, String subtitle, [double? fontSize]) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: fontSize ?? 14), // Set default font size
        ),
      ),
    );
  }

  Widget _buildStatus(String status) {
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
            color: getStatusColor(status).withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: getStatusColor(status),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // Helper function to get color based on status
  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approve':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
