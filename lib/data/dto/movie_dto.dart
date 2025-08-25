class MovieDto {
  final String title;
  final String poster_path;

  MovieDto({
    required this.title,
    required this.poster_path,
  });

  MovieDto copyWith({
    String? title,
    String? poster_path,
  }) =>
      MovieDto(
        title: title ?? this.title,
        poster_path: poster_path ?? this.poster_path,
      );

  MovieDto.fromJson(Map<String, dynamic> json)
      : this(
          title: json["title"],
          poster_path: json["poster_path"],
        );

  Map<String, dynamic> toJson() => {
        "title": title,
        "poster_path": poster_path,
      };
}
