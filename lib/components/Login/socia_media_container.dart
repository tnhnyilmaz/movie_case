import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SociaMediaContainer extends StatelessWidget {
  final String logoStr;

  const SociaMediaContainer({super.key, required this.logoStr});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(18),
          border: BoxBorder.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SvgPicture.asset(logoStr, width: 20, height: 20),
        ),
      ),
    );
  }
}
