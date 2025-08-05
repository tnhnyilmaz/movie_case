import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_case/components/unlimited_offers/all_offers_button.dart';
import 'package:movie_case/components/unlimited_offers/bonus_container.dart';
import 'package:movie_case/components/unlimited_offers/jeton_row.dart';
import 'package:movie_case/const/theme/app_assets.dart';
import 'package:movie_case/l10n/app_localizations.dart';

class TeklifButton extends StatefulWidget {
  const TeklifButton({super.key});

  @override
  State<TeklifButton> createState() => _TeklifButtonState();
}

class _TeklifButtonState extends State<TeklifButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style,
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: const Color(0xFF090909),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          clipBehavior: Clip.hardEdge,
          builder: (context) {
            return ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF090909),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Opacity(
                          opacity: 0.3,
                          child: ImageFiltered(
                            imageFilter: ImageFilter.blur(
                              sigmaX: 75,
                              sigmaY: 75,
                            ),
                            child: SvgPicture.asset(
                              AppIconAssets.topGradientIcon,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          Center(
                            child: Text(
                              AppLocalizations.of(context)!.limited_offer,
                              style: Theme.of(context).textTheme.titleLarge
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.open_pack,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white70),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: BonusContainer(),
                          ),
                          SizedBox(height: 12),
                          Center(
                            child: Text(
                              AppLocalizations.of(context)!.unlock_token,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                          JetonRow(),
                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: AllOffersButton(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(AppIconAssets.gemIcon),
          const SizedBox(width: 8),
          Text(
            AppLocalizations.of(context)!.unlimited_offers,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget bonusItem(String iconPath, String label) {
    print("icon path: $iconPath");
    return Column(
      children: [
        Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const RadialGradient(
              colors: [
                Color(0xFF6F060B),
                Color.fromARGB(255, 177, 17, 25),
                Colors.white,
                Colors.white,
              ],
              center: Alignment.center,
              radius: 0.9,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.redAccent.withOpacity(0.2),
                blurRadius: 12,
                spreadRadius: -2,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(child: Image.asset(iconPath, width: 24, height: 24)),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}
