import 'package:flutter_movie_info/data/data_source/movie_api_data_source_impl.dart';
import 'package:flutter_movie_info/data/dto/movie_dto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

abstract class MovieDataSource {
  Future<List<MovieDto>> fetchMovies();
  Future<List<MovieDto>> fetchMoviesByEndpoint(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  });
}

final movieDataSourceProvider = Provider<MovieDataSource>((ref) {
    return MovieApiDataSourceImpl(http.Client());
});
