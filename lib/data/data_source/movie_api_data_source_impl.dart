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
    try {
      if (!ApiConfig.isConfigured) {
        throw Exception('API 키가 설정되지 않았습니다. .env 파일을 확인해주세요.');
      }

      final response = await _client.get(
        Uri.parse(
          '${ApiConfig.baseUrl}/movie/now_playing?language=ko-KR&page=1',
        ),
        headers: {
          'Authorization': 'Bearer ${ApiConfig.apiKey}',
          'accept': 'application/json',
        },
      );
    //  print('0ApiConfig.baseUrl: ${ApiConfig.baseUrl}');
   //   print('1ApiConfig.apiKey: ${ApiConfig.apiKey}');
  //    print('2response: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final movieResponse = MovieResponseDto.fromJson(jsonData);

        return movieResponse.results.map((result) => MovieDto.fromJson(result.toJson())).toList();
      } else {
        throw Exception('영화 데이터를 불러오는데 실패했습니다: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
   //   print('Error details: $e');
   //   print('Stack trace: $stackTrace');
      throw Exception('영화 데이터를 불러오는데 실패했습니다: ${e?.toString() ?? '알 수 없는 오류'}');
    }
  }
}
