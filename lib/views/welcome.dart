import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 167, 33, 65),
      body: Column(
        children: [
          Container(height: 100),
          Image.network(
            'https://raichu-uploads.s3.amazonaws.com/logo_centro-universitario-catolica-de-santa-catarina_t5Xw1B.png',
            height: 150,
            width: 150,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 48,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: 20),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.transparent, // Text color
                  side: BorderSide(
                      color: Colors.white, width: 2), // Border color and width
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: const Text('Cadastre-se')),
          ),
          Container(height: 16),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: 48,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: 20),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.transparent, // Text color
                  side: BorderSide(
                      color: Colors.white, width: 2), // Border color and width
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('Entrar')),
          ),
        ],
      ),
    );
  }
}
