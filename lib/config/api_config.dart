import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static String get apiKey => dotenv.env['TMDB_API_KEY'] ?? '';
  static String get baseUrl =>
      dotenv.env['TMDB_BASE_URL'] ?? 'https://api.themoviedb.org/3';
  static String get imageBaseUrl =>
      dotenv.env['TMDB_IMAGE_BASE_URL'] ?? 'https://image.tmdb.org/t/p/w500';

  // API 엔드포인트 상수들
  static const String nowPlaying = '/movie/now_playing';
  static const String popular = '/movie/popular';
  static const String topRated = '/movie/top_rated';
  static const String upcoming = '/movie/upcoming';
  static const String detail = '/movie/';

  // 기본 쿼리 파라미터
  static const String defaultLanguage = 'ko-KR';
  static const int defaultPage = 1;

  static bool get isConfigured => apiKey.isNotEmpty;
}
