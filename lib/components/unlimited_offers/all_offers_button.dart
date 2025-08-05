import 'package:flutter/material.dart';
import 'package:movie_case/l10n/app_localizations.dart';

class AllOffersButton extends StatelessWidget {
  const AllOffersButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: Theme.of(context).elevatedButtonTheme.style,
          onPressed: () {},
          child: Text(
            AppLocalizations.of(context)!.all_jeton,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ),
    );
  }
}
