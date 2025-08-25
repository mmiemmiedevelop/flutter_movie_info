import 'package:flutter/services.dart';
import 'package:flutter_movie_info/data/data_source/movie_asset_data_srouce_impl.dart';
import 'package:flutter_movie_info/data/data_source/movie_api_data_source_impl.dart';
import 'package:flutter_movie_info/data/dto/movie_dto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_movie_info/config/api_config.dart';

abstract class MovieDataSource {
  Future<List<MovieDto>> fetchMovies();
}

// Provider - API 키가 설정되어 있으면 API 사용, 아니면 로컬 데이터 사용
final movieDataSourceProvider = Provider<MovieDataSource>((ref) {
  if (ApiConfig.isConfigured) {
    return MovieApiDataSourceImpl(http.Client());
  } else {
    return MovieAssetDataSourceImpl(rootBundle);
  }
});
