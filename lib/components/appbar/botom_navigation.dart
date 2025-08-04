import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_case/const/theme/app_assets.dart';
import 'package:movie_case/l10n/app_localizations.dart';
import 'package:movie_case/view/profile_detail_view.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

  const CustomBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: Offset(0, -15),
            blurRadius: 20,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(
            context,
            asset: AppIconAssets.homeIcon,
            label: AppLocalizations.of(context)!.home,
            index: 0,
            isSelected: currentIndex == 0,
          ),
          _buildNavItem(
            context,
            asset: AppIconAssets.bottomPersonIcon,
            label: AppLocalizations.of(context)!.profile,
            index: 1,
            isSelected: currentIndex == 1,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required String asset,
    required String label,
    required int index,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        onTabSelected(index); // callback ile yukarıya bildiriyoruz
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProfileDetailView()),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.7),
              offset: const Offset(0, -2),
              blurRadius: 3,
            ),
          ],
          color: isSelected ? Colors.white : Colors.transparent,
          border: isSelected ? null : Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              asset,
              colorFilter: ColorFilter.mode(
                isSelected ? Colors.black : Colors.white,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
