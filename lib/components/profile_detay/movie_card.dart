import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final String title;
  final String descr;
  final String poster;

  const MovieCard({
    super.key,
    required this.title,
    required this.descr,
    required this.poster,
  });

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
                borderRadius: BorderRadius.circular(12),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  poster.isNotEmpty
                      ? poster
                      : "https://i.hizliresim.com/bj21ezq.jpg",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image, color: Colors.white);
                  },
                ),
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
