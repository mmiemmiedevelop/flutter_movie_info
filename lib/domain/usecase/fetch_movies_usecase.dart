import 'package:flutter_movie_info/domain/entity/movie.dart';
import 'package:flutter_movie_info/data/repository/movie_repository_impl.dart';
import 'package:flutter_movie_info/domain/repository/movie_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FetchMoviesUsecase {
  FetchMoviesUsecase(this._movieRepository);
  final MovieRepository _movieRepository;

  Future<List<Movie>> execute() async {
    return await _movieRepository.fetchMovies();
  }
}

// Provider 추가
final fetchMoviesUsecaseProvider = Provider<FetchMoviesUsecase>((ref) {
  final repository = ref.watch(movieRepositoryProvider);
  return FetchMoviesUsecase(repository);
});
