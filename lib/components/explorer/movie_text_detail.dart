import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_case/const/theme/app_assets.dart';
import 'package:movie_case/l10n/app_localizations.dart';
import 'package:movie_case/models/movie_model.dart';

class MovieTextDetail extends StatefulWidget {
  final Movie movie;
  const MovieTextDetail({super.key, required this.movie});

  @override
  State<MovieTextDetail> createState() => _MovieTextDetailState();
}

class _MovieTextDetailState extends State<MovieTextDetail> {
  bool _showFullText = true;

  void _toggleShowFullText() {
    setState(() {
      _showFullText = !_showFullText;
    });
  }

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
            color: const Color(0xffE50914),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: SvgPicture.asset(AppIconAssets.nLogoIcon, width: 20),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.movie.title,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                widget.movie.plot,
                maxLines: _showFullText ? null : 4,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).textTheme.labelMedium?.color?.withOpacity(0.5),
                ),
              ),
              GestureDetector(
                onTap: _toggleShowFullText,
                child: Text(
                  _showFullText
                      ? AppLocalizations.of(context)!.less
                      : AppLocalizations.of(context)!.more,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
