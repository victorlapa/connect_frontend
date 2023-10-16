import 'package:connect_frontend/models/group.dart';
import 'package:flutter/material.dart';

class UserGroupList extends StatelessWidget {
  final List<Group> groups;

  const UserGroupList({Key? key, required this.groups}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: groups.length,
      itemBuilder: (context, index) {
        final group = groups[index];

        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Row(
                children: [
                  Image.network(
                    'https://i.kym-cdn.com/photos/images/newsfeed/000/242/592/1c8.jpg',
                    width: 40,
                    height: 40,
                  ),
                  Text(group.name),
                  Text(group.description),
                ],
              )
            ]));
      },
    );
  }
}
