import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class TodolistScreen extends StatefulWidget {
  @override
  State<TodolistScreen> createState() => _TodolistScreenState();
}

class _TodolistScreenState extends State<TodolistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.95),
      body: SafeArea(
        child: Column(
          children: [
            // AppBar section with back button and TodoDesc
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 16, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainScreen(selectedIndex: 0)),
                      );
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'To-Do List',
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
            const SizedBox(height: 18),

            // Todo cards section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView(
                  children: const [
                    TodoCard(
                      date: 'Tuesday, 8 September 2024',
                      TodoDesc: 'Mengerjakan slicing di menu home',
                    ),
                    TodoCard(
                      date: 'Thursday, 19 September 2024',
                      TodoDesc: 'Mengerjakan slicing di menu profile',
                    ),
                    TodoCard(
                      date: 'Wednesday, 11 September 2024',
                      TodoDesc:
                          'Mengerjakan Slicing di menu history\nMengerjakan slicing menu',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //      MaterialPageRoute(
      //       builder: (context) =>  ApplyTodolistScreen(),
      //     ),
      //     );
      //   },
      //   backgroundColor: const Color(0xFF2A5867),
      //   child: const Icon(
      //     Icons.add,
      //     color: Colors.white,
      //   ),
      //   shape: const CircleBorder(),
      // ),
    );
  }
}

class TodoCard extends StatelessWidget {
  final String date;
  final String TodoDesc;

  const TodoCard({
    required this.date,
    required this.TodoDesc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFFEDF2F3),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Date header
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
                date,
                style: GoogleFonts.dmSans(
                  color: const Color(0xFFEDF2F3),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Card content
          Card(
            color: Colors.white,
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.0),
            ),
            child: InkWell(
              onTap: () {
                // Navigate to detail page for Todo
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            TodoDesc,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            maxLines: 3, // Set maximum lines to display
                            overflow: TextOverflow.ellipsis, // Handle overflow
                          ),
                        ),
                        // const Icon(
                        //   Icons.arrow_forward_ios,
                        //   size: 16,
                        //   color: Colors.grey,
                        // ),
                      ],
                    ),
                    const SizedBox(height: 6),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
