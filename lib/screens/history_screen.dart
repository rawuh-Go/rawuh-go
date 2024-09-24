import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_rawuhgo/screens/detailattendance_screen.dart';
import 'package:mobile_rawuhgo/screens/mainpage.dart';
import 'package:mobile_rawuhgo/screens/notification_screen.dart';
import 'package:mobile_rawuhgo/screens/profile_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class HistoryScreen extends StatefulWidget {
  static const routeName = '/history-screen';

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int _selectedIndex = 1; // Set the initial index to 1 for HistoryScreen

  final List<Widget> _screens = [
    Mainpage(),
    HistoryScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index != 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => _screens[index],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.90),
      body: SafeArea(
        child: Column(
          children: [
            // Back button dengan teks History
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 16, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios,
                            color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Text(
                        'Back',
                        style: GoogleFonts.dmSans(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'History Attendance',
                    style: GoogleFonts.dmSans(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Content for History Attendance
            Expanded(
              child: ListView.builder(
                itemCount:
                    attendanceData.length, // Number of attendance records
                itemBuilder: (context, index) {
                  final data = attendanceData[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: data['color'],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data['day'],
                                style: GoogleFonts.dmSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: 8, // Adjust the spacing as needed
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AttendanceDetailScreen(data: data),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildCheckInOutColumn(
                                'CHECK IN',
                                data['check_in_status'],
                                data['check_in_time'],
                                data['check_in_color'],
                              ),
                              _buildCheckInOutColumn(
                                'CHECK OUT',
                                data['check_out_status'],
                                data['check_out_time'],
                                data['check_out_color'],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          PermissionStatus cameraStatus = await Permission.camera.request();
          if (cameraStatus.isGranted) {
            PermissionStatus locationStatus =
                await Permission.location.request();
            if (locationStatus.isGranted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CameraScreen(),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Izin lokasi diperlukan untuk melanjutkan')),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Izin kamera diperlukan untuk melanjutkan')),
            );
          }
        },
        backgroundColor: const Color(0xFFFEC922),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        child: const Icon(
          Icons.camera_alt,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildIconButton(0, Icons.home),
            _buildIconButton(1, Icons.access_time),
            SizedBox(width: 48), // Space for the FloatingActionButton
            _buildIconButton(2, Icons.notifications),
            _buildIconButton(3, Icons.person),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(int index, IconData icon) {
    return IconButton(
      onPressed: () {
        setState(() {
          _selectedIndex = index;
        });
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Mainpage()), // Arahkan ke MainPage
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HistoryScreen()), // Arahkan ke HistoryScreen
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      NotificationScreen()), // Arahkan ke NotificationScreen
            );
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ProfileScreen()), // Arahkan ke ProfileScreen
            );
            break;
        }
      },
      icon: Icon(
        icon,
        color: _selectedIndex == index ? Colors.amber : Colors.grey,
      ),
    );
  }

  Widget _buildCheckInOutColumn(
      String title, String status, String time, Color statusColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: GoogleFonts.dmSans(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                status,
                style: GoogleFonts.dmSans(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          time,
          style: GoogleFonts.dmSans(
            fontSize: 12,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

// Sample attendance data
final List<Map<String, dynamic>> attendanceData = [
  {
    'day': 'Monday, 09 September 2024',
    'check_in_status': 'Leaves',
    'check_in_time': '-',
    'check_in_color': Colors.amber,
    'check_out_status': 'Leaves',
    'check_out_time': '-',
    'check_out_color': Colors.amber,
    'color': const Color(0xFFFFF4D5),
  },
  {
    'day': 'Friday, 09 September 2024',
    'check_in_status': 'early',
    'check_in_time': '08:00:00 WIB',
    'check_in_color': Colors.green,
    'check_out_status': 'early',
    'check_out_time': '16:44:05 WIB',
    'check_out_color': Colors.green,
    'color': const Color(0xFFD9F8F5),
  },
  {
    'day': 'Monday, 09 September 2024',
    'check_in_status': 'early',
    'check_in_time': '08:10:00 WIB',
    'check_in_color': Colors.green,
    'check_out_status': 'late',
    'check_out_time': '17:09:00 WIB',
    'check_out_color': Colors.red,
    'color': const Color(0xFFD9F8F5),
  },
  {
    'day': 'Monday, 09 September 2024',
    'check_in_status': 'early',
    'check_in_time': '08:10:00 WIB',
    'check_in_color': Colors.green,
    'check_out_status': 'late',
    'check_out_time': '17:09:00 WIB',
    'check_out_color': Colors.red,
    'color': const Color(0xFFFFF4D5),
  },
  {
    'day': 'Monday, 09 September 2024',
    'check_in_status': 'early',
    'check_in_time': '08:10:00 WIB',
    'check_in_color': Colors.green,
    'check_out_status': 'late',
    'check_out_time': '17:09:00 WIB',
    'check_out_color': Colors.red,
    'color': const Color(0xFFFFF4D5),
  },
];

class CameraScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Screen'),
      ),
      body: const Center(
        child: Text('Ini adalah layar kamera'),
      ),
    );
  }
}
