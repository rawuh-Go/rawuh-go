import 'package:flutter/material.dart';

class AssigmentScreen extends StatefulWidget {
  static const routeName = '/assigment-screen';

  @override
  State<AssigmentScreen> createState() => _AssigmentScreenState();
}

class _AssigmentScreenState extends State<AssigmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assigment'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AssigmentCard(
              date: 'Tuesday, 8 September 2024',
              title: 'Sick Assigment',
              description: 'Opname di Rs harapan',
              AssigmentDate: '8 Sep 2024',
              attachmentCount: 1,
              status: 'Approved',
              statusColor: Colors.green,
            ),
            AssigmentCard(
              date: 'Thursday, 19 September 2024',
              title: 'Marriage Assigment',
              description: 'Cuti menikah 3 hari',
              AssigmentDate: '27 Sep 2024 - 29 Sep 2024',
              attachmentCount: 1,
              status: 'Waiting for Approved',
              statusColor: Colors.orange,
            ),
            AssigmentCard(
              date: 'Wednesday, 11 September 2024',
              title: 'Sick Assigment',
              description: 'Sakit flu',
              AssigmentDate: '11 Aug 2024',
              attachmentCount: 0,
              status: '',
              statusColor: Colors.transparent,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

class AssigmentCard extends StatelessWidget {
  final String date;
  final String title;
  final String description;
  final String AssigmentDate;
  final int attachmentCount;
  final String status;
  final Color statusColor;

  const AssigmentCard({
    required this.date,
    required this.title,
    required this.description,
    required this.AssigmentDate,
    required this.attachmentCount,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(description),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 16),
                          SizedBox(width: 4),
                          Text(AssigmentDate),
                        ],
                      ),
                      if (attachmentCount > 0)
                        Row(
                          children: [
                            Icon(Icons.attach_file, size: 16),
                            SizedBox(width: 4),
                            Text('$attachmentCount Attachment(s)'),
                          ],
                        ),
                    ],
                  ),
                ),
                if (status.isNotEmpty)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
