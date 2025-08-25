// import 'package:flutter_movie_info/domain/entity/movie.dart';
// import 'package:flutter_movie_info/domain/repository/movie_repository.dart';
// import 'package:flutter_movie_info/domain/usecase/fetch_movies_usecase.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// class MockMovieRepository extends Mock implements MovieRepository {}

// void main() {
//   late final MockMovieRepository mockMovieRepository;
//   late final FetchMoviesUsecase fetchMoviesUsecase;
//   setUp(
//     () async {
//       mockMovieRepository = MockMovieRepository();
//       fetchMoviesUsecase = FetchMoviesUsecase(mockMovieRepository);
//     },
//   );

//   test(
//     'FetchMoviesUsecase test : fetchMovies',
//     () async {
//       when(() => mockMovieRepository.fetchMovies()).thenAnswer((_) async => [
//             Movie(
//               title: 'title',
//               released: 'released',
//               runtime: 'runtime',
//               director: 'director',
//               actors: 'actors',
//               poster: 'poster',
//             )
//           ]);

//       final result = await fetchMoviesUsecase.execute();
//       expect(result.length, 1);
//       expect(result[0].title, 'title');
//     },
//   );
// }
