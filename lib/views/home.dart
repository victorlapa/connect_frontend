import 'dart:convert';
import 'package:connect_frontend/main.dart';
import 'package:connect_frontend/models/post.dart';
import 'package:connect_frontend/views/post_message.dart';
import 'package:connect_frontend/views/profile.dart';
import 'package:connect_frontend/views/wip.dart';
import 'package:connect_frontend/widgets/post_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<Post>> fetchPosts() async {
    final response = await http
        .get(Uri.parse('https://catolicaconnect-api.onrender.com/posts'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data.containsKey('posts')) {
        final postList = data['posts'] as List<dynamic>;

        final List<Post> posts = postList.map((e) {
          return Post.fromJson(e);
        }).toList();

        return posts;
      } else {
        throw Exception('No "posts" key in the response');
      }
    } else {
      throw Exception('Failed to load posts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
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
                      if (ModalRoute.of(context)!.settings.name != '/') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                              settings: const RouteSettings(name: '/'),
                            ));
                      }
                    }),
                GButton(
                    icon: Icons.post_add,
                    text: 'Post',
                    textColor: Colors.black,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TweetScreen()));
                    }),
                GButton(
                    icon: Icons.person,
                    text: 'Profile',
                    textColor: Colors.black,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfileScreen()));
                    }),
              ],
            )),
      ),
      body: FutureBuilder<List<Post>>(
        future: fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            final response = snapshot.data!;

            final postList = response;

            return PostListWidget(posts: postList);
          }
          if (snapshot.hasError) {
            // ignore: avoid_print
            print(snapshot.error);

            return Center(
              child: Text('An error occurred: ${snapshot.error}'),
            );
          }
          return const Center(
            child: Text(
                'Failed to load posts. Please check your network connection and try again.'),
          );
        },
      ),
    );
  }
}
