import 'package:equatable/equatable.dart';
import 'package:movie_case/models/movie_model.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object?> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Movie> movies;
  final int totalPages;
  final int currentPage; // int yapıldı

  const MovieLoaded({
    required this.movies,
    required this.totalPages,
    required this.currentPage,
  });

  @override
  List<Object?> get props => [movies, totalPages, currentPage];
}

class MovieAddedToFavorites extends MovieState {
  final String message;

  const MovieAddedToFavorites({required this.message});
}

class MovieError extends MovieState {
  final String message;

  const MovieError({required this.message}); // parametre düzenlendi

  @override
  List<Object?> get props => [message];
}

class FavoriteMoviesLoaded extends MovieState {
  final List<Movie> favoriteMovies;

  const FavoriteMoviesLoaded(this.favoriteMovies);

  @override
  List<Object?> get props => [favoriteMovies];
}
