import 'package:flutter/material.dart';
import 'package:flutter_movie_info/domain/entity/movie.dart';
import 'package:flutter_movie_info/presentation/widgets/section_title.dart';
import 'package:flutter_movie_info/presentation/widgets/horizontal_movie_list.dart';
import 'package:flutter_movie_info/presentation/pages/detail_page/detail_page.dart';
import 'package:flutter_movie_info/presentation/pages/movie_list/movie_list_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieListPage extends ConsumerWidget {
  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DetailPage()),
                  );
                },
                child: Hero(
                  tag: 'popular_movie_hero',
                  child: Container(
                    width: double.infinity,
                    height: 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: const DecorationImage(
                        image: AssetImage('assets/moana.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.7),
                          ],
                        ),
                      ),
                      child: const Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'Moana 2',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // 현재 상영중 섹션
              const SizedBox(height: 32),
              const SectionTitle(title: '현재 상영중'),
              const SizedBox(height: 16),
              Consumer(
                builder: (context, ref, child) {
                  final movies = ref.watch(movieListViewModelProvider);
                  if (movies == null) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return HorizontalMovieList(
                    movies: movies,
                    showRanking: false,
                  );
                },
              ),
              const SizedBox(height: 32),

              // 인기순 섹션
              const SectionTitle(title: '인기순'),
              const SizedBox(height: 16),
              const HorizontalMovieList(movies: [], showRanking: true),
              const SizedBox(height: 32),

              // 평점 높은순 섹션
              const SectionTitle(title: '평점 높은순'),
              const SizedBox(height: 16),
              const HorizontalMovieList(movies: [], showRanking: false),
              const SizedBox(height: 32),

              // 개봉예정 섹션
              const SectionTitle(title: '개봉예정'),
              const SizedBox(height: 16),
              const HorizontalMovieList(movies: [], showRanking: false),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
