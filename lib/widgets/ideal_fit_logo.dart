import 'package:flutter/material.dart';
import '../constants/constants.dart';

class IdealFitLogo extends StatelessWidget {
  final double size;

  const IdealFitLogo({
    super.key,
    this.size = 200,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        size: Size(size, size),
        painter: _IdealFitLogoPainter(),
      ),
    );
  }
}

class _IdealFitLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final leafSize = size.width * 0.35;

    // Draw the left leaves (darker green)
    _drawLeaf(
      canvas,
      center,
      leafSize,
      -45,
      const Color(0xFF4CAF50), // Primary green
      true,
    );
    _drawLeaf(
      canvas,
      center,
      leafSize * 0.85,
      -75,
      const Color(0xFF66BB6A), // Lighter green
      true,
    );
    _drawLeaf(
      canvas,
      center,
      leafSize * 0.7,
      -105,
      const Color(0xFF81C784), // Even lighter
      true,
    );

    // Draw the right leaves (yellow-green)
    _drawLeaf(
      canvas,
      center,
      leafSize,
      45,
      const Color(0xFF8BC34A), // Light green
      false,
    );
    _drawLeaf(
      canvas,
      center,
      leafSize * 0.85,
      75,
      const Color(0xFF9CCC65), // Yellow-green
      false,
    );
    _drawLeaf(
      canvas,
      center,
      leafSize * 0.7,
      105,
      const Color(0xFFAED581), // Light yellow-green
      false,
    );

    // Draw the center person shape
    _drawPerson(canvas, center, size.width * 0.15);
  }

  void _drawLeaf(
    Canvas canvas,
    Offset center,
    double size,
    double angle,
    Color color,
    bool isLeft,
  ) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.save();
    canvas.translate(center.dx, center.dy + size * 0.3);
    canvas.rotate(angle * 3.14159 / 180);

    final path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(
      isLeft ? -size * 0.5 : size * 0.5,
      -size * 0.3,
      0,
      -size,
    );
    path.quadraticBezierTo(
      isLeft ? size * 0.3 : -size * 0.3,
      -size * 0.5,
      0,
      0,
    );
    path.close();

    canvas.drawPath(path, paint);
    canvas.restore();
  }

  void _drawPerson(Canvas canvas, Offset center, double size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Head (circle)
    canvas.drawCircle(
      Offset(center.dx, center.dy + size * 0.5),
      size * 0.35,
      paint,
    );

    // Body (triangle/V shape)
    final bodyPath = Path();
    bodyPath.moveTo(center.dx - size * 0.8, center.dy + size * 1.5);
    bodyPath.lineTo(center.dx, center.dy + size * 0.9);
    bodyPath.lineTo(center.dx + size * 0.8, center.dy + size * 1.5);
    bodyPath.quadraticBezierTo(
      center.dx,
      center.dy + size * 1.2,
      center.dx - size * 0.8,
      center.dy + size * 1.5,
    );
    bodyPath.close();

    canvas.drawPath(bodyPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
