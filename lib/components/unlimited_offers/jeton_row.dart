import 'package:flutter/material.dart';
import 'package:movie_case/components/appbar/jeton_Card.dart';

class JetonRow extends StatelessWidget {
  const JetonRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          JetonCard(
            oldJeton: '200',
            currentJeton: '300',
            price: '99,99',
            color1: Color(0xff6F060B),
            color2: Color(0xffE50914),
          ),
          JetonCard(
            oldJeton: "2.000",
            currentJeton: "3.375",
            price: "799,99",
            color1: Color(0xff5949E6),
            color2: Color(0xffE50914),
          ),
          JetonCard(
            oldJeton: "1.000",
            currentJeton: "1.350",
            price: "399,99",
            color1: Color(0xff6F060B),
            color2: Color(0xffE50914),
          ),
        ],
      ),
    );
  }
}
