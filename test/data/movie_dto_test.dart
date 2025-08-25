import 'dart:convert';

import 'package:flutter_movie_info/data/dto/movie_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('MovieDto : fromJson test', () {
    // Given
    const sampleJsonString = """
  {
    "title": "Avatar",
    "poster_path": "/jRXYjXNq0Cs2TcJjLkki24MLp7u.jpg",
    "id": 19995
  }
""";

    // When
    final movie = MovieDto.fromJson(jsonDecode(sampleJsonString));

    // Then
    expect(movie.title, "Avatar");
    expect(movie.poster_path, "/jRXYjXNq0Cs2TcJjLkki24MLp7u.jpg");
    expect(movie.id, 19995);
  });

  test('MovieDto : toJson test', () {
    // Given
    final movie = MovieDto(
      title: "Avatar",
      poster_path: "/jRXYjXNq0Cs2TcJjLkki24MLp7u.jpg",
      id: 19995,
    );

    // When
    final json = movie.toJson();

    // Then
    expect(json['title'], "Avatar");
    expect(json['poster_path'], "/jRXYjXNq0Cs2TcJjLkki24MLp7u.jpg");
    expect(json['id'], 19995);
  });

  test('MovieDto : copyWith test', () {
    // Given
    final originalMovie = MovieDto(
      title: "Avatar",
      poster_path: "/jRXYjXNq0Cs2TcJjLkki24MLp7u.jpg",
      id: 19995,
    );

    // When
    final updatedMovie = originalMovie.copyWith(
      title: "Avatar: The Way of Water",
      id: 76600,
    );

    // Then
    expect(updatedMovie.title, "Avatar: The Way of Water");
    expect(
      updatedMovie.poster_path,
      "/jRXYjXNq0Cs2TcJjLkki24MLp7u.jpg",
    ); // 변경되지 않음
    expect(updatedMovie.id, 76600);
  });
}
