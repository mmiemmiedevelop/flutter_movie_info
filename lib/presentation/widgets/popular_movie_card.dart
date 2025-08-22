import 'package:flutter/material.dart';

class PopularMovieCard extends StatelessWidget {
  const PopularMovieCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 500,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // 영화 포스터 이미지 (실제로는 NetworkImage 사용)
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.blue[300],
              child: const Center(
                child: Icon(Icons.movie, size: 80, color: Colors.white),
              ),
            ),
            // 영화 정보
          ],
        ),
      ),
    );
  }
}
