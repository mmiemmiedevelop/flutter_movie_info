import 'package:flutter/material.dart';
import '../../widgets/section_title.dart';
import '../../widgets/horizontal_movie_list.dart';
import '../detail_page/detail_page.dart';

class MovieListPage extends StatelessWidget {
  const MovieListPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                            Colors.black.withOpacity(0.7),
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
              const SectionTitle(title: '현재 상영중'),
              const SizedBox(height: 16),
              const HorizontalMovieList(count: 20, showRanking: false),
              const SizedBox(height: 32),

              // 인기순 섹션
              const SectionTitle(title: '인기순'),
              const SizedBox(height: 16),
              const HorizontalMovieList(count: 20, showRanking: true),
              const SizedBox(height: 32),

              // 평점 높은순 섹션
              const SectionTitle(title: '평점 높은순'),
              const SizedBox(height: 16),
              const HorizontalMovieList(count: 20, showRanking: false),
              const SizedBox(height: 32),

              // 개봉예정 섹션
              const SectionTitle(title: '개봉예정'),
              const SizedBox(height: 16),
              const HorizontalMovieList(count: 20, showRanking: false),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
