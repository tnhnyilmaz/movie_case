import 'package:flutter/material.dart';

class LoginRegisterBottomText extends StatelessWidget {
  final String lightText;
  final String underText;
  final VoidCallback onPresed;
  const LoginRegisterBottomText({
    super.key,
    required this.lightText,
    required this.underText,
    required this.onPresed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          lightText,
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'Euclid Circular A',
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        SizedBox(width: 6),
        TextButton(
          onPressed: onPresed,
          child: Text(
            underText,
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Euclid Circular A',
              color: Colors.white,
              decoration: TextDecoration.underline,
              decorationColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
