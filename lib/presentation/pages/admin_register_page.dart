import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scb_attendance_app/main.dart';

class AdminRegisterPage extends StatefulWidget {
  const AdminRegisterPage({super.key});

  static const route = '/admin_register_page';

  @override
  State<AdminRegisterPage> createState() => _AdminRegisterPageState();
}

class _AdminRegisterPageState extends State<AdminRegisterPage> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                navigatorKey.currentState?.pop();
              },
            ),
            const SizedBox(height: 10),
            const Text(
              "Admin Register 👨‍💼",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              "Elevate Your HR Management with SCBA.",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // Email Field
            TextField(
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: const Icon(Icons.email_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Password Field
            TextField(
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: "Password",
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Confirm Password Field
            TextField(
              obscureText: _obscureConfirmPassword,
              decoration: InputDecoration(
                labelText: "Confirm Password",
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirmPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureConfirmPassword = !_obscureConfirmPassword;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Sign Up Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6E61FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Sign up",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  static Widget _buildSocialButton(IconData icon, String text) {
    return SizedBox(
      width: 400,
      height: 50,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: const BorderSide(color: Colors.grey),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: () {},
        icon: FaIcon(icon, color: Colors.black),
        label: SizedBox(
          width: 200,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
