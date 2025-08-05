import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scb_attendance_app/firebase_options.dart';
import 'package:scb_attendance_app/injection_container.dart' as di;
import 'package:scb_attendance_app/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:scb_attendance_app/presentation/pages/admin_register_page.dart';
import 'package:scb_attendance_app/presentation/pages/home_page.dart';
import 'package:scb_attendance_app/presentation/pages/login_page.dart';
import 'package:scb_attendance_app/presentation/pages/register_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();
  runApp(const SCBAttendace());
}

class SCBAttendace extends StatelessWidget {
  const SCBAttendace({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(
            loginUseCase: di.sl(), // from injection_container.dart
            registerUseCase: di.sl(),
            getCurrentUserUseCase: di.sl(),
            signOutUseCase: di.sl(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        home: const HomePage(),
        routes: {
          LoginPage.route: (context) => const LoginPage(),
          RegisterPage.route: (context) => const RegisterPage(),
          AdminRegisterPage.route: (context) => const AdminRegisterPage(),
          HomePage.route: (context) => const HomePage(),
        },
      ),
    );
  }
}
