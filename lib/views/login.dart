import 'dart:convert';

import 'package:connect_frontend/main.dart';
import 'package:connect_frontend/services/session_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    BuildContext? context = navigatorKey.currentContext;

    // Adicione o endpoint da sua API para login
    String apiUrl = 'https://catolicaconnect-api.onrender.com/login';

    Map<String, dynamic> requestBody = {
      'email': email,
      'password': password,
    };

    if (context != null) {
      try {
        // Faça uma solicitação POST para a sua API
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(requestBody),
        );

        // Verifique o código de status da resposta
        if (response.statusCode == 200 || response.statusCode == 201) {
          // Login bem-sucedido
          print('Logado com sucesso');

          final Map<String, dynamic> data = json.decode(response.body);

          if (data.containsKey('token')) {
            String token = data['token'];

            Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

            String userId = decodedToken['userId'];

            SessionService.saveSessionInfo(token, userId);

            Navigator.pushNamed(context, '/home');
          }

          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, '/home');
        } else {
          // Falha no login
          print('Falha no login. Código de status: ${response.statusCode}');
        }
      } catch (error) {
        // Manipule quaisquer erros que ocorram durante a solicitação
        print('Erro durante o login: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        backgroundColor: Color.fromARGB(255, 167, 33, 65),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 24), // Ajuste aqui
              child: CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.white,
                child: Image.network(
                  'https://raichu-uploads.s3.amazonaws.com/logo_centro-universitario-catolica-de-santa-catarina_t5Xw1B.png',
                  height: 150,
                  width: 150,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _emailController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 167, 33, 65),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 167, 33, 65),
                        ).copyWith(color: Colors.black.withOpacity(0.5)),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 167, 33, 65),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 167, 33, 65),
                        ).copyWith(color: Colors.black.withOpacity(0.5)),
                      ),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _login,
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 167, 33, 65),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
