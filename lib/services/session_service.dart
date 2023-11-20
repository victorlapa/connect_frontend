import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static Future<void> saveSessionInfo(String token, String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('userId', userId);
  }

  static Future<Map<String, String>> getSessionInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    String userId = prefs.getString('userId') ?? '';
    return {'token': token, 'userId': userId};
  }
}
