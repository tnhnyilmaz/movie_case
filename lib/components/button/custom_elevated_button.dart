import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomElevatedButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return SizedBox(
      width: w,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xffe50914),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18), // <== radius burada
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'Euclid Circular A',
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
