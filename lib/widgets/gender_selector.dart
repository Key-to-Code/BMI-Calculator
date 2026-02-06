import 'package:flutter/material.dart';
import '../constants/constants.dart';

class GenderSelector extends StatelessWidget {
  final String selectedGender;
  final Function(String) onGenderSelected;

  const GenderSelector({
    super.key,
    required this.selectedGender,
    required this.onGenderSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Female option (first)
        Expanded(
          child: GestureDetector(
            onTap: () => onGenderSelected('female'),
            child: Container(
              height: 155,
              decoration: BoxDecoration(
                color: selectedGender == 'female'
                    ? AppColors.genderSelectedBg
                    : AppColors.genderUnselectedBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Female icon - dress shape
                  CustomPaint(
                    size: const Size(50, 60),
                    painter: FemaleIconPainter(
                      color: AppColors.femaleIconColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    AppStrings.female,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: selectedGender == 'female'
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 19),
        // Male option (second)
        Expanded(
          child: GestureDetector(
            onTap: () => onGenderSelected('male'),
            child: Container(
              height: 155,
              decoration: BoxDecoration(
                color: selectedGender == 'male'
                    ? AppColors.genderSelectedBg
                    : AppColors.genderUnselectedBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Male icon - pants shape
                  CustomPaint(
                    size: const Size(50, 60),
                    painter: MaleIconPainter(
                      color: AppColors.maleIconColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    AppStrings.male,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: selectedGender == 'male'
                          ? AppColors.maleIconColor
                          : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Custom painter for female icon (dress shape)
class FemaleIconPainter extends CustomPainter {
  final Color color;

  FemaleIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Head
    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.12),
      size.width * 0.16,
      paint,
    );

    // Body/Dress
    final bodyPath = Path();
    bodyPath.moveTo(size.width * 0.5, size.height * 0.25);
    bodyPath.lineTo(size.width * 0.25, size.height * 0.7);
    bodyPath.lineTo(size.width * 0.35, size.height * 0.7);
    bodyPath.lineTo(size.width * 0.42, size.height * 0.5);
    bodyPath.lineTo(size.width * 0.42, size.height);
    bodyPath.lineTo(size.width * 0.58, size.height);
    bodyPath.lineTo(size.width * 0.58, size.height * 0.5);
    bodyPath.lineTo(size.width * 0.65, size.height * 0.7);
    bodyPath.lineTo(size.width * 0.75, size.height * 0.7);
    bodyPath.lineTo(size.width * 0.5, size.height * 0.25);
    bodyPath.close();

    canvas.drawPath(bodyPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom painter for male icon (pants shape)
class MaleIconPainter extends CustomPainter {
  final Color color;

  MaleIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Head
    canvas.drawCircle(
      Offset(size.width / 2, size.height * 0.12),
      size.width * 0.16,
      paint,
    );

    // Shoulders and body
    final bodyPath = Path();
    // Left shoulder
    bodyPath.moveTo(size.width * 0.2, size.height * 0.3);
    bodyPath.lineTo(size.width * 0.2, size.height * 0.55);
    bodyPath.lineTo(size.width * 0.35, size.height * 0.55);
    bodyPath.lineTo(size.width * 0.35, size.height);
    bodyPath.lineTo(size.width * 0.45, size.height);
    bodyPath.lineTo(size.width * 0.45, size.height * 0.55);
    bodyPath.lineTo(size.width * 0.55, size.height * 0.55);
    bodyPath.lineTo(size.width * 0.55, size.height);
    bodyPath.lineTo(size.width * 0.65, size.height);
    bodyPath.lineTo(size.width * 0.65, size.height * 0.55);
    bodyPath.lineTo(size.width * 0.8, size.height * 0.55);
    bodyPath.lineTo(size.width * 0.8, size.height * 0.3);
    bodyPath.lineTo(size.width * 0.5, size.height * 0.25);
    bodyPath.lineTo(size.width * 0.2, size.height * 0.3);
    bodyPath.close();

    canvas.drawPath(bodyPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
