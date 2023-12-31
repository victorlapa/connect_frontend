import 'dart:convert';
import 'package:connect_frontend/models/send_post.dart';
import 'package:connect_frontend/services/session_service.dart';
import 'package:connect_frontend/views/home.dart';
import 'package:connect_frontend/views/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;

class TweetScreen extends StatefulWidget {
  const TweetScreen({Key? key}) : super(key: key);

  @override
  _TweetScreenState createState() => _TweetScreenState();
}

class _TweetScreenState extends State<TweetScreen> {
  String tweetText = "";
  TextEditingController textController = TextEditingController();

  Future<String> retrieveUserId() async {
    Map<String, String> userPayload = await SessionService.getSessionInfo();
    String userId = userPayload['userId'] ?? 'No user ID found';

    return userId;
  }

  Future<void> sendPostRequest() async {
    final url = Uri.parse('https://catolicaconnect-api.onrender.com/posts');

    String userId = await retrieveUserId();

    final sendPostData =
        SendPost(authorId: userId, content: textController.text);

    final data = sendPostData.toJson();

    final String dataJson = jsonEncode(data);

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: dataJson,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Response data: ${response.body}');
      Navigator.pushNamed(context, '/home');
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: GNav(
            gap: 4,
            backgroundColor: Colors.white,
            activeColor: Colors.red,
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
                textColor: Colors.black,
                onPressed: () {
                  if (ModalRoute.of(context)!.settings.name == '/') {
                    // Do nothing if already on the home screen
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                        settings: const RouteSettings(name: '/'),
                      ),
                    );
                  }
                },
              ),
              GButton(
                icon: Icons.post_add,
                text: 'Post',
                textColor: Colors.black,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TweetScreen()),
                  );
                },
              ),
              GButton(
                active: true,
                icon: Icons.person,
                text: 'Profile',
                textColor: Colors.black,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: 'What\'s on your mind?',
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 167, 33, 65),
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 167, 33, 65),
                  ),
                ),
              ),
              maxLength: 280,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => sendPostRequest(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 167, 33, 65),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}
