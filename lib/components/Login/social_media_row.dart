import 'package:flutter/material.dart';
import 'package:movie_case/components/Login/socia_media_container.dart';
import 'package:movie_case/const/theme/app_assets.dart';

class SocialMediaRow extends StatelessWidget {
  const SocialMediaRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SociaMediaContainer(logoStr: AppIconAssets.googleIcon),
        SizedBox(width: 16),
        SociaMediaContainer(logoStr: AppIconAssets.appleIcon),
        SizedBox(width: 16),
        SociaMediaContainer(logoStr: AppIconAssets.facebookIcon),
      ],
    );
  }
}
