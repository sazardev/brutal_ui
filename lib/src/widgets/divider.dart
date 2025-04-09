import 'package:flutter/widgets.dart';
import '../theme/brutal_theme.dart';

class BrutalDivider extends StatelessWidget {
  final double thickness;
  final Color? color;
  final EdgeInsetsGeometry margin;
  final Axis direction;
  final double? width;
  final double? height;
  final BrutalDividerVariant variant;

  const BrutalDivider({
    super.key,
    this.thickness = 1.0,
    this.color,
    this.margin = EdgeInsets.zero,
    this.direction = Axis.horizontal,
    this.width,
    this.height,
    this.variant = BrutalDividerVariant.solid,
  });

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);
    final dividerColor = color ?? theme.colors.border;

    // Construir el divider según la variante
    switch (variant) {
      case BrutalDividerVariant.solid:
        return Container(
          margin: margin,
          width: direction == Axis.vertical ? thickness : width,
          height: direction == Axis.horizontal ? thickness : height,
          color: dividerColor,
        );

      case BrutalDividerVariant.dashed:
        return Container(
          margin: margin,
          width: direction == Axis.vertical ? thickness : width,
          height: direction == Axis.horizontal ? thickness : height,
          child: CustomPaint(
            painter: DashedLinePainter(
              direction: direction,
              color: dividerColor,
              strokeWidth: thickness,
            ),
            size: Size(
              direction == Axis.vertical
                  ? thickness
                  : (width ?? double.infinity),
              direction == Axis.horizontal
                  ? thickness
                  : (height ?? double.infinity),
            ),
          ),
        );

      case BrutalDividerVariant.double:
        return Container(
          margin: margin,
          width: direction == Axis.vertical ? (thickness * 3) : width,
          height: direction == Axis.horizontal ? (thickness * 3) : height,
          child: Stack(
            children: [
              Positioned(
                top: direction == Axis.horizontal ? 0 : null,
                left: direction == Axis.vertical ? 0 : null,
                child: Container(
                  width:
                      direction == Axis.vertical
                          ? thickness
                          : (width ?? double.infinity),
                  height:
                      direction == Axis.horizontal
                          ? thickness
                          : (height ?? double.infinity),
                  color: dividerColor,
                ),
              ),
              Positioned(
                bottom: direction == Axis.horizontal ? 0 : null,
                right: direction == Axis.vertical ? 0 : null,
                child: Container(
                  width:
                      direction == Axis.vertical
                          ? thickness
                          : (width ?? double.infinity),
                  height:
                      direction == Axis.horizontal
                          ? thickness
                          : (height ?? double.infinity),
                  color: dividerColor,
                ),
              ),
            ],
          ),
        );

      case BrutalDividerVariant.jagged:
        return Container(
          margin: margin,
          width: direction == Axis.vertical ? (thickness * 2) : width,
          height: direction == Axis.horizontal ? (thickness * 2) : height,
          child: CustomPaint(
            painter: JaggedLinePainter(
              direction: direction,
              color: dividerColor,
              strokeWidth: thickness,
            ),
            size: Size(
              direction == Axis.vertical
                  ? (thickness * 2)
                  : (width ?? double.infinity),
              direction == Axis.horizontal
                  ? (thickness * 2)
                  : (height ?? double.infinity),
            ),
          ),
        );
    }
  }
}

class DashedLinePainter extends CustomPainter {
  final Axis direction;
  final Color color;
  final double strokeWidth;

  DashedLinePainter({
    required this.direction,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;

    final dashWidth = 4.0;
    final dashSpace = 3.0;
    double currentPos = 0.0;

    if (direction == Axis.horizontal) {
      while (currentPos < size.width) {
        canvas.drawLine(
          Offset(currentPos, 0),
          Offset(currentPos + dashWidth, 0),
          paint,
        );
        currentPos += dashWidth + dashSpace;
      }
    } else {
      while (currentPos < size.height) {
        canvas.drawLine(
          Offset(0, currentPos),
          Offset(0, currentPos + dashWidth),
          paint,
        );
        currentPos += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class JaggedLinePainter extends CustomPainter {
  final Axis direction;
  final Color color;
  final double strokeWidth;

  JaggedLinePainter({
    required this.direction,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..style = PaintingStyle.stroke;

    final path = Path();

    if (direction == Axis.horizontal) {
      final segmentWidth = 8.0;
      var currentPos = 0.0;
      path.moveTo(0, 0);

      while (currentPos < size.width) {
        path.lineTo(currentPos + segmentWidth / 2, strokeWidth);
        path.lineTo(currentPos + segmentWidth, 0);
        currentPos += segmentWidth;
      }
    } else {
      final segmentHeight = 8.0;
      var currentPos = 0.0;
      path.moveTo(0, 0);

      while (currentPos < size.height) {
        path.lineTo(strokeWidth, currentPos + segmentHeight / 2);
        path.lineTo(0, currentPos + segmentHeight);
        currentPos += segmentHeight;
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

enum BrutalDividerVariant {
  solid, // Divider sólido estándar
  dashed, // Divider discontinuo
  double, // Divider doble
  jagged, // Divider dentado
}
