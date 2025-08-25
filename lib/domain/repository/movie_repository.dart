import 'package:flutter_movie_info/domain/entity/movie.dart';

abstract interface class MovieRepository {
  Future<List<Movie>> fetchMovies();
}
