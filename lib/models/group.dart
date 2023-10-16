import 'post.dart';
import 'user.dart';

class Group {
  final int id;
  final String name;
  final String description;
  final List<Post> posts;
  final List<User> users;
  final String createdBy;
  final DateTime createdAt;

  Group(
      {required this.id,
      required this.name,
      required this.description,
      required this.posts,
      required this.users,
      required this.createdBy,
      required this.createdAt});
}

/*
model Group {
  id Int @id @default(autoincrement())
  name String @unique
  description String @default("")
  posts Post[]
  users User[]
  createdBy String
  createdAt DateTime @default(now())
}
*/