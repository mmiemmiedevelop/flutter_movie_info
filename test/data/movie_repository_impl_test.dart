// import 'package:flutter_movie_info/data/data_source/movie_data_source.dart';
// import 'package:flutter_movie_info/data/dto/movie_dto.dart';
// import 'package:flutter_movie_info/data/repository/movie_repository_impl.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// class MockMovieDataSource extends Mock implements MovieDataSource {}

// void main() {
//   late final MockMovieDataSource mockMovieDataSource;
//   late final MovieRepositoryImpl movieRepositoryImpl;
//   setUp(() async {
//     mockMovieDataSource = MockMovieDataSource();
//     movieRepositoryImpl = MovieRepositoryImpl(mockMovieDataSource);
//   });

//   test('MovieRepositoryImpl test : fetchMovies', () async {
//     when(() => mockMovieDataSource.fetchMovies()).thenAnswer(
//       (_) async => [
//         MovieDto(
//           title: 'title',
//           released: 'released',
//           runtime: 'runtime',
//           director: 'director',
//           actors: 'actors',
//           poster: 'poster',
//         ),
//       ],
//     );

//     final result = await movieRepositoryImpl.fetchMovies();
//     expect(result.length, 1);
//     expect(result[0].title, 'title');
//   });
// }
