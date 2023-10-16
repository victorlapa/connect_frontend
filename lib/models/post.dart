class Post {
  final String id;
  final String content;
  final String authorId;
  final int groupId;
  final String? imageUrl;
  final int likes;
  final String createdAt;

  Post({
    required this.id,
    required this.authorId,
    required this.content,
    required this.groupId,
    required this.imageUrl,
    required this.likes,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      content: json['content'],
      authorId: json['authorId'],
      groupId: json['groupId'],
      imageUrl: json['imageUrl'],
      likes: json['likes'],
      createdAt: json['createdAt'],
    );
  }
}
