import 'package:flutter/material.dart';
import 'package:scb_attendance_app/main.dart';

class ViewAttendanceHistory extends StatelessWidget {
  const ViewAttendanceHistory({super.key});

  static const route = '/view_attendance_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attendance History"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: const Center(
        child: Text(
          "No attendance records yet.",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
    );
  }
}
