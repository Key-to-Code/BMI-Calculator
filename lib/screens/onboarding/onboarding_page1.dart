import 'package:flutter/material.dart';
import '../../constants/constants.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Logo image area
        const SizedBox(height: 100),
        Image.asset(
          AppImages.idealFitLogo,
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
        const Spacer(),
        // Text content
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppDimensions.screenPaddingHorizontal,
          ),
          child: Column(
            children: [
              Text(
                AppStrings.onboardingTitle1,
                style: TextStyle(
                  fontSize: AppDimensions.fontSizeTitle,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppDimensions.textContainerGap),
              Text(
                AppStrings.onboardingDescription1,
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
        const SizedBox(height: 150),
      ],
    );
  }
}
