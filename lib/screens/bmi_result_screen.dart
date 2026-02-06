import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../widgets/bottom_nav_bar.dart';

class BMIResultScreen extends StatefulWidget {
  final double bmiValue;
  final String userName;

  const BMIResultScreen({
    super.key,
    required this.bmiValue,
    required this.userName,
  });

  @override
  State<BMIResultScreen> createState() => _BMIResultScreenState();
}

class _BMIResultScreenState extends State<BMIResultScreen> {
  int _currentNavIndex = 0;

  void _onNavItemTapped(int index) {
    setState(() {
      _currentNavIndex = index;
    });
  }

  String _getBMIMessage(double bmi) {
    if (bmi < 18.5) {
      return 'Your BMI is below the healthy range. Consider gaining some weight.';
    } else if (bmi < 25) {
      return 'Your BMI is in the healthy range. Keep up the good work !';
    } else if (bmi < 30) {
      return 'Your BMI is above the healthy range. Consider losing some weight.';
    } else {
      return 'Your BMI indicates obesity. Please consult a healthcare provider.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      // Header with back button
                      _buildHeader(),
                      const SizedBox(height: 50),
                      // BMI Value
                      Text(
                        widget.bmiValue.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 96,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF57D935),
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // BMI Message
                      Text(
                        _getBMIMessage(widget.bmiValue),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      // BMI Gradient Scale
                      _buildBMIScale(),
                      const SizedBox(height: 8),
                      // Scale labels
                      _buildScaleLabels(),
                      const SizedBox(height: 50),
                      // BMI Range Card
                      _buildBMIRangeCard(),
                      const SizedBox(height: 30),
                      // Get Personalised AI Advices Button
                      _buildAIAdvicesButton(),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
            // Bottom navigation bar
            BottomNavBar(
              currentIndex: _currentNavIndex,
              onTap: _onNavItemTapped,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 68,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back button and title
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                AppStrings.yourBmiResult,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          // BMI icon
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                AppImages.bmiIcon,
                width: 44,
                height: 44,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBMIScale() {
    // Calculate position for the indicator based on BMI value
    double indicatorPosition = _calculateIndicatorPosition(widget.bmiValue);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 390,
          height: 28,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFFF3A00C), // Orange
                Color(0xFFD2C11D), // Yellow
                Color(0xFFBDD527), // Yellow-green
                Color(0xFF92C384), // Light green
                Color(0xFF62A6F6), // Blue
              ],
              stops: [0.0, 0.25, 0.5192, 0.7788, 1.0],
            ),
          ),
        ),
        // BMI indicator triangle
        Positioned(
          left: indicatorPosition,
          bottom: -8,
          child: CustomPaint(
            size: const Size(16, 10),
            painter: TrianglePainter(),
          ),
        ),
      ],
    );
  }

  double _calculateIndicatorPosition(double bmi) {
    // Scale: 15 (left) to 35 (right)
    double minBmi = 15;
    double maxBmi = 35;
    double clampedBmi = bmi.clamp(minBmi, maxBmi);
    double percentage = (clampedBmi - minBmi) / (maxBmi - minBmi);
    return (390 - 16) * percentage; // 390 width - 16 indicator width
  }

  Widget _buildScaleLabels() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('15', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          Text('20', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          Text('25', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          Text('30', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          Text('35', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildBMIRangeCard() {
    return Container(
      width: 390,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title with dot
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                AppStrings.bmiRange,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // BMI categories
          Row(
            children: [
              Expanded(
                child: _buildCategoryItem(Color(0xFF62A6F6), AppStrings.underweight),
              ),
              Expanded(
                child: _buildCategoryItem(Color(0xFF57D935), AppStrings.normal),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildCategoryItem(Color(0xFFD2C11D), AppStrings.overweight),
              ),
              Expanded(
                child: _buildCategoryItem(Color(0xFFF3A00C), AppStrings.obesity),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAIAdvicesButton() {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to AI advices
      },
      child: Container(
        width: 321,
        height: 57,
        decoration: BoxDecoration(
          color: Color(0xFF57D935),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Center(
          child: Text(
            AppStrings.getPersonalisedAiAdvices,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// Triangle painter for BMI indicator
class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
