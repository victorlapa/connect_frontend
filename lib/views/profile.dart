import 'package:connect_frontend/models/post.dart';
import 'package:connect_frontend/services/session_service.dart';
import 'package:connect_frontend/services/user_service.dart';
import 'package:connect_frontend/views/home.dart';
import 'package:connect_frontend/views/wip.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ProfileScreen extends StatefulWidget {
  final String? userId;

  const ProfileScreen({Key? key, this.userId}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Map<String, dynamic>> _userFuture;
  late Future<Map<String, dynamic>> _user;

  @override
  void initState() {
    super.initState();
    _userFuture = widget.userId != null
        ? UserService.getUserById(widget.userId!)
        : SessionService.getSessionInfo().then((userInfo) {
            final userId = userInfo['userId'] ?? '';
            return UserService.getUserById(userId);
          });

    _user = _userFuture;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _user,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // or a loading indicator
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No user information found.');
        } else {
          final user = snapshot.data!['user'];
          final List<dynamic> posts = user['posts'];

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
                          icon: Icons.person,
                          text: 'Profile',
                          textColor: Colors.black,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProfileScreen()));
                          }),
                      GButton(
                          icon: Icons.search,
                          text: 'Search',
                          textColor: Colors.black,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const WipScreen()));
                          }),
                      GButton(
                          icon: Icons.settings,
                          text: 'Settings',
                          textColor: Colors.black,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const WipScreen()));
                          }),
                    ],
                  )),
            ),
            body: Column(
              children: [
                Material(
                  child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(60.0),
                                child: Image.network(
                                  height: 120,
                                  width: 120,
                                  '${user['profileImgUrl']}',
                                ),
                              ),
                              Container(
                                height: 24,
                              ),
                              Text(
                                user['name'],
                                style: TextStyle(
                                    color: Colors.black, fontSize: 24),
                              ),
                              Container(
                                height: 4,
                              ),
                              Text(
                                user['curso'],
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                              Container(
                                height: 16,
                              ),
                              Text('Últimas mensagens'),
                              Container(height: 16),
                              Column(
                                children: [
                                  for (var post in posts) ...[
                                    Text(post['content']),
                                  ],
                                ],
                              )
                            ],
                          ),
                        ],
                      )),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
