import 'package:connect_frontend/models/post.dart';
import 'package:connect_frontend/views/profile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

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
              elevation: 0,
              color: Colors.transparent,
              margin: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ProfileScreen(userId: post.authorId),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(
                        height: 40,
                        width: 40,
                        post.author.profileImgUrl,
                      ),
                    ),
                  ),
                  Container(
                    width: 12,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          post.author.name,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.white),
                        ),
                        Text(
                          '${post.author.curso} - ${post.author.periodo} - ${formatRelativeTime(post.createdAt)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Container(
                          height: 24,
                        ),
                        Text(
                          post.content,
                          style: const TextStyle(color: Colors.white),
                          maxLines: 100,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}

String formatRelativeTime(String dateString) {
  DateTime dateTime = DateTime.parse(dateString).toLocal();
  Duration timeDifference = DateTime.now().toLocal().difference(dateTime);

  String relativeTime = timeago.format(dateTime.subtract(timeDifference));

  return relativeTime;
}
