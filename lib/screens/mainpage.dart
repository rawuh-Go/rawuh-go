import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_rawuhgo/screens/history_screen.dart';
import 'package:mobile_rawuhgo/screens/notification_screen.dart';
import 'package:mobile_rawuhgo/screens/profile_screen.dart';
import 'package:permission_handler/permission_handler.dart';

class Mainpage extends StatefulWidget {
  static const routeName = '/main-page';

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int _selectedIndex = 0;

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
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define padding and spacing based on screen width
    final horizontalPadding = screenWidth * 0.08; // 8% of screen width
    final avatarSize = screenWidth * 0.12; // 12% of screen width
    final spacingBetweenAvatarAndText =
        screenWidth * 0.04; // 4% of screen width
    final spacingBetweenTextAndIcon = screenWidth * 0.2; // 20% of screen width

    return Scaffold(
      backgroundColor: Color(0xFF212A2E),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
                  child: Container(
                    width: 110,
                    height: 22,
                    decoration: BoxDecoration(
                      color: Color(0xFF2A5867),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        "• PT Git Solution",
                        style: GoogleFonts.dmSans(
                            color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03, // 3% of screen height
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              width: avatarSize,
                              height: avatarSize,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white,
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/img/main_page/user_avatar.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: spacingBetweenAvatarAndText,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Riky Raharjo",
                                  style: GoogleFonts.poppins(
                                    fontSize: screenWidth *
                                        0.04, // 4% of screen width
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Software Developer",
                                  style: GoogleFonts.poppins(
                                    fontSize: screenWidth *
                                        0.035, // 3.5% of screen width
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: spacingBetweenTextAndIcon,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.1, // 10% of screen height
                ),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.95),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Text(
                                "Office Service",
                                style: GoogleFonts.dmSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(height: 3),
                            _buildServiceRow(),
                            _buildSectionHeader("Assigment", Icons.task),
                            SizedBox(height: 10),
                            _buildAssignmentCard(),
                            _buildSectionHeader(
                                "Attendance", Icons.access_alarm),
                            SizedBox(height: 10),
                            _buildAttendanceCard(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                Positioned(
                  top: screenHeight * 0.17,
                  left: screenWidth * 0.1,
                  right: screenWidth * 0.1,
                  child: Container(
                    width: screenWidth * 0.8,
                    height: screenHeight * 0.16,
                    decoration: BoxDecoration(
                      color: Color(0xFF2A5867),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(
                              0.2), // Warna bayangan dengan opasitas
                          spreadRadius: 2, // Jarak sebar bayangan
                          blurRadius: 6, // Jarak blur bayangan
                          offset: Offset(0, 4), // Posisi bayangan (x, y)
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Kamis, 12 September 2024",
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.035,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.01,
                          ),
                          Row(
                            children: [
                              Container(
                                width: screenWidth * 0.35,
                                height: screenHeight * 0.08,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: screenWidth * 0.08,
                                        height: screenWidth * 0.08,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Color(0xFF81CCE3),
                                        ),
                                        child: Image.asset(
                                            'assets/img/main_page/checkin.png'),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.01,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "CHECK IN",
                                            style: GoogleFonts.poppins(
                                              fontSize: screenWidth * 0.035,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF707070),
                                            ),
                                          ),
                                          Text(
                                            "08:10 WIB",
                                            style: GoogleFonts.poppins(
                                              fontSize: screenWidth * 0.03,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF707070),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: screenWidth * 0.02,
                              ),
                              Container(
                                width: screenWidth * 0.35,
                                height: screenHeight * 0.08,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: screenWidth * 0.08,
                                        height: screenWidth * 0.08,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.amber,
                                        ),
                                        child: Image.asset(
                                            'assets/img/main_page/checkout.png'),
                                      ),
                                      SizedBox(
                                        width: screenWidth * 0.01,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "CHECK OUT",
                                            style: GoogleFonts.poppins(
                                              fontSize: screenWidth * 0.035,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF707070),
                                            ),
                                          ),
                                          Text(
                                            "17:00 WIB",
                                            style: GoogleFonts.poppins(
                                              fontSize: screenWidth * 0.03,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF707070),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Meminta izin kamera
          PermissionStatus cameraStatus = await Permission.camera.request();
          if (cameraStatus.isGranted) {
            // Jika izin kamera diberikan, meminta izin lokasi
            PermissionStatus locationStatus =
                await Permission.location.request();
            if (locationStatus.isGranted) {
              // Jika izin lokasi diberikan, arahkan ke CameraScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CameraScreen(),
                ),
              );
            } else {
              // Tampilkan pesan jika izin lokasi ditolak
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text('Izin lokasi diperlukan untuk melanjutkan')),
              );
            }
          } else {
            // Tampilkan pesan jika izin kamera ditolak
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text('Izin kamera diperlukan untuk melanjutkan')),
            );
          }
        },
        backgroundColor: Color(0xFFFEC922),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        child: Icon(
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

  Widget _buildServiceRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildServiceItem("Attendance", "attendance.png"),
        _buildServiceItem("Leave", "leave.png"),
        _buildServiceItem("Assigment", "assigment.png"),
      ],
    );
  }

  Widget _buildServiceItem(String title, String imagePath) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color(0xFFD9D9D9),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 1,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Image.asset('assets/img/main_page/$imagePath'),
          ),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Icon(icon, size: 24), // Menggunakan Icon widget
          SizedBox(width: 5),
          Text(
            title,
            style: GoogleFonts.dmSans(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Spacer(),
          Text(
            "View All",
            style: GoogleFonts.dmSans(
              fontSize: 13,
              fontWeight: FontWeight.w300,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignmentCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFF1F3F6),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Design 2 App Screen",
                      style: GoogleFonts.workSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "Crypto Wallet App",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF7B7B7B),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFFFEC922).withOpacity(0.24),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "• On going",
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFFFEC922),
                    ),
                  ),
                ),
              ],
            ),
            Divider(color: Colors.grey, thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.calendar_month_sharp, size: 15),
                SizedBox(width: 10),
                Text(
                  "Mon, 10 July 2022",
                  style: GoogleFonts.workSans(
                    fontSize: 10,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFF1F3F6),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Yesterday, 6 August 2024 ",
                  style: GoogleFonts.workSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFF64C6E4).withOpacity(0.24),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "• Present",
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Color(0xFF64C6E4),
                    ),
                  ),
                ),
              ],
            ),
            Divider(color: Colors.grey, thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTimeColumn("CHECK IN", "09:00"),
                _buildTimeColumn("CHECK OUT", "17:02"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeColumn(String title, String time) {
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF707070),
          ),
        ),
        Text(
          time,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color(0xFF707070),
          ),
        ),
      ],
    );
  }
}

class CameraScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Screen'),
      ),
      body: Center(
        child: Text('Ini adalah layar kamera'),
      ),
    );
  }
}
