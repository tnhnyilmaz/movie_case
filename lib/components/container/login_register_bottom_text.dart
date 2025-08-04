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
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Theme.of(
              context,
            ).textTheme.labelMedium?.color?.withOpacity(0.2),
          ),
        ),
        SizedBox(width: 6),
        TextButton(
          onPressed: onPresed,
          child: Text(
            underText,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              decoration: TextDecoration.underline,
              decorationColor: Colors.white,
              decorationThickness: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
