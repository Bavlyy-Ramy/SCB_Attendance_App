import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scb_attendance_app/main.dart';
import 'package:scb_attendance_app/presentation/pages/register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const route = '/Login_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 100),
            const Text(
              "Welcome Back 👋",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              "Log in and manage HR tasks with ease",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 35),
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
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: const Icon(Icons.visibility_off_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(color: Color(0xFF6E61FF)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("or"),
                ),
                Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 20),
            _buildSocialButton(FontAwesomeIcons.google, "Continue with Google"),
            const SizedBox(height: 10),
            _buildSocialButton(FontAwesomeIcons.apple, "Continue with Apple"),
            const SizedBox(height: 10),
            _buildSocialButton(
              FontAwesomeIcons.facebook,
              "Continue with Facebook",
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6E61FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Log in",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                const SizedBox(width: 5),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero, 
                    minimumSize: Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {
                  
                    navigatorKey.currentState?.pushNamed(RegisterPage.route);
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(color: Color(0xFF6E61FF)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildSocialButton(IconData icon, String text) {
    return Container(
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
        iconAlignment: IconAlignment.start,
        label: Container(
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
