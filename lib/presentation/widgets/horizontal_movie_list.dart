import 'package:flutter/material.dart';
import 'package:flutter_movie_info/domain/entity/movie.dart';

class HorizontalMovieList extends StatefulWidget {
  final List<Movie> movies;
  final bool showRanking;
  final Function(Movie) onTap;
  final VoidCallback? onLoadMore; // 페이지네이션 콜백 추가
  final bool isPopular; // popular 영화인지 구분하는 플래그 추가

  const HorizontalMovieList({
    super.key,
    required this.movies,
    required this.showRanking,
    required this.onTap,
    this.onLoadMore,
    this.isPopular = false,
  });

  @override
  State<HorizontalMovieList> createState() => _HorizontalMovieListState();
}

class _HorizontalMovieListState extends State<HorizontalMovieList> {
  late ScrollController _scrollController;
  bool _hasRequestedMore = false; // 중복 요청 방지를 위한 플래그

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // popular 영화일 때만 스크롤 리스너 추가
    if (widget.isPopular && widget.onLoadMore != null) {
      _scrollController.addListener(_onScroll);
    }
  }

  void _onScroll() {
    // 스크롤이 끝에 가까이 갔을 때 (100픽셀 전에) 미리 로드
    const threshold = 100.0;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - threshold) {
      if (!_hasRequestedMore) {
        _hasRequestedMore = true;
        widget.onLoadMore?.call();
      }
    }
  }

  @override
  void didUpdateWidget(HorizontalMovieList oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 영화 목록이 업데이트되면 다시 요청할 수 있도록 플래그 리셋
    if (oldWidget.movies.length != widget.movies.length) {
      _hasRequestedMore = false;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.movies.length,
        itemBuilder: (context, index) {
          final movie = widget.movies[index];
          return GestureDetector(
            onTap: () => widget.onTap(movie),
            child: Container(
              width: widget.showRanking ? 140 : 120,
              margin: widget.showRanking
                  ? const EdgeInsets.only(right: 8)
                  : const EdgeInsets.only(right: 16),
              child: Stack(
                children: [
                  // 영화 포스터 - 오른쪽 정렬
                  Positioned(
                    right: 0,
                    child: Container(
                      width: 120,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey[400],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: movie.poster_path.isNotEmpty
                            ? Image.network(
                                movie.poster_path,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Icon(
                                      Icons.movie,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              )
                            : const Center(
                                child: Icon(
                                  Icons.movie,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ),
                  // 랭킹 숫자 (인기순 섹션에서만 표시)
                  if (widget.showRanking)
                    Positioned(
                      bottom: -20,
                      left: -6,
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          fontSize: 90,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
