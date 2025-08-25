class MovieDto {
  final String title;
  final String poster_path;
  final int id;

  MovieDto({
    required this.title,
    required this.poster_path,
    required this.id,
  });

  MovieDto copyWith({
    String? title,
    String? poster_path,
    int? id,
  }) =>
      MovieDto(
        title: title ?? this.title,
        poster_path: poster_path ?? this.poster_path,
        id: id ?? this.id,
      );

  MovieDto.fromJson(Map<String, dynamic> json)
      : this(
          title: json["title"],
          poster_path: json["poster_path"],
          id: json["id"],
        );

  Map<String, dynamic> toJson() => {
        "title": title,
        "poster_path": poster_path,
        "id": id,
      };
}
