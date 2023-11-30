import 'dart:convert';

import 'package:connect_frontend/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cursoController = TextEditingController();
  final TextEditingController _periodoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _register() async {
    String name = _nameController.text;
    String email = _emailController.text;
    String tag = _usernameController.text;
    String curso = _cursoController.text;
    int periodo = int.parse(_periodoController.text);
    String password = _passwordController.text;

    BuildContext? context = navigatorKey.currentContext;

    // Add your API endpoint for registration
    String apiUrl = 'https://catolicaconnect-api.onrender.com/users';

    Map<String, dynamic> requestBody = {
      'name': name,
      'email': email,
      'tag': tag,
      'curso': curso,
      'periodo': periodo,
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
          print('Registration successful');

          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, '/login');
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
        title: Text('Register Page'),
        backgroundColor: Color.fromARGB(255, 167, 33, 65),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Nome completo',
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
              controller: _usernameController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Username',
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
            TextField(
              controller: _cursoController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Curso',
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
              controller: _periodoController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelText: 'Periodo',
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
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: _register,
              child: Text('Register'),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 167, 33, 65),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
