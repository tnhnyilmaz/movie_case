import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onPres;
  const CustomAppbar({super.key, required this.onPres});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: GestureDetector(
          onTap:onPres,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(40),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Center(
              child: SvgPicture.asset(
                "assets/icons/left_icon.svg",
                width: 20,
                height: 20,
              ),
            ),
          ),
        ),

        actions: [
          Text(
            "Profil Detayı",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xffe50914)),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Color(0xFF090909),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) {
                  return BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        children: [
                          Opacity(
                            opacity: 0.3,
                            child: ImageFiltered(
                              imageFilter: ImageFilter.blur(
                                sigmaX: 75,
                                sigmaY: 75,
                              ),
                              child: SizedBox(
                                width: 400, // istediğin genişlik
                                height: 500, // istediğin yükseklik
                                child: SvgPicture.asset(
                                  "assets/icons/top_gradient.svg",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/icons/gem_icon.svg"),
                SizedBox(width: 2),
                Text(
                  "Sınırlı Teklif",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
