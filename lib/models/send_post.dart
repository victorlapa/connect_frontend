class SendPost {
  final String content;
  final String authorId;

  SendPost({
    required this.authorId,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'authorId': authorId,
    };
  }
}
