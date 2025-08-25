import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_movie_info/data/data_source/movie_data_source.dart';
import 'package:flutter_movie_info/data/dto/movie_dto.dart';

class MovieAssetDataSourceImpl implements MovieDataSource {
  MovieAssetDataSourceImpl(this._assetBundle);
  final AssetBundle _assetBundle;

  @override
  Future<List<MovieDto>> fetchMovies() async {
    final jsonString = await _assetBundle.loadString('assets/movies.json');
    return List.from(
      jsonDecode(jsonString),
    ).map((e) => MovieDto.fromJson(e)).toList();
  }
}
