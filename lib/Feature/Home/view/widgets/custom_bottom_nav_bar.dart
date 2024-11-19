import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar(
      {Key? key, required this.selectedIndex, required this.onItemTapped})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      color: Colors.green.withOpacity(0.4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(2, (index) => _buildNavItem(index, context)),
      ),
    );
  }

  Widget _buildNavItem(int index, BuildContext context) {
    String label;
    Widget unSelectedIcon;
    Widget selectedIcon;
    switch (index) {
      case 0:
        unSelectedIcon = SvgPicture.asset(
          'assets/images/home.svg',
        );
        selectedIcon = SvgPicture.asset(
          'assets/images/home.svg',
        );

        label = 'Nearby';
        break;
      case 1:
        unSelectedIcon = SvgPicture.asset(
          'assets/images/fav.svg',
        );
        selectedIcon = SvgPicture.asset(
          'assets/images/fav.svg',
        );
        label = 'History';
        break;

      default:
        unSelectedIcon = SvgPicture.asset(
          'assets/images/home.svg',
        );
        selectedIcon = SvgPicture.asset(
          'assets/images/home.svg',
        );
        label = 'NearBy';
    }

    bool isSelected = index == selectedIndex;

    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.amber : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isSelected ? selectedIcon : unSelectedIcon,
            const SizedBox(
              width: 10,
            ),
            if (isSelected)
              Text(
                label,
                style: const TextStyle(color: Colors.white),
              )
          ],
        ),
      ),
    );
  }
}
