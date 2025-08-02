import 'package:movie_case/models/movie_model.dart';
import 'package:movie_case/models/pagination_model.dart';

class MovieResponse {
  final List<Movie> movies;
  final Pagination pagination;

  MovieResponse({required this.movies, required this.pagination});

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    // 'data' nesnesine ulaşıyoruz
    final data = json['data'] as Map<String, dynamic>;

    return MovieResponse(
      // 'data' içindeki 'movies' listesini ayrıştırıyoruz
      movies: (data['movies'] as List)
          .map((item) => Movie.fromJson(item as Map<String, dynamic>))
          .toList(),
      // 'data' içindeki 'pagination' nesnesini ayrıştırıyoruz
      pagination: Pagination.fromJson(
        data['pagination'] as Map<String, dynamic>,
      ),
    );
  }
}
