// import 'package:flutter/services.dart';
// import 'package:flutter_movie_info/data/data_source/movie_asset_data_srouce_impl.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';

// class MockAssetBundle extends Mock implements AssetBundle {}

// void main() {
//   late final MockAssetBundle mockAssetBundle;
//   late final MovieAssetDataSourceImpl movieAssetDataSourceImpl;
//   setUp(
//     () async {
//       mockAssetBundle = MockAssetBundle();
//       movieAssetDataSourceImpl = MovieAssetDataSourceImpl(mockAssetBundle);
//     },
//   );

//   test(
//     'MovieAssetDataSourceImpl: fetchMovies return data test',
//     () async {
//       // 가짜데이터 주입
//       when(() => mockAssetBundle.loadString(any())).thenAnswer((_) async => """
//   [{
//     "title": "300",
//     "released": "09 Mar 2007",
//     "runtime": "117 min",
//     "director": "Zack Snyder",
//     "actors": "Gerard Butler, Lena Headey, Dominic West, David Wenham",
//     "poster": "https://ia.media-imdb.com/images/M/MV5BMjAzNTkzNjcxNl5BMl5BanBnXkFtZTYwNDA4NjE3._V1_SX300.jpg"
//   }]
// """);

//       // 호출
//       final result = await movieAssetDataSourceImpl.fetchMovies();
//       // 검증
//       expect(result.length, 1);
//     },
//   );
// }
