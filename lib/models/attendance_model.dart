import 'package:intl/intl.dart';

class Attendance {
  final int id; // ID attendance
  final String day; // Tanggal
  final String checkInStatus; // Status check-in
  final String checkInTime; // Waktu check-in
  final String checkOutStatus; // Status check-out
  final String checkOutTime; // Waktu check-out
  final double datangLatitude; // Latitude check-in
  final double datangLongitude; // Longitude check-in
  final double pulangLatitude; // Latitude check-out
  final double pulangLongitude; // Longitude check-out
  final String fotoAbsenDatang; // Foto check-in
  final String fotoAbsenPulang; // Foto check-out
  final String scheduleWaktuDatang; // Jadwal waktu datang
  final String scheduleWaktuPulang; // Jadwal waktu pulang

  Attendance({
    required this.id,
    required this.day,
    required this.checkInStatus,
    required this.checkInTime,
    required this.checkOutStatus,
    required this.checkOutTime,
    required this.datangLatitude,
    required this.datangLongitude,
    required this.pulangLatitude,
    required this.pulangLongitude,
    required this.fotoAbsenDatang,
    required this.fotoAbsenPulang,
    required this.scheduleWaktuDatang, // Tambahkan jadwal waktu datang
    required this.scheduleWaktuPulang, // Tambahkan jadwal waktu pulang
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    // Parse created_at to a DateTime object to extract date
    DateTime createdAt = DateTime.parse(json['created_at']);
    String formattedDate = DateFormat('dd MMMM yyyy').format(createdAt);

    // Parse waktu_masuk and waktu_pulang to DateTime
    DateTime waktuDatang = DateTime.parse(json['waktu_datang']);
    DateTime waktuPulang = DateTime.parse(json['waktu_pulang']);

    // Parse schedule times to String
    String scheduleDatang = json['schedule_waktu_datang'];
    String schedulePulang = json['schedule_waktu_pulang'];

    // Determine check-in and check-out statuses
    String checkInStatus = waktuDatang.isBefore(DateTime.parse(
                '${createdAt.toIso8601String().split("T")[0]} $scheduleDatang')) ||
            waktuDatang.isAtSameMomentAs(DateTime.parse(
                '${createdAt.toIso8601String().split("T")[0]} $scheduleDatang'))
        ? 'early'
        : 'late';

    String checkOutStatus = waktuPulang.isBefore(DateTime.parse(
                '${createdAt.toIso8601String().split("T")[0]} $schedulePulang')) ||
            waktuPulang.isAtSameMomentAs(DateTime.parse(
                '${createdAt.toIso8601String().split("T")[0]} $schedulePulang'))
        ? 'early'
        : 'late';

    String checkInTimeFormatted = DateFormat('HH:mm:ss').format(waktuDatang);
    String checkOutTimeFormatted = DateFormat('HH:mm:ss').format(waktuPulang);

    return Attendance(
      id: json['id'],
      day: formattedDate,
      checkInStatus: checkInStatus,
      checkInTime: checkInTimeFormatted, // Ganti dengan format baru
      checkOutStatus: checkOutStatus,
      checkOutTime: checkOutTimeFormatted, // Ganti dengan format baru
      datangLatitude: json['datang_latitude'],
      datangLongitude: json['datang_longitude'],
      pulangLatitude: json['pulang_latitude'],
      pulangLongitude: json['pulang_longitude'],
      fotoAbsenDatang: json['foto_absen_datang'] ?? '', // Handle null
      fotoAbsenPulang: json['foto_absen_pulang'] ?? '', // Handle null
      scheduleWaktuDatang: scheduleDatang, // Ambil schedule waktu datang
      scheduleWaktuPulang: schedulePulang, // Ambil schedule waktu pulang
    );
  }
}
