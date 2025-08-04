import 'package:flutter/material.dart';

class LoginRegisterText extends StatelessWidget {
  final String title;
  final String descr;
  const LoginRegisterText({
    super.key,
    required this.title,
    required this.descr,
  });

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return SizedBox(
      width: w * 0.8,
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Text(
            descr,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
