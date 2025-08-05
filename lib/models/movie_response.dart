import 'package:movie_case/models/movie_model.dart';
import 'package:movie_case/models/pagination_model.dart';

class MovieResponse {
  final List<Movie> movies;
  final Pagination pagination;

  MovieResponse({required this.movies, required this.pagination});

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;

    return MovieResponse(
      movies: (data['movies'] as List)
          .map((item) => Movie.fromJson(item as Map<String, dynamic>))
          .toList(),
      pagination: Pagination.fromJson(
        data['pagination'] as Map<String, dynamic>,
      ),
    );
  }
}
