import 'package:flutter/material.dart';
import '../constants/constants.dart';

class PageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const PageIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        totalPages,
        (index) => Container(
          margin: EdgeInsets.only(
            right: index < totalPages - 1 ? AppDimensions.indicatorGap : 0,
          ),
          width: AppDimensions.indicatorDotSize,
          height: AppDimensions.indicatorDotSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == currentPage
                ? AppColors.indicatorActive
                : AppColors.indicatorInactive,
          ),
        ),
      ),
    );
  }
}
