import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../widgets/page_indicator.dart';
import '../widgets/arrow_button.dart';
import 'onboarding/onboarding_pages.dart';
import 'bmi_calculator_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 3;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToMainScreen();
    }
  }

  void _skipOnboarding() {
    _navigateToMainScreen();
  }

  void _navigateToMainScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const BMICalculatorScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            // PageView for onboarding pages
            PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                const OnboardingPage1(),
                const OnboardingPage2(),
                OnboardingPage3(onGetStarted: _navigateToMainScreen),
              ],
            ),

            // Bottom navigation area (hidden on page 3)
            if (_currentPage < _totalPages - 1)
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.screenPaddingHorizontal,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Skip button on the left (visible from page 2 onwards)
                      if (_currentPage > 0)
                        Positioned(
                          left: 0,
                          child: GestureDetector(
                            onTap: _skipOnboarding,
                            child: Text(
                              AppStrings.skip,
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.primaryGreen,
                              ),
                            ),
                          ),
                        ),
                      // Centered Page indicators
                      Center(
                        child: PageIndicator(
                          currentPage: _currentPage,
                          totalPages: _totalPages,
                        ),
                      ),
                      // Arrow button positioned on the right
                      Positioned(
                        right: 0,
                        child: ArrowButton(
                          onPressed: _nextPage,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
