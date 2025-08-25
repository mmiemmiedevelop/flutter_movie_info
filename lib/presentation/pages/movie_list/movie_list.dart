import 'package:flutter/material.dart';
import 'package:flutter_movie_info/domain/entity/movie.dart';
import 'package:flutter_movie_info/presentation/widgets/section_title.dart';
import 'package:flutter_movie_info/presentation/widgets/horizontal_movie_list.dart';
import 'package:flutter_movie_info/presentation/pages/detail_page/detail_page.dart';
import 'package:flutter_movie_info/presentation/pages/movie_list/movie_list_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieListPage extends ConsumerStatefulWidget {
  const MovieListPage({super.key});

  @override
  ConsumerState<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends ConsumerState<MovieListPage> {
  @override
  void initState() {
    super.initState();
    // 위젯이 생성된 후 데이터 초기화
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(movieListViewModelProvider.notifier).initializeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(movieListViewModelProvider.notifier);
    final state = ref.watch(movieListViewModelProvider);

    // 로딩 상태 처리
    if (state.isLoading && state.nowPlayingMovies == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // 에러 상태 처리
    if (state.error != null && state.nowPlayingMovies == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('오류가 발생했습니다: ${state.error}'),
              ElevatedButton(
                onPressed: () {
                  viewModel.initializeData();
                },
                child: const Text('다시 시도'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            // 모든 영화 데이터를 새로고침
            await viewModel.fetchNowPlayingMovies();
            await viewModel.fetchPopularMovies();
            await viewModel.fetchTopRatedMovies();
            await viewModel.fetchUpcomingMovies();
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // 가장 인기있는 영화 섹션
                const SectionTitle(title: '가장 인기있는'),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: (state.popularMovies?.isNotEmpty == true)
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(movie: state.popularMovies![0]),
                            ),
                          );
                        }
                      : null,
                  child: Hero(
                    tag: 'popular_movie_hero',
                    child: Container(
                      width: double.infinity,
                      height: 500,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: NetworkImage(
                            state.popularMovies?[0].poster_path ?? '',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),

                // 현재 상영중 섹션
                const SizedBox(height: 32),
                const SectionTitle(title: '현재 상영중'),
                const SizedBox(height: 16),
                HorizontalMovieList(
                  movies: state.nowPlayingMovies ?? [],
                  showRanking: false,
                  onTap: (movie) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => DetailPage(movie: movie),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),

                // 인기순 섹션
                const SectionTitle(title: '인기순'),
                const SizedBox(height: 16),
                HorizontalMovieList(
                  movies: state.popularMovies ?? [],
                  showRanking: true,
                  isPopular: true, // popular 영화임을 표시
                  onLoadMore: () {
                    // 스크롤 끝에 도달했을 때 다음 페이지 로드
                    viewModel.loadMorePopularMovies();
                  },
                  onTap: (movie) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => DetailPage(movie: movie),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),

                // 평점 높은순 섹션
                const SectionTitle(title: '평점 높은순'),
                const SizedBox(height: 16),
                HorizontalMovieList(
                  movies: state.topRatedMovies ?? [],
                  showRanking: false,
                  onTap: (movie) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => DetailPage(movie: movie),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),

                // 개봉예정 섹션
                const SectionTitle(title: '개봉예정'),
                const SizedBox(height: 16),
                HorizontalMovieList(
                  movies: state.upcomingMovies ?? [],
                  showRanking: false,
                  onTap: (movie) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => DetailPage(movie: movie),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
