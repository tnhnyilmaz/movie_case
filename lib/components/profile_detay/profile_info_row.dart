import 'package:flutter/material.dart';
import 'package:movie_case/l10n/app_localizations.dart';
import 'package:movie_case/view/add_profile_photo_view.dart';

class ProfileInfoRow extends StatelessWidget {
  final String userName;
  final String userId;
  final String photoUrl;
  const ProfileInfoRow({
    super.key,
    required this.userName,
    required this.userId,
    required this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.amber,
              ),
              child: ClipOval(
                child: Image.network(
                  photoUrl,
                  fit: BoxFit.cover,
                  width: 60,
                  height: 60,
                ),
              ),
            ),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(userName, style: Theme.of(context).textTheme.titleSmall),
                SizedBox(height: 4),
                Text(
                  userId,
                  style: Theme.of(
                    context,
                  ).textTheme.labelLarge?.copyWith(fontSize: 8),
                ),
              ],
            ),
          ],
        ),
        ElevatedButton(
          style: Theme.of(context).elevatedButtonTheme.style,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AddProfilePhoto()),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.add_photo,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
