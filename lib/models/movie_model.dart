class Movie {
  final String id;
  final String title;
  final String year;
  final String poster;
  final String plot;
  final bool isFav;

  Movie({
    required this.id,
    required this.title,
    required this.year,
    required this.poster,
    required this.plot,
    required this.isFav,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? '',
      title: json['Title'] ?? '',
      year: json['Year'] ?? '',
      poster: json['Poster'] ?? '',
      plot: json['Plot'] ?? '',
      isFav: json['isFavorite'] ?? '',
    );
  }
  @override
  String toString() {
    return 'Movie{id: $id, title: $title, plot: $plot, poster: $poster ,isFavorite:$isFav}';
  }
}
