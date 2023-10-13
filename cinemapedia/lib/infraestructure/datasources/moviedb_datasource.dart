import 'package:cinemapedia/config/constant/environment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MovieDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Enviroment.movieDbKey,
        'language': 'es-MX'
      }));
  @override
  Future<List<Movie>> getNowPlayinh({int page = 1}) async {
    final response = await dio.get('/movies/now_playing');
    response.data;
    final List<Movie> movies = [];

    return movies;
  }
}
