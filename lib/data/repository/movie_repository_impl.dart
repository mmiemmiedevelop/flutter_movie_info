import 'package:flutter_movie_info/data/data_source/movie_data_source.dart';
import 'package:flutter_movie_info/domain/entity/movie.dart';
import 'package:flutter_movie_info/domain/repository/movie_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_movie_info/config/api_config.dart';

class MovieRepositoryImpl implements MovieRepository {
  MovieRepositoryImpl(this._movieDataSource);
  final MovieDataSource _movieDataSource;

  @override
  Future<List<Movie>> fetchMovies() async {
    final result = await _movieDataSource.fetchMovies();
    return result
        .map(
          (e) => Movie(
            title: e.title,
            poster_path: e.poster_path.isNotEmpty
                ? '${ApiConfig.imageBaseUrl}${e.poster_path}'
                : '',
          ),
        )
        .toList();
  }
}

// Provider 추가
final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  final dataSource = ref.watch(movieDataSourceProvider);
  return MovieRepositoryImpl(dataSource);
});
