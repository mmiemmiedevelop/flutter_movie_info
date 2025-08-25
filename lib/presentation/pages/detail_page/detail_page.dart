import 'package:flutter/material.dart';
import 'package:flutter_movie_info/domain/entity/movie.dart';
import '../../widgets/box_office_card.dart';
import '../../widgets/company_logo_card.dart';
import '../../widgets/genre_tags.dart';

class DetailPage extends StatelessWidget {
  final Movie movie;
  const DetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            // 영화 포스터--------------------------------
            Hero(
              tag: 'popular_movie_hero',
              child: ClipRRect(
                child: movie.poster_path.isNotEmpty
                    ? Image.network(
                        movie.poster_path,
                        width: double.infinity,
                        height: 450,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: double.infinity,
                            height: 450,
                            color: Colors.grey[800],
                            child: const Center(
                              child: Icon(
                                Icons.image_not_supported,
                                size: 48,
                                color: Colors.white54,
                              ),
                            ),
                          );
                        },
                      )
                    // 영화 포스터 없을 때
                    : Container(
                        width: double.infinity,
                        height: 450,
                        color: Colors.grey[800],
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported,
                            size: 48,
                            color: Colors.white54,
                          ),
                        ),
                      ),
              ),
            ),

            // 메인 콘텐츠--------------------------------
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 영화 제목 개봉일--------------------------------
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Moana 2',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        child: const Text(
                          '2024-11-27',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // 태그라인--------------------------------
                  const Text(
                    'The ocean is calling them back.',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),

                  const SizedBox(height: 4),

                  // 러닝타임--------------------------------
                  const Text(
                    '100분',
                    style: TextStyle(fontSize: 14, color: Colors.white60),
                  ),

                  const SizedBox(height: 4),
                  Container(height: 1, color: Colors.grey[600]),
                  const SizedBox(height: 10),

                  // 장르 태그들--------------------------------
                  GenreTags(
                    genres: ['Animation', 'Adventure', 'Family', 'Comedy'],
                    height: 40,
                  ),
                  const SizedBox(height: 10),

                  const SizedBox(height: 4),
                  Container(height: 1, color: Colors.grey[600]),

                  const SizedBox(height: 8),

                  // 시놉시스--------------------------------
                  const Text(
                    'After receiving an unexpected call from her wayfinding ancestors, Moana journeys alongside Maui and a new crew to the far seas of Oceania and into dangerous, long-lost waters for an adventure unlike anything she\'s ever faced.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),

                  const SizedBox(height: 4),
                  Container(height: 1, color: Colors.grey[600]),

                  const SizedBox(height: 24),

                  // 흥행정보 -------------------------------
                  const Text(
                    '흥행정보',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 흥행정보 가로 스크롤--------------------------------
                  SizedBox(
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        BoxOfficeCard(value: '6.949', label: '평점'),
                        BoxOfficeCard(value: '331', label: '평점투표수'),
                        BoxOfficeCard(value: '466.535', label: '인기점수'),
                        BoxOfficeCard(value: '\$150000000', label: '예산'),
                        BoxOfficeCard(value: '\$423586580', label: '수익'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // 제작사 로고들 가로 스크롤--------------------------------
                  SizedBox(
                    height: 80,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        CompanyLogoCard(imageUrl: 'assets/moana.png'),
                        CompanyLogoCard(imageUrl: 'assets/moana.png'),
                        CompanyLogoCard(imageUrl: 'assets/moana.png'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
