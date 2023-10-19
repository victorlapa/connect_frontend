import 'package:connect_frontend/views/home.dart';
import 'package:connect_frontend/views/profile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: MaterialApp(
      title: 'Home',
      initialRoute: "/",
      theme: ThemeData(primarySwatch: Colors.red),
      routes: {
        '/': (context) => const ProfileScreen(),
        '/userProfilePage': (context) => const ProfileScreen()
      },
    ));
  }
}
