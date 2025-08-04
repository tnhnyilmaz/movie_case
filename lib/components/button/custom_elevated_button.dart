import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return SizedBox(
      width: w,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: Theme.of(context).elevatedButtonTheme.style,
        child: Text(text, style: Theme.of(context).textTheme.titleSmall),
      ),
    );
  }
}
