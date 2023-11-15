import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.red[700],
        body: Center(
          child: Column(
            children: [
              Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAZyuxlqCwikuczIZyxFPMcSDFsPFUSpc2izpdUMKYayDww9DYSb0-Bxa7UWZESLRKs3w&usqp=CAU',
                height: 150,
                width: 150,
              ),
              ElevatedButton(
                  onPressed: () {}, child: const Text('Cadastre-se')),
              ElevatedButton(onPressed: () {}, child: const Text('Entrar')),
            ],
          ),
        ));
  }
}
