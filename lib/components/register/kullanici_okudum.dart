import 'package:flutter/material.dart';
import 'package:movie_case/l10n/app_localizations.dart';

class KullaniciOkudum extends StatelessWidget {
  const KullaniciOkudum({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: Theme.of(
          context,
        ).textTheme.labelMedium?.copyWith(color: Colors.white.withOpacity(0.5)),
        children: [
          TextSpan(text: AppLocalizations.of(context)!.kullnici_soz),
          TextSpan(
            text: AppLocalizations.of(context)!.read_ok,
            style: TextStyle(
              decoration: TextDecoration.underline,
              decorationColor: Colors.white,
            ),
          ),
          TextSpan(text: AppLocalizations.of(context)!.read_continues),
        ],
      ),
    );
  }
}
