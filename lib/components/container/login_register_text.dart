import 'package:flutter/material.dart';

class LoginRegisterText extends StatelessWidget {
  final String title;
  final String descr;
  const LoginRegisterText({super.key, required this.title, required this.descr});

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
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Euclid Circular A',
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          Text(
            descr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Euclid Circular A',
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
