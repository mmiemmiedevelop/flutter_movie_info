import 'package:flutter_movie_info/domain/entity/movie.dart';
import 'package:flutter_movie_info/config/api_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_movie_info/domain/repository/movie_repository.dart';
import 'package:flutter_movie_info/data/repository/movie_repository_impl.dart';

class MovieListViewModel extends Notifier<MovieListState> {
  late MovieRepository _repository;// 직접 repository를 주입 받아서 사용

  @override
  MovieListState build() {
    _repository = ref.read(movieRepositoryProvider);
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
      final movies = await _repository.fetchMovies();
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
      final movies = await _repository.fetchMoviesByEndpoint(ApiConfig.popular);
      state = state.copyWith(
        popularMovies: movies,
        popularCurrentPage: 1, // 현재 페이지 설정
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Popular 영화의 다음 페이지를 불러오는 메서드 추가
  Future<void> loadMorePopularMovies() async {
    if (state.isLoadingMore) {
      return; // 이미 로딩 중이면 중복 요청 방지
    }

    state = state.copyWith(isLoadingMore: true);

    try {
      final nextPage = (state.popularCurrentPage ?? 1) + 1;

      final newMovies = await _repository.fetchMoviesByEndpoint(
        ApiConfig.popular,
        queryParams: {'page': nextPage.toString()},
      );

      // 기존 영화 목록에 새로운 영화들 추가
      final currentMovies = state.popularMovies ?? [];
      final updatedMovies = [...currentMovies, ...newMovies];

      state = state.copyWith(
        popularMovies: updatedMovies,
        popularCurrentPage: nextPage,
        isLoadingMore: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(isLoadingMore: false, error: e.toString());
    }
  }

  Future<void> fetchTopRatedMovies() async {
    state = state.copyWith(isLoading: true);
    try {
      final movies = await _repository.fetchMoviesByEndpoint(
        ApiConfig.topRated,
      );
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
      final movies = await _repository.fetchMoviesByEndpoint(
        ApiConfig.upcoming,
      );
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
      final movies = await _repository.fetchMoviesByEndpoint(
        endpoint,
        queryParams: queryParams,
      );
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
  final int? popularCurrentPage; // popular 영화 현재 페이지 추가
  final bool isLoading;
  final bool isLoadingMore; // 추가 로딩 상태 추가
  final String? error;

  const MovieListState({
    this.nowPlayingMovies,
    this.popularMovies,
    this.topRatedMovies,
    this.customMovies,
    this.upcomingMovies,
    this.popularCurrentPage,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.error,
  });

  MovieListState copyWith({
    List<Movie>? nowPlayingMovies,
    List<Movie>? popularMovies,
    List<Movie>? topRatedMovies,
    List<Movie>? customMovies,
    List<Movie>? upcomingMovies,
    int? popularCurrentPage,
    bool? isLoading,
    bool? isLoadingMore,
    String? error,
  }) {
    return MovieListState(
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      popularMovies: popularMovies ?? this.popularMovies,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      customMovies: customMovies ?? this.customMovies,
      upcomingMovies: upcomingMovies ?? this.upcomingMovies,
      popularCurrentPage: popularCurrentPage ?? this.popularCurrentPage,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      error: error ?? this.error,
    );
  }
}

final movieListViewModelProvider =
    NotifierProvider<MovieListViewModel, MovieListState>(
      () => MovieListViewModel(),
    );
