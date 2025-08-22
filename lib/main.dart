import 'package:flutter/material.dart';
import 'package:flutter_movie_info/presentation/pages/detail_page/detail_page.dart';
import 'package:flutter_movie_info/presentation/pages/movie_list/movie_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.dark, // 다크 모드 디폴트
      home: MovieListPage(),
    );
  }
}