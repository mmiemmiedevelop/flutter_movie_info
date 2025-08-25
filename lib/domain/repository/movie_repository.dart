import 'package:flutter_movie_info/domain/entity/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> fetchMovies();
  Future<List<Movie>> fetchMoviesByEndpoint(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  });
}
