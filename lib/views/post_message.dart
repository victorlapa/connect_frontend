import 'dart:convert';

import 'package:connect_frontend/models/send_post.dart';
import 'package:connect_frontend/services/session_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TweetScreen extends StatefulWidget {
  const TweetScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
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

    // Check the status code to determine if the request was successful.
    if (response.statusCode == 200) {
      // Request was successful, and you can work with the response data.
      print('Response data: ${response.body}');

      Navigator.pushNamed(context, '/home');
    } else {
      // Request failed, handle the error.
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tweet Message Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: textController,
              decoration:
                  const InputDecoration(labelText: 'What\'s on your mind?'),
              maxLength: 280, // Optional character limit
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                tweetText,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => sendPostRequest(),
                  color: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
