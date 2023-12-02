import 'dart:convert';
import 'package:connect_frontend/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  bool _isRegistering = false;
  String _errorMessage = '';

  Future<void> _register() async {
    setState(() {
      _isRegistering = true;
      _errorMessage = ''; // Reset error message when registration starts
    });

    String name = _nameController.text;
    String email = _emailController.text;
    String tag = _usernameController.text;
    String curso = _cursoController.text;
    int periodo = int.tryParse(_periodoController.text) ?? 0;
    String password = _passwordController.text;

    String apiUrl = 'https://catolicaconnect-api.onrender.com/users';

    Map<String, dynamic> requestBody = {
      'name': name,
      'email': email,
      'tag': tag,
      'curso': curso,
      'periodo': periodo,
      'password': password,
    };

    BuildContext? context = navigatorKey.currentContext;

    if (context != null) {
      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(requestBody),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          print('Registration successful');
          Navigator.pushNamed(context, '/login');
        } else {
          print('Registration failed. Status code: ${response.statusCode}');
          _errorMessage = 'Erro - ${response.statusCode} - ${response.body}';
        }
      } catch (error) {
        print('Error during registration: $error');
        _errorMessage = 'Error during registration. Please try again.';
      } finally {
        setState(() {
          _isRegistering = false;
        });
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
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                controller: _periodoController,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Periodo (apenas numeros)',
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
                )),
            SizedBox(height: 16),
            Text(
              _errorMessage,
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (!_isRegistering) {
                  _register();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 167, 33, 65),
              ),
              child: _isRegistering
                  ? CircularProgressIndicator()
                  : Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
