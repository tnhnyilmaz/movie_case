import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object?> get props => [];
}

class FetchMovies extends MovieEvent {
  final int page;

  const FetchMovies({required this.page});

  @override
  List<Object?> get props => [page];
}

class AddToFavEvent extends MovieEvent {
  final String movieId;

  const AddToFavEvent({required this.movieId});
  @override
  List<Object?> get props => [movieId];
}

class FetchFavorites extends MovieEvent {}
