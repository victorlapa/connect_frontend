import 'package:connect_frontend/models/post.dart';
import 'package:connect_frontend/views/profile.dart';
import 'package:flutter/material.dart';

class PostListWidget extends StatelessWidget {
  final List<Post> posts;

  const PostListWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];

        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shadowColor: Colors.black,
              margin: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(
                        height: 40,
                        width: 40,
                        'https://media.licdn.com/dms/image/D4D03AQGaFUImrwVdBw/profile-displayphoto-shrink_800_800/0/1693440924194?e=2147483647&v=beta&t=Gc0esUSYyWbXO6OFcZU4nNzJmRNg8XQzyVk9c4QYdsQ',
                      ),
                    ),
                  ),
                  Container(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Agos Dalcin Rufino',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      const Text('Eng. de Software',
                          textAlign: TextAlign.start),
                      Container(
                        height: 24,
                      ),
                      Text(post.content),
                    ],
                  )
                ],
              ),
            ));
      },
    );
  }
}
