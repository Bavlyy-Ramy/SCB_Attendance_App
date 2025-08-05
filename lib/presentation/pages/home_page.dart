import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const route = '/home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? clockInTime;
  DateTime? clockOutTime;

  void handleAttendanceButton() async {
    setState(() {
      if (clockInTime == null) {
        clockInTime = DateTime.now();
      } else if (clockOutTime == null) {
        clockOutTime = DateTime.now();
      }
    });

    // Show confirmation dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Expanded(child: Text("Submitting attendance...")),
          ],
        ),
      ),
    );

    await Future.delayed(const Duration(seconds: 1));
    if (mounted) Navigator.pop(context); // close loading dialog

    // Show success
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Success 🎉"),
        content: Text(clockOutTime == null ? "Clocked in!" : "Clocked out!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (clockOutTime != null) {
                // Reset times after showing dialog
                Future.delayed(const Duration(milliseconds: 300), () {
                  setState(() {
                    clockInTime = null;
                    clockOutTime = null;
                  });
                });
              }
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  String getFormattedTime(DateTime? time) {
    return time != null ? DateFormat('hh:mm a').format(time) : '--:--';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: const Color(0xFF6E61FF),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Task'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF6E61FF),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/avatar.png'),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Mr. Bavly Ramy',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Mark Your Attendance',
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              DateFormat('kk:mm').format(DateTime.now()),
              style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            Text(
              DateFormat('MMMM dd, yyyy - EEEE').format(DateTime.now()),
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: handleAttendanceButton,
              style: ElevatedButton.styleFrom(
                backgroundColor: clockInTime == null
                    ? Colors.green
                    : Colors.red,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(35),
              ),
              child: Text(
                clockInTime == null ? 'CLOCK IN' : 'CLOCK OUT',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Icon(Icons.login, color: Colors.green),
                          const SizedBox(height: 5),
                          Text(getFormattedTime(clockInTime)),
                          const Text(
                            'Clock In',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Icon(Icons.logout, color: Colors.red),
                          const SizedBox(height: 5),
                          Text(getFormattedTime(clockOutTime)),
                          const Text(
                            'Clock Out',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Icon(Icons.access_time, color: Colors.blue),
                          const SizedBox(height: 5),
                          Text(
                            clockInTime != null && clockOutTime != null
                                ? "${clockOutTime!.difference(clockInTime!).inMinutes} min"
                                : '--',
                          ),
                          const Text(
                            'Total Minutes',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF6E61FF),
                side: const BorderSide(color: Color(0xFF6E61FF)),
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
              child: const Text("View your attendance"),
            ),
          ],
        ),
      ),
    );
  }
}
