import 'package:flutter/material.dart';
import '../../constants/constants.dart';

class OnboardingPage3 extends StatelessWidget {
  final VoidCallback onGetStarted;

  const OnboardingPage3({
    super.key,
    required this.onGetStarted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image area at the top
        const SizedBox(height: 50),
        Image.asset(
          AppImages.onboardingImage3,
          width: 328,
          height: 328,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 40),
        // Text content
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.screenPaddingHorizontal,
          ),
          child: Column(
            children: [
              Text(
                AppStrings.onboardingTitle3,
                style: TextStyle(
                  fontSize: AppDimensions.fontSizeTitle,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppDimensions.textContainerGap),
              Text(
                AppStrings.onboardingDescription3,
                style: TextStyle(
                  fontSize: AppDimensions.fontSizeDescription,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const Spacer(),
        // Get Started Button
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.screenPaddingHorizontal,
          ),
          child: GestureDetector(
            onTap: onGetStarted,
            child: Container(
              width: 321,
              height: 57,
              decoration: BoxDecoration(
                color: AppColors.primaryGreen,
                borderRadius: BorderRadius.circular(28),
              ),
              child: Center(
                child: Text(
                  AppStrings.getStarted,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 60),
      ],
    );
  }
}
