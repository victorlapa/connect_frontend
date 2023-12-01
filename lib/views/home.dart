import 'dart:convert';
import 'package:connect_frontend/main.dart';
import 'package:connect_frontend/models/post.dart';
import 'package:connect_frontend/views/post_message.dart';
import 'package:connect_frontend/views/profile.dart';
import 'package:connect_frontend/widgets/post_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDarkMode = false;

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
    Color backgroundColor = isDarkMode
        ? Colors.grey[800]!
        : Color.fromARGB(255, 167, 33, 65)
            .withOpacity(0.9); // Ajuste a opacidade aqui
    Color textColor = isDarkMode ? Colors.white : Colors.black;
    Color fabColor = isDarkMode
        ? Colors.grey[800]!
        : Theme.of(context)
            .colorScheme
            .secondary
            .withOpacity(0.9); // Ajuste a opacidade aqui

    return Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[900] : Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            gap: 8,
            activeColor: Colors.red,
            iconSize: 30,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            duration: Duration(milliseconds: 800),
            tabBackgroundColor: Colors.red,
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
                textColor: textColor,
                iconColor: textColor,
                backgroundColor: backgroundColor,
                onPressed: () {
                  if (ModalRoute.of(context)!.settings.name != '/') {
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
                textColor: textColor,
                iconColor: textColor,
                backgroundColor: backgroundColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TweetScreen(),
                    ),
                  );
                },
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
                textColor: textColor,
                iconColor: textColor,
                backgroundColor: backgroundColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
              ),
            ],
            selectedIndex: 0,
            onTabChange: (index) {},
          ),
        ),
      ),
      body: Container(
        child: FutureBuilder<List<Post>>(
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
              print(snapshot.error);
              return Center(
                child: Text(
                  'An error occurred: ${snapshot.error}',
                  style: TextStyle(color: textColor),
                ),
              );
            }
            return Center(
              child: Text(
                'Failed to load posts. Please check your network connection and try again.',
                style: TextStyle(color: textColor),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isDarkMode = !isDarkMode;
          });
        },
        backgroundColor: fabColor,
        child: Icon(
          isDarkMode ? Icons.light_mode : Icons.dark_mode,
          color: Colors.white,
        ),
      ),
    );
  }
}
