import 'package:connect_frontend/services/session_service.dart';
import 'package:connect_frontend/services/user_service.dart';
import 'package:connect_frontend/views/edit_profile.dart';
import 'package:connect_frontend/views/home.dart';
import 'package:connect_frontend/views/login.dart';
import 'package:connect_frontend/views/profile.dart';
import 'package:connect_frontend/views/register.dart';
import 'package:connect_frontend/views/welcome.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: MaterialApp(
      title: 'Home',
      initialRoute: "/",
      navigatorKey: navigatorKey,
      theme: ThemeData(primarySwatch: Colors.red),
      routes: {
        '/': (context) => const Welcome(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    ));
  }
}
