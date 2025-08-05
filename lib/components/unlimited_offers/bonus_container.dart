import 'package:flutter/material.dart';
import 'package:movie_case/components/unlimited_offers/bonus_circle_icon.dart';
import 'package:movie_case/const/theme/app_assets.dart';
import 'package:movie_case/l10n/app_localizations.dart';

class BonusContainer extends StatelessWidget {
  const BonusContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              AppLocalizations.of(context)!.recieve_bonus,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BonusCircleIcon(
                iconPath: AppPhotoAssets.premiumIcon,
                label: AppLocalizations.of(context)!.premium_account,
              ),
              BonusCircleIcon(
                iconPath: AppPhotoAssets.matchIcon,
                label: AppLocalizations.of(context)!.more_matches,
              ),
              BonusCircleIcon(
                iconPath: AppPhotoAssets.onCikmaIcon,
                label: AppLocalizations.of(context)!.highlight,
              ),
              BonusCircleIcon(
                iconPath: AppPhotoAssets.heartsOffersIcon,
                label: AppLocalizations.of(context)!.more_likes,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
