import 'package:flutter_movie_info/domain/entity/movie.dart';
import 'package:flutter_movie_info/domain/repository/movie_repository.dart';
import 'package:flutter_movie_info/domain/usecase/fetch_movies_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  late MockMovieRepository mockMovieRepository;
  late FetchMoviesUsecase fetchMoviesUsecase;

  setUp(() async {
    mockMovieRepository = MockMovieRepository();
    fetchMoviesUsecase = FetchMoviesUsecase(mockMovieRepository);
  });

  test('FetchMoviesUsecase test : execute', () async {
    // Given
    when(() => mockMovieRepository.fetchMovies()).thenAnswer(
      (_) async => [
        Movie(
          title: 'title',
          poster_path: '/test_poster.jpg',
        ),
      ],
    );

    // When
    final result = await fetchMoviesUsecase.execute();

    // Then
    expect(result.length, 1);
    expect(result[0].title, 'title');
    verify(() => mockMovieRepository.fetchMovies()).called(1);
  });

  test('FetchMoviesUsecase test : executeByEndpoint', () async {
    // Given
    const testEndpoint = '/movie/popular';
    final testQueryParams = {'page': 1, 'language': 'ko-KR'};

    when(
      () => mockMovieRepository.fetchMoviesByEndpoint(
        testEndpoint,
        queryParams: testQueryParams,
      ),
    ).thenAnswer(
      (_) async => [
        Movie(
          title: 'Popular Movie',
          poster_path: '/popular_poster.jpg',
        ),
      ],
    );

    // When
    final result = await fetchMoviesUsecase.executeByEndpoint(
      testEndpoint,
      queryParams: testQueryParams,
    );

    // Then
    expect(result.length, 1);
    expect(result[0].title, 'Popular Movie');
    verify(
      () => mockMovieRepository.fetchMoviesByEndpoint(
        testEndpoint,
        queryParams: testQueryParams,
      ),
    ).called(1);
  });
}
