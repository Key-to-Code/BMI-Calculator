import 'package:flutter/material.dart';
import '../constants/constants.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 77,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Home tab
          GestureDetector(
            onTap: () => onTap(0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.home_outlined,
                  size: 28,
                  color: currentIndex == 0
                      ? AppColors.primaryGreen
                      : AppColors.textSecondary,
                ),
                const SizedBox(height: 4),
                Text(
                  AppStrings.home,
                  style: TextStyle(
                    fontSize: 12,
                    color: currentIndex == 0
                        ? AppColors.primaryGreen
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          // History tab
          GestureDetector(
            onTap: () => onTap(1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.history,
                  size: 28,
                  color: currentIndex == 1
                      ? AppColors.primaryGreen
                      : AppColors.textSecondary,
                ),
                const SizedBox(height: 4),
                Text(
                  AppStrings.history,
                  style: TextStyle(
                    fontSize: 12,
                    color: currentIndex == 1
                        ? AppColors.primaryGreen
                        : AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
