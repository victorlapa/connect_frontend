import 'dart:convert';

import 'package:connect_frontend/main.dart';
import 'package:connect_frontend/services/session_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

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

    // Add your API endpoint for registration
    String apiUrl = 'https://catolicaconnect-api.onrender.com/login';

    Map<String, dynamic> requestBody = {
      'email': email,
      'password': password,
    };

    if (context != null) {
      try {
        // Make a POST request to your API
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(requestBody),
        );

        // Check the status code of the response
        if (response.statusCode == 200 || response.statusCode == 201) {
          // Registration successful
          print('Logged in successfully');

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
          // Registration failed
          print('Registration failed. Status code: ${response.statusCode}');
        }
      } catch (error) {
        // Handle any errors that occurred during the request
        print('Error during registration: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
