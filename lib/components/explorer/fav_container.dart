import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_case/components/explorer/alert_dialog.dart';
import 'package:movie_case/const/theme/app_assets.dart';
import 'package:movie_case/models/movie_model.dart';

class FavContainer extends StatelessWidget {
  final Movie movie;
  const FavContainer({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return CustomAlertDialog(title: movie.title, movieId: movie.id);
          },
        );
      },
      child: SizedBox(
        width: 50,
        height: 70,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: SvgPicture.asset(
              movie.isFav
                  ? AppIconAssets.heartsIcon
                  : AppIconAssets.heartsIconOutline,
            ),
          ),
        ),
      ),
    );
  }
}
