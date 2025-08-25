import 'package:flutter_movie_info/data/dto/movie_dto.dart';

class MovieResponseDto {
  final List<MovieDto> results;

  MovieResponseDto({
    required this.results
  });

  MovieResponseDto.fromJson(Map<String, dynamic> json)
    : this(
        results: (json['results'] as List)
            .map((result) => MovieDto.fromJson(result))
            .toList()
      );

  Map<String, dynamic> toJson() => {
    'results': results.map((result) => result.toJson()).toList()
  };
}
