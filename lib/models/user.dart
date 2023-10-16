import 'group.dart';
import 'post.dart';

class User {
  final String id;
  final String tag;
  final String name;
  final String email;
  final String curso;
  final int periodo;
  final String? description;
  final List<Post> posts;
  final List<Group> groupId;
  final DateTime createdAt;

  User(
      {required this.id,
      required this.tag,
      required this.name,
      required this.email,
      required this.curso,
      required this.periodo,
      this.description,
      required this.posts,
      required this.groupId,
      required this.createdAt});
}
