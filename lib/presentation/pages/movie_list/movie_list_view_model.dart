import 'package:flutter_movie_info/domain/entity/movie.dart';
import 'package:flutter_movie_info/domain/usecase/fetch_movies_usecase.dart';
import 'package:flutter_movie_info/config/api_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieListViewModel extends Notifier<MovieListState> {
  @override
  MovieListState build() {
    // build() 메서드에서는 초기 상태만 반환하고 API 호출은 하지 않음
    return const MovieListState();
  }

  // 초기 데이터 로드를 위한 메서드 추가
  Future<void> initializeData() async {
    await Future.wait([
      fetchNowPlayingMovies(),
      fetchPopularMovies(),
      fetchTopRatedMovies(),
      fetchUpcomingMovies(),
    ]);
  }

  Future<void> fetchNowPlayingMovies() async {
    state = state.copyWith(isLoading: true);
    try {
      final movies = await ref.read(fetchMoviesUsecaseProvider).execute();
      state = state.copyWith(
        nowPlayingMovies: movies,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> fetchPopularMovies() async {
    state = state.copyWith(isLoading: true);
    try {
      final movies = await ref
          .read(fetchMoviesUsecaseProvider)
          .executeByEndpoint(ApiConfig.popular);
      state = state.copyWith(
        popularMovies: movies,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> fetchTopRatedMovies() async {
    state = state.copyWith(isLoading: true);
    try {
      final movies = await ref
          .read(fetchMoviesUsecaseProvider)
          .executeByEndpoint(ApiConfig.topRated);
      state = state.copyWith(
        topRatedMovies: movies,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

   Future<void> fetchUpcomingMovies() async {
    state = state.copyWith(isLoading: true);
    try {
      final movies = await ref
          .read(fetchMoviesUsecaseProvider)
          .executeByEndpoint(ApiConfig.upcoming);
      state = state.copyWith(
        upcomingMovies: movies,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }


  Future<void> fetchMoviesByEndpoint(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      final movies = await ref
          .read(fetchMoviesUsecaseProvider)
          .executeByEndpoint(endpoint, queryParams: queryParams);
      state = state.copyWith(
        customMovies: movies,
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

// 상태 클래스 추가
class MovieListState {
  final List<Movie>? nowPlayingMovies;
  final List<Movie>? popularMovies;
  final List<Movie>? topRatedMovies;
  final List<Movie>? customMovies;
  final List<Movie>? upcomingMovies;
  final bool isLoading;
  final String? error;

  const MovieListState({
    this.nowPlayingMovies,
    this.popularMovies,
    this.topRatedMovies,
    this.customMovies,
    this.upcomingMovies,
    this.isLoading = false,
    this.error,
  });

  MovieListState copyWith({
    List<Movie>? nowPlayingMovies,
    List<Movie>? popularMovies,
    List<Movie>? topRatedMovies,
    List<Movie>? customMovies,
    List<Movie>? upcomingMovies,
    bool? isLoading,
    String? error,
  }) {
    return MovieListState(
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      popularMovies: popularMovies ?? this.popularMovies,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      customMovies: customMovies ?? this.customMovies,
      upcomingMovies: upcomingMovies ?? this.upcomingMovies,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

final movieListViewModelProvider =
    NotifierProvider<MovieListViewModel, MovieListState>(
      () => MovieListViewModel(),
    );
