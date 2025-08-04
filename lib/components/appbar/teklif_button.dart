import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_case/const/theme/app_assets.dart';
import 'package:movie_case/l10n/app_localizations.dart';

class TeklifButton extends StatelessWidget {
  const TeklifButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style,
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Color(0xFF090909),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Column(
                  children: [
                    Opacity(
                      opacity: 0.3,
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 75, sigmaY: 75),
                        child: SizedBox(
                          width: 400, // istediğin genişlik
                          height: 500, // istediğin yükseklik
                          child: SvgPicture.asset(
                            AppIconAssets.topGradientIcon,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(AppIconAssets.gemIcon),
          Text(
            AppLocalizations.of(context)!.unlimited_offers,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
