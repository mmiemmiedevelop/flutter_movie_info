import 'package:flutter_movie_info/config/api_config.dart';
import 'package:flutter_movie_info/data/data_source/movie_data_source.dart';
import 'package:flutter_movie_info/data/dto/movie_dto.dart';
import 'package:flutter_movie_info/data/repository/movie_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MockMovieDataSource extends Mock implements MovieDataSource {}

void main() {
  late MockMovieDataSource mockMovieDataSource;
  late MovieRepositoryImpl movieRepositoryImpl;

  setUpAll(() async {
    // 테스트용 환경변수 직접 설정
    dotenv.testLoad(
      fileInput: '''
TMDB_API_KEY=test_api_key
TMDB_BASE_URL=https://api.themoviedb.org/3
TMDB_IMAGE_BASE_URL=https://image.tmdb.org/t/p/w500
''',
    );
  });

  setUp(() async {
    mockMovieDataSource = MockMovieDataSource();
    movieRepositoryImpl = MovieRepositoryImpl(mockMovieDataSource);
  });

  test('MovieRepositoryImpl test : fetchMovies', () async {
    // Given
    when(() => mockMovieDataSource.fetchMovies()).thenAnswer(
      (_) async => [
        MovieDto(title: 'Test Movie', poster_path: '/test_poster.jpg', id: 123),
      ],
    );

    // When
    final result = await movieRepositoryImpl.fetchMovies();

    // Then
    expect(result.length, 1);
    expect(result[0].title, 'Test Movie');
    expect(result[0].poster_path, '${ApiConfig.imageBaseUrl}/test_poster.jpg');
  });

  test('MovieRepositoryImpl test : fetchMoviesByEndpoint', () async {
    // Given
    const testEndpoint = '/movie/popular';
    final testQueryParams = {'page': 1, 'language': 'ko-KR'};

    when(
      () => mockMovieDataSource.fetchMoviesByEndpoint(
        testEndpoint,
        queryParams: testQueryParams,
      ),
    ).thenAnswer(
      (_) async => [
        MovieDto(
          title: 'Popular Movie 1',
          poster_path: '/popular1.jpg',
          id: 456,
        ),
        MovieDto(
          title: 'Popular Movie 2',
          poster_path: '/popular2.jpg',
          id: 789,
        ),
      ],
    );

    // When
    final result = await movieRepositoryImpl.fetchMoviesByEndpoint(
      testEndpoint,
      queryParams: testQueryParams,
    );

    // Then
    expect(result.length, 2);
    expect(result[0].title, 'Popular Movie 1');
    expect(result[0].poster_path, '${ApiConfig.imageBaseUrl}/popular1.jpg');
    expect(result[1].title, 'Popular Movie 2');
    expect(result[1].poster_path, '${ApiConfig.imageBaseUrl}/popular2.jpg');

    // Verify the mock was called with correct parameters
    verify(
      () => mockMovieDataSource.fetchMoviesByEndpoint(
        testEndpoint,
        queryParams: testQueryParams,
      ),
    ).called(1);
  });
}
