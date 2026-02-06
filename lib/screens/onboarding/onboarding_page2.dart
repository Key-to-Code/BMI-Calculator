import 'package:flutter/material.dart';
import '../../constants/constants.dart';

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image area at the top
        const SizedBox(height: 50),
        Image.asset(
          AppImages.onboardingImage2,
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
                AppStrings.onboardingTitle2,
                style: TextStyle(
                  fontSize: AppDimensions.fontSizeTitle,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppDimensions.textContainerGap),
              Text(
                AppStrings.onboardingDescription2,
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
      ],
    );
  }
}
