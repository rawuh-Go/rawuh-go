import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Leave {
  final int id;
  final int userId;
  final String tanggal;
  final String tanggalMulai;
  final String tanggalSelesai;
  final String typeLeave;
  final String attachment;
  final String reason;
  final String status;
  final String catatan;
  final String createdAt;
  final String updatedAt;
  final String approvedBy;
  final int attachmentCount;

  Leave({
    required this.id,
    required this.userId,
    required this.tanggal,
    required this.tanggalMulai,
    required this.tanggalSelesai,
    required this.typeLeave,
    required this.attachment,
    required this.reason,
    required this.status,
    required this.catatan,
    required this.createdAt,
    required this.updatedAt,
    required this.approvedBy,
    required this.attachmentCount, // New property
  });

  // Factory method to create a Leave instance from a JSON object
  factory Leave.fromJson(Map<String, dynamic> json) {
    DateTime tanggal = DateTime.parse(json['tanggal']);
    String tanggalbuat = DateFormat('dd MMMM yyyy').format(tanggal);

    DateTime tanggalMulai = DateTime.parse(json['tanggal_mulai']);
    String dateMulai = DateFormat('dd MMMM yyyy').format(tanggalMulai);

    DateTime tanggalSelesai = DateTime.parse(json['tanggal_selesai']);
    String dateSelesai = DateFormat('dd MMMM yyyy').format(tanggalSelesai);

    List<String> attachments = json['attachment']?.split(',') ?? [];
    int attachmentCount = attachments.length;

    return Leave(
      id: json['id'],
      userId: json['user_id'],
      tanggal: tanggalbuat,
      tanggalMulai: dateMulai,
      tanggalSelesai: dateSelesai,
      typeLeave: json['type_leave'],
      attachment: json['attachment'] ?? '', // handle null values
      reason: json['reason'],
      status: json['status'],
      catatan: json['catatan'] ?? '',
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      approvedBy: json['approved_by'] ?? '',
      attachmentCount: attachmentCount, // Calculate count from attachments
    );
  }

  // Method to convert a Leave instance into a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'tanggal': tanggal,
      'tanggal_mulai': tanggalMulai,
      'tanggal_selesai': tanggalSelesai,
      'type_leave': typeLeave,
      'attachment': attachment,
      'reason': reason,
      'status': status,
      'catatan': catatan,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'approved_by': approvedBy,
    };
  }

  Color getStatusColor() {
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
