class Author {
  final String name;
  final String tag;
  final String curso;
  final int periodo;
  final String? description;
  final String profileImgUrl;

  Author({
    required this.name,
    required this.tag,
    required this.curso,
    required this.periodo,
    required this.description,
    required this.profileImgUrl,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      name: json['name'],
      tag: json['tag'],
      curso: json['curso'],
      periodo: json['periodo'],
      description: json['description'],
      profileImgUrl: json['profileImgUrl'],
    );
  }
}
