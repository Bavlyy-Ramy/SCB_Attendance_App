import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:scb_attendance_app/firebase_options.dart';
import 'package:scb_attendance_app/presentation/pages/admin_register_page.dart';
import 'package:scb_attendance_app/presentation/pages/login_page.dart';
import 'package:scb_attendance_app/presentation/pages/register_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      home: LoginPage(),
      routes: {
        LoginPage.route: (context) => LoginPage(),
        RegisterPage.route: (context) => RegisterPage(),
        AdminRegisterPage.route: (context) => AdminRegisterPage(),
      },
    );
  }
}
