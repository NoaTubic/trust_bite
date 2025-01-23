import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AnimatedOverlay extends HookWidget {
  const AnimatedOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    final scaleController = useAnimationController(
      duration: const Duration(milliseconds: 500),
    );

    final scanLineController = useAnimationController(
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    useEffect(() {
      scaleController.forward();
      return () {
        scaleController.dispose();
        scanLineController.dispose();
      };
    }, const []);

    return AnimatedBuilder(
      animation: Listenable.merge([scaleController, scanLineController]),
      builder: (context, child) {
        return CustomPaint(
          painter: MixedOverlayPainter(
            scaleValue: scaleController.value,
            scanLineValue: scanLineController.value,
          ),
          child: Container(),
        );
      },
    );
  }
}

class MixedOverlayPainter extends CustomPainter {
  final double scaleValue;
  final double scanLineValue;

  MixedOverlayPainter({
    required this.scaleValue,
    required this.scanLineValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double width = size.width * 0.9 * scaleValue;
    final double height = size.width * 0.6 * scaleValue;

    final double left = (size.width - width) / 2;
    final double top = (size.height - height) / 2;
    final Rect rect = Rect.fromLTWH(left, top, width, height);

    final Paint overlayPaint = Paint()
      ..color = Colors.black.withOpacity(0.5 * scaleValue);
    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    final double scanLineY = top + scanLineValue * height;
    double opacity = 1.0 - (scanLineValue - 0.5).abs() * 2;
    final Paint scanLinePaint = Paint()
      ..color = Colors.red.withOpacity(opacity * 0.75)
      ..style = PaintingStyle.fill;

    final Path scanLinePath = Path()
      ..moveTo(left, scanLineY)
      ..lineTo(left + width, scanLineY)
      ..lineTo(left + width, scanLineY + 3)
      ..lineTo(left, scanLineY + 3)
      ..close();

    final Path backgroundPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    const Radius radius = Radius.circular(8);
    final Path foregroundPath = Path()
      ..addRRect(RRect.fromRectAndRadius(rect, radius));

    final Path combinedPath =
        Path.combine(PathOperation.difference, backgroundPath, foregroundPath);

    canvas.drawPath(combinedPath, overlayPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(rect, radius), borderPaint);
    canvas.drawPath(scanLinePath, scanLinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
