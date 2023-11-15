import 'package:connect_frontend/models/group.dart';
import 'package:connect_frontend/models/user.dart';
import 'package:connect_frontend/views/home.dart';
import 'package:connect_frontend/views/wip.dart';
import 'package:connect_frontend/widgets/group_list.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Future<List<Group>> fetchGroups() async {
  //   List<Group> groups = [
  //     Group(
  //         createdAt: DateTime.now(),
  //         id: 1,
  //         name: 'Grupo 1',
  //         createdBy: 'Eu',
  //         description: 'Grupitos',
  //         posts: List.empty(),
  //         users: List.empty()),
  //   ];

  //   return groups;
  // }

  @override
  Widget build(BuildContext context) {
    final List<Group> groups = [
      Group(
          createdAt: DateTime.now(),
          id: 1,
          name: 'Grupo 1',
          createdBy: 'Eu',
          description: 'Grupitos',
          posts: List.empty(),
          users: List.empty()),
    ];

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
                              builder: (context) => const ProfileScreen()));
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
                            'https://media.licdn.com/dms/image/D4D03AQGaFUImrwVdBw/profile-displayphoto-shrink_800_800/0/1693440924194?e=2147483647&v=beta&t=Gc0esUSYyWbXO6OFcZU4nNzJmRNg8XQzyVk9c4QYdsQ',
                          ),
                        ),
                        Container(
                          height: 24,
                        ),
                        const Text(
                          'Agos Rufino',
                          style: TextStyle(color: Colors.black, fontSize: 24),
                        ),
                        Container(
                          height: 4,
                        ),
                        const Text(
                          'Eng. de Software - 4/8',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        Container(
                          height: 16,
                        ),
                      ],
                    ),
                    const Row(
                      children: [
                        Text('Fala galeraa'),
                      ],
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
