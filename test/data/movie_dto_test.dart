// import 'dart:convert';

// import 'package:flutter_movie_info/data/dto/movie_dto.dart';
// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   test(
//     'MovieDto : fromJson test',
//     () {
//       const sampleJsonString = """
//   {
//     "title": "Avatar",
//     "released": "18 Dec 2009",
//     "runtime": "162 min",
//     "director": "James Cameron",
//     "actors": "Sam Worthington, Zoe Saldana, Sigourney Weaver, Stephen Lang",
//     "poster": "http://ia.media-imdb.com/images/M/MV5BMTYwOTEwNjAzMl5BMl5BanBnXkFtZTcwODc5MTUwMw@@._V1_SX300.jpg"
//   }
// """;
//       final movie = MovieDto.fromJson(jsonDecode(sampleJsonString));
//       expect(movie.title, "Avatar");
//       expect(movie.released, "18 Dec 2009");
//       expect(movie.runtime, "162 min");
//       expect(movie.director, "James Cameron");
//       expect(movie.actors, "Sam Worthington, Zoe Saldana, Sigourney Weaver, Stephen Lang");
//       expect(movie.poster, "http://ia.media-imdb.com/images/M/MV5BMTYwOTEwNjAzMl5BMl5BanBnXkFtZTcwODc5MTUwMw@@._V1_SX300.jpg");
//     },
//   );
// }
