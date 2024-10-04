import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
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
      backgroundColor: const Color(0xFF212A2E),
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
                      color: const Color(0xFF2A5867),
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
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProfileScreen()),
                                );
                              },
                              icon: const Icon(
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
                    decoration: const BoxDecoration(
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
                              padding: const EdgeInsets.only(top: 62),
                              child: Text(
                                "Office Service",
                                style: GoogleFonts.dmSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 3),
                            _buildServiceRow(context),
                            _buildSectionHeader(context, "Assigment",
                                Icons.task, '/assigment-screen'),
                            const SizedBox(height: 10),
                            _buildAssignmentCard(),
                            _buildSectionHeader(context, "Attendance",
                                Icons.access_alarm, '/history'),
                            const SizedBox(height: 10),
                            _buildAttendanceCard(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 130, // Atur posisi vertikal sesuai kebutuhan
              left: 15, // Atur posisi horizontal sesuai kebutuhan
              right: 15,
              child: Container(
                width: 330,
                height: 133,
                decoration: BoxDecoration(
                  color: const Color(0xFF2A5867),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(0.2), // Warna bayangan dengan opasitas
                      spreadRadius: 2, // Jarak sebar bayangan
                      blurRadius: 6, // Jarak blur bayangan
                      offset: const Offset(0, 4), // Posisi bayangan (x, y)
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Kamis, 12 September 2024",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 143,
                            height: 66,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: const Color(0xFF81CCE3),
                                    ),
                                    child: Image.asset(
                                        'assets/img/main_page/checkin.png'),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "CHECK IN",
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF707070)),
                                      ),
                                      Text(
                                        "08:10 WIB",
                                        style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xFF707070)),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 143,
                            height: 66,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.amber,
                                    ),
                                    child: Image.asset(
                                        'assets/img/main_page/checkout.png'),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "CHECK OUT",
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xFF707070)),
                                      ),
                                      Text(
                                        "17:00 WIB",
                                        style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xFF707070)),
                                      ),
                                    ],
                                  )
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
      ),
    );
  }

  Widget _buildServiceRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildServiceItem(context, "Attendance", "attendance.png", '/history'),
        _buildServiceItem(context, "Leave", "leave.png", '/leave-screen'),
        _buildServiceItem(
            context, "Assignment", "assigment.png", '/assigment-screen'),
        _buildServiceItem(
            context, "Todo List", "todo_list.png", '/assigment-screen'),
      ],
    );
  }

  Widget _buildServiceItem(
      BuildContext context, String title, String imagePath, String routeName) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman yang sesuai berdasarkan routeName
        Navigator.pushNamed(context, routeName);
      },
      child: Column(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xFFF1F3F6),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 0,
                  blurRadius: 1,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Image.asset('assets/img/main_page/$imagePath'),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style:
                GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
      BuildContext context, String title, IconData icon, String routeName) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        children: [
          Icon(icon, size: 24), // Menggunakan Icon widget
          const SizedBox(width: 5),
          Text(
            title,
            style: GoogleFonts.dmSans(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          Material(
            color: Colors.transparent, // Make sure the material is transparent
            child: InkWell(
              borderRadius: BorderRadius.circular(8), // Set the border radius
              onTap: () {
                Navigator.pushNamed(context, routeName);
              },
              child: Padding(
                padding: const EdgeInsets.all(
                    8.0), // Add some padding for better touch area
                child: Text(
                  "View All",
                  style: GoogleFonts.dmSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: Colors.blue,
                  ),
                ),
              ),
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
        color: const Color(0xFFF1F3F6),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
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
                        color: const Color(0xFF7B7B7B),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEC922).withOpacity(0.24),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "• On going",
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: const Color(0xFFFEC922),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.grey, thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.calendar_month_sharp, size: 15),
                const SizedBox(width: 10),
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
        color: const Color(0xFFF1F3F6),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
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
                const Spacer(),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF64C6E4).withOpacity(0.24),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "• Present",
                    style: GoogleFonts.dmSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: const Color(0xFF64C6E4),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(color: Colors.grey, thickness: 1),
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
            color: const Color(0xFF707070),
          ),
        ),
        Text(
          time,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF707070),
          ),
        ),
      ],
    );
  }
}
