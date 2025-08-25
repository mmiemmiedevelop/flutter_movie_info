import 'package:flutter_movie_info/domain/entity/movie.dart';
import 'package:flutter_movie_info/domain/usecase/fetch_movies_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieListViewModel extends Notifier<List<Movie>?> {
  @override
  List<Movie>? build() {
    fetchMovies();
    return null;
  }

  Future<void> fetchMovies() async {
    state = await ref.read(fetchMoviesUsecaseProvider).execute();
  }
}

final movieListViewModelProvider =
    NotifierProvider<MovieListViewModel, List<Movie>?>(
      () => MovieListViewModel(),
    );
