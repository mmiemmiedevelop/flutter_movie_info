import 'package:flutter_movie_info/data/data_source/movie_data_source.dart';
import 'package:flutter_movie_info/config/api_config.dart';
import 'package:flutter_movie_info/domain/entity/movie.dart';
import 'package:flutter_movie_info/domain/repository/movie_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieRepositoryImpl implements MovieRepository {
  MovieRepositoryImpl(this._movieDataSource);
  final MovieDataSource _movieDataSource;

  @override
  Future<List<Movie>> fetchMovies() async {
    final movieDtos = await _movieDataSource.fetchMovies();
    return movieDtos.map((dto) => Movie(
          title: dto.title,
          poster_path: ApiConfig.imageBaseUrl + dto.poster_path,
        )).toList();
  }

  @override
  Future<List<Movie>> fetchMoviesByEndpoint(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    final movieDtos = await _movieDataSource.fetchMoviesByEndpoint(
      endpoint,
      queryParams: queryParams,
    );
    return movieDtos.map((dto) => Movie(
          title: dto.title,
          poster_path: ApiConfig.imageBaseUrl + dto.poster_path,
        )).toList();
  }
}

final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  final dataSource = ref.watch(movieDataSourceProvider);
  return MovieRepositoryImpl(dataSource);
});
