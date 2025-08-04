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
      title: Text(title),
      content: Text(AppLocalizations.of(context)!.want_add_fav),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), // Cancel
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        TextButton(
          onPressed: () {
            final bloc = context.read<MovieBloc>();
            bloc.add(AddToFavEvent(movieId: movieId));

            // Kısa bir gecikme verip ardından FetchMovies ile yenileme
            Future.delayed(const Duration(milliseconds: 100), () {
              final currentState = bloc.state;
              if (currentState is MovieLoaded) {
                bloc.add(FetchMovies(page: currentState.currentPage));
              }

              Navigator.of(context).pop(); // Dialog'u kapat
            });
          },
          child: Text(AppLocalizations.of(context)!.add),
        ),
      ],
    );
  }
}
