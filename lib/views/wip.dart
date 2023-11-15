import 'package:flutter/material.dart';

class WipScreen extends StatelessWidget {
  const WipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red[900],
          iconTheme: const IconThemeData(color: Colors.white)),
      body: const Center(child: Text('Work in progress, come back later')),
    );
  }
}
