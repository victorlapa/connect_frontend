import 'dart:convert';

import 'package:connect_frontend/models/user.dart';
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

  static Future<Map<String, dynamic>?> getUserByIdAsync(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('https://catolicaconnect-api.onrender.com/users/$userId'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = json.decode(response.body);
        return userData;
      } else {
        throw Exception('Failed to load user details');
      }
    } catch (e) {
      print('Error in getUserById: $e');
      return null;
    }
  }
}
