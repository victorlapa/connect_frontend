import 'dart:convert';

import 'package:http/http.dart' as http;

class UserService {
  static Future<Map<String, dynamic>> getUserById(String userId) async {
    final response = await http.get(
      Uri.parse('https://catolicaconnect-api.onrender.com/users/$userId'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> userData = json.decode(response.body);

      print(userData);
      print('user');

      return userData;
    } else {
      throw Exception('Failed to load user details');
    }
  }
}
