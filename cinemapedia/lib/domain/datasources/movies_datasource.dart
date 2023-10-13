import 'package:cinemapedia/domain/entities/movie.dart';

abstract class MovieDatasource {
  Future<List<Movie>> getNowPlayinh({int page = 1});
}
