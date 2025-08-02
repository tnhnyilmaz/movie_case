import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final String title;
  final String descr;

  const MovieCard({super.key, required this.title, required this.descr});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return SizedBox(
      width: w * 0.4,
      height: h / 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 10,
            child: Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          SizedBox(height: 12),
          Expanded(
            flex: 1,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Euclid Circular A',
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              descr,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'Euclid Circular A',
                color: Colors.white.withOpacity(0.75),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
