import 'package:flutter/material.dart';
import 'package:flutter_movie_info/domain/entity/movie.dart';

class HorizontalMovieList extends StatelessWidget {
  final List<Movie> movies;
  final bool showRanking;
  final Function(Movie) onTap;

  const HorizontalMovieList({
    super.key,
    required this.movies,
    required this.showRanking,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return GestureDetector(
            onTap: () => onTap(movie),
            child: Container(
              width: showRanking ? 140 : 120,
              margin: showRanking
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
                  if (showRanking)
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
