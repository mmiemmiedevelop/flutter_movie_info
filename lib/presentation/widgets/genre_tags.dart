import 'package:flutter/material.dart';

class GenreTags extends StatelessWidget {
  final List<String> genres;
  final double height;

  const GenreTags({super.key, required this.genres, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: genres.length,
        itemBuilder: (context, index) {
          final genre = genres[index];
          return Container(
            margin: EdgeInsets.only(right: index == genres.length - 1 ? 0 : 8),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey[600]!, width: 1.5),
            ),
            child: Center(
              child: Text(
                genre,
                style: TextStyle(color: Colors.blue, fontSize: 14),
              ),
            ),
          );
        },
      ),
    );
  }
}
