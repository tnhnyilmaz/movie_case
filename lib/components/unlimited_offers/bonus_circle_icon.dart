import 'package:flutter/material.dart';

class BonusCircleIcon extends StatelessWidget {
  final String iconPath;
  final String label;
  const BonusCircleIcon({super.key, required this.iconPath, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 55,
          height: 55,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const RadialGradient(
              colors: [
                Color(0xFF6F060B),
                Color.fromARGB(255, 177, 17, 25),
                Colors.white,
                Colors.white,
              ],
              center: Alignment.center,
              radius: 0.9,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.redAccent.withOpacity(0.2),
                blurRadius: 12,
                spreadRadius: -2,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(child: Image.asset(iconPath, width: 24, height: 24)),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
    
  }
}
