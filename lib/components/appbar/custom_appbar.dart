import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_case/components/unlimited_offers/teklif_button.dart';
import 'package:movie_case/const/theme/app_assets.dart';
import 'package:movie_case/l10n/app_localizations.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onPres;
  final bool isOffer;
  const CustomAppbar({super.key, required this.onPres, required this.isOffer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: GestureDetector(
          onTap: onPres,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Center(
              child: SvgPicture.asset(
                AppIconAssets.leftIcon,
                width: 20,
                height: 20,
              ),
            ),
          ),
        ),

        actions: [
          Text(
            AppLocalizations.of(context)!.profil_detail,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          SizedBox(width: 8),
          if (isOffer) TeklifButton(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
