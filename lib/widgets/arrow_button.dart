import 'package:flutter/material.dart';
import '../constants/constants.dart';

class ArrowButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ArrowButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Icon(
        Icons.arrow_forward,
        color: AppColors.arrowButtonColor,
        size: 28,
      ),
    );
  }
}

