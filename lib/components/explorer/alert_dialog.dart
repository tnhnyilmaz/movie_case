import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_case/bloc/movie/movie_bloc.dart';
import 'package:movie_case/bloc/movie/movie_event.dart';
import 'package:movie_case/bloc/movie/movie_state.dart';
import 'package:movie_case/l10n/app_localizations.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String movieId;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.movieId,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text(title, style: Theme.of(context).textTheme.headlineLarge),
      content: Text(
        AppLocalizations.of(context)!.want_add_fav,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // Cancel
          child: Text(
            AppLocalizations.of(context)!.cancel,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
        TextButton(
          onPressed: () {
            final bloc = context.read<MovieBloc>();
            bloc.add(AddToFavEvent(movieId: movieId));

            Future.delayed(const Duration(milliseconds: 100), () {
              final currentState = bloc.state;
              if (currentState is MovieLoaded) {
                bloc.add(FetchMovies(page: currentState.currentPage));
              }

              Navigator.of(context).pop();
            });
          },
          child: Text(
            AppLocalizations.of(context)!.add,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ),
      ],
    );
  }
}
