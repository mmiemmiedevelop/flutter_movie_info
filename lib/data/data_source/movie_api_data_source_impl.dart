import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_movie_info/data/data_source/movie_data_source.dart';
import 'package:flutter_movie_info/data/dto/movie_dto.dart';
import 'package:flutter_movie_info/data/dto/movie_response_dto.dart';
import 'package:flutter_movie_info/config/api_config.dart';

class MovieApiDataSourceImpl implements MovieDataSource {
  MovieApiDataSourceImpl(this._client);
  final http.Client _client;

  @override
  Future<List<MovieDto>> fetchMovies() async {
    return fetchMoviesByEndpoint(ApiConfig.nowPlaying);
  }

  @override
  Future<List<MovieDto>> fetchMoviesByEndpoint(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      if (!ApiConfig.isConfigured) {
        throw Exception('API 키가 설정되지 않았습니다. .env 파일을 확인해주세요.');
      }

      final defaultParams = <String, String>{
        'language': ApiConfig.defaultLanguage,
        'page': ApiConfig.defaultPage.toString(),
      };

      if (queryParams != null) {
        queryParams.forEach((key, value) {
          defaultParams[key] = value.toString();
        });
      }

      final uri = Uri.parse(
        '${ApiConfig.baseUrl}$endpoint',
      ).replace(queryParameters: defaultParams);

      final response = await _client.get(
        uri,
        headers: {
          'Authorization': 'Bearer ${ApiConfig.apiKey}',
          'accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final movieResponse = MovieResponseDto.fromJson(jsonData);
        return movieResponse.results
            .map((result) => MovieDto.fromJson(result.toJson()))
            .toList();
      } else {
        throw Exception('영화 데이터를 불러오는데 실패했습니다: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('영화 데이터를 불러오는데 실패했습니다: ${e.toString()}');
    }
  }
}
