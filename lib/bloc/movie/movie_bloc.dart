import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_case/repositories/movie_repository.dart';

import 'movie_event.dart';
import 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieRepository movieRepository;

  MovieBloc(this.movieRepository) : super(MovieInitial()) {
    on<FetchMovies>((event, emit) async {
      emit(MovieLoading());
      try {
        final response = await movieRepository.fetchMovies(event.page);

        emit(
          MovieLoaded(
            movies: response.movies,
            totalPages: response.pagination.maxPage,
            currentPage: response.pagination.currentPage,
          ),
        );
      } catch (e) {
        emit(MovieError(message: e.toString()));
      }
    });

    on<AddToFavEvent>((event, emit) async {
      try {
        await movieRepository.addToFavorite(event.movieId);
        emit(const MovieAddedToFavorites(message: "Favoriye Eklendi"));
      } catch (e) {
        emit(MovieError(message: e.toString()));
      }
    });

    on<FetchFavorites>((event, emit) async {
      emit(MovieLoading());
      try {
        final favorites = await movieRepository.fetchFavoriteMovies();
        emit(FavoriteMoviesLoaded(favorites));
      } catch (e) {
        emit(MovieError(message: e.toString()));
      }
    });
  }
}
