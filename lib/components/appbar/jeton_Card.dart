import 'package:flutter/material.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
import 'package:google_fonts/google_fonts.dart';

class JetonCard extends StatelessWidget {
  final String oldJeton;
  final String currentJeton;
  final String price;
  final Color color1;
  final Color color2;

  const JetonCard({
    super.key,
    required this.oldJeton,
    required this.currentJeton,
    required this.price,
    required this.color1,
    required this.color2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Center(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            InnerShadow(
              shadows: [
                Shadow(
                  color: Colors.white.withOpacity(0.5),
                  blurRadius: 10,
                  offset: Offset(2, 5),
                ),
              ],
              child: Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.width * 0.65,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color1, color2],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(color: Colors.white.withOpacity(0.4)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.redAccent.withOpacity(0.2),
                      blurRadius: 12,
                      spreadRadius: -2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      oldJeton,
                      style: GoogleFonts.montserrat(
                        fontSize: 22,
                        decoration: TextDecoration.lineThrough,
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      currentJeton,
                      style: GoogleFonts.montserrat(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Jeton',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider(
                      color: Colors.white24,
                      indent: 20,
                      endIndent: 20,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '₺ ${price}',
                      style: GoogleFonts.montserrat(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Başına haftalık',
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned(
              top: -10,
              left: 35,
              child: InnerShadow(
                shadows: [
                  Shadow(
                    color: Colors.white.withOpacity(0.5),
                    blurRadius: 10,
                    offset: Offset(2, 5),
                  ),
                ],
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white.withOpacity(0.4)),
                    gradient: const RadialGradient(
                      colors: [Color(0xffE50914), Color(0xff6F060B)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: const Text(
                    '+10%',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
