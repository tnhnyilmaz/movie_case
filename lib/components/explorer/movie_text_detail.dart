import 'package:flutter/material.dart';
import 'package:movie_case/l10n/app_localizations.dart';
import 'package:movie_case/models/movie_model.dart';

class MovieTextDetail extends StatelessWidget {
  final Movie movie;
  const MovieTextDetail({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            color: Colors.amber,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                movie.title,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                movie.plot,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).textTheme.labelMedium?.color?.withOpacity(0.5),
                ),
              ),
              Text(
                AppLocalizations.of(context)!.more,
                style: Theme.of(
                  context,
                ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
