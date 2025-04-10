import 'package:flutter/widgets.dart';
import 'dart:math' as math;
import '../theme/brutal_theme.dart';
import 'text.dart';

/// A brutalist linear progress indicator
class BrutalProgressBar extends StatelessWidget {
  final double? value; // null for indeterminate
  final double height;
  final Color? backgroundColor;
  final Color? progressColor;
  final Color? borderColor;
  final double? borderWidth;
  final BrutalProgressVariant variant;
  final bool isGlitched;
  final String? label;
  final bool showPercentage;

  const BrutalProgressBar({
    super.key,
    this.value,
    this.height = 16.0,
    this.backgroundColor,
    this.progressColor,
    this.borderColor,
    this.borderWidth,
    this.variant = BrutalProgressVariant.default_,
    this.isGlitched = false,
    this.label,
    this.showPercentage = false,
  }) : assert(
         value == null || (value >= 0 && value <= 1),
         'Value must be between 0.0 and 1.0',
       );

  /// Creates a broken/glitched progress bar
  factory BrutalProgressBar.broken({
    Key? key,
    double? value,
    double height = 16.0,
    Color? progressColor,
    String? label,
  }) {
    return BrutalProgressBar(
      key: key,
      value: value,
      height: height,
      progressColor: progressColor,
      variant: BrutalProgressVariant.broken,
      isGlitched: true,
      label: label,
    );
  }

  /// Creates a minimal progress bar
  factory BrutalProgressBar.minimal({
    Key? key,
    double? value,
    double height = 8.0,
    Color? progressColor,
    String? label,
    bool showPercentage = false,
  }) {
    return BrutalProgressBar(
      key: key,
      value: value,
      height: height,
      progressColor: progressColor,
      variant: BrutalProgressVariant.minimal,
      label: label,
      showPercentage: showPercentage,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);
    final effectiveBorderWidth = borderWidth ?? theme.borderWidth;

    // Determine colors based on variant
    final bgColor = backgroundColor ?? theme.colors.surface;
    final progColor = progressColor ?? theme.colors.primary;
    final borderCol = borderColor ?? theme.colors.border;

    // For indeterminate animation
    final isIndeterminate = value == null;

    // Build the progress bar
    Widget progressWidget;

    if (isIndeterminate) {
      // For indeterminate progress
      progressWidget = _IndeterminateProgress(
        height: height,
        backgroundColor: bgColor,
        progressColor: progColor,
        borderColor: borderCol,
        borderWidth: effectiveBorderWidth,
        variant: variant,
      );
    } else {
      // For determinate progress
      progressWidget = Container(
        height: height,
        decoration: BoxDecoration(
          color: bgColor,
          border:
              variant != BrutalProgressVariant.minimal
                  ? Border.all(color: borderCol, width: effectiveBorderWidth)
                  : null,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final progressWidth = maxWidth * value!.clamp(0.0, 1.0);

            return Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  width: progressWidth,
                  child: Container(
                    color: progColor,
                    // For pixel variant, use a jagged edge
                    child:
                        variant == BrutalProgressVariant.pixel
                            ? Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  width: 4,
                                  decoration: BoxDecoration(
                                    color: bgColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color: progColor,
                                        offset: const Offset(-2, 0),
                                      ),
                                    ],
                                  ),
                                  child: _buildPixelPattern(
                                    height,
                                    bgColor,
                                    progColor,
                                  ),
                                ),
                              ],
                            )
                            : null,
                  ),
                ),

                // For broken variant, add a displacement effect
                if (variant == BrutalProgressVariant.broken)
                  Positioned(
                    left: progressWidth - 5,
                    top: 0,
                    bottom: 0,
                    width: 10,
                    child: Container(
                      color: progColor.withOpacity(0.7),
                      margin: const EdgeInsets.symmetric(vertical: 2),
                    ),
                  ),

                // Show percentage
                if (showPercentage)
                  Positioned.fill(
                    child: Center(
                      child: BrutalText(
                        '${(value! * 100).toInt()}%',
                        brutalStyle: BrutalTextStyle.caption,
                        style: TextStyle(
                          color:
                              value! > 0.5
                                  ? Color(0xFFFFFFFF)
                                  : theme.colors.text,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      );
    }

    // Apply glitch effect if needed
    if (isGlitched) {
      progressWidget = Stack(
        children: [
          Positioned(
            left: 2,
            top: 0,
            right: 0,
            bottom: 0,
            child: Opacity(
              opacity: 0.7,
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Color(0xFFFF0000),
                  BlendMode.srcATop,
                ),
                child: progressWidget,
              ),
            ),
          ),
          Positioned(
            left: -2,
            top: 0,
            right: 0,
            bottom: 0,
            child: Opacity(
              opacity: 0.7,
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Color(0xFF00FFFF),
                  BlendMode.srcATop,
                ),
                child: progressWidget,
              ),
            ),
          ),
          progressWidget,
        ],
      );
    }

    // Add label if provided
    if (label != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          BrutalText(
            label!,
            brutalStyle: BrutalTextStyle.caption,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          progressWidget,
        ],
      );
    }

    return progressWidget;
  }

  // Helper to build a pixel pattern for the pixel variant
  Widget _buildPixelPattern(double height, Color bgColor, Color progColor) {
    final pixelCount = (height / 4).floor();
    bool isColorA = true;

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: List.generate(pixelCount, (index) {
        isColorA = !isColorA;
        return Container(height: 4, color: isColorA ? bgColor : progColor);
      }),
    );
  }
}

/// Indeterminate progress implementation
class _IndeterminateProgress extends StatefulWidget {
  final double height;
  final Color backgroundColor;
  final Color progressColor;
  final Color borderColor;
  final double borderWidth;
  final BrutalProgressVariant variant;

  const _IndeterminateProgress({
    required this.height,
    required this.backgroundColor,
    required this.progressColor,
    required this.borderColor,
    required this.borderWidth,
    required this.variant,
  });

  @override
  State<_IndeterminateProgress> createState() => _IndeterminateProgressState();
}

class _IndeterminateProgressState extends State<_IndeterminateProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        border:
            widget.variant != BrutalProgressVariant.minimal
                ? Border.all(
                  color: widget.borderColor,
                  width: widget.borderWidth,
                )
                : null,
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = constraints.maxWidth;

              return Stack(
                children: [
                  // For broken variant, add multiple glitchy segments
                  if (widget.variant == BrutalProgressVariant.broken)
                    ..._buildBrokenSegments(maxWidth, widget.height),

                  // Main moving bar
                  Positioned(
                    left: _calculateLeftPosition(maxWidth),
                    width: maxWidth * 0.3,
                    top: 0,
                    bottom: 0,
                    child: Container(color: widget.progressColor),
                  ),

                  // Secondary bar for pixel variant
                  if (widget.variant == BrutalProgressVariant.pixel)
                    Positioned(
                      right: _calculateRightPosition(maxWidth),
                      width: maxWidth * 0.1,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        color: widget.progressColor.withOpacity(0.7),
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  double _calculateLeftPosition(double maxWidth) {
    // Create a back-and-forth movement
    final value = _controller.value;
    if (value < 0.5) {
      // Moving right: 0 -> maxWidth * 0.7
      return maxWidth * 0.7 * (value * 2);
    } else {
      // Moving left: maxWidth * 0.7 -> 0
      return maxWidth * 0.7 * (2 - (value * 2));
    }
  }

  double _calculateRightPosition(double maxWidth) {
    // Opposite movement of the main bar
    final value = 1 - _controller.value;
    if (value < 0.5) {
      return maxWidth * 0.7 * (value * 2);
    } else {
      return maxWidth * 0.7 * (2 - (value * 2));
    }
  }

  List<Widget> _buildBrokenSegments(double maxWidth, double height) {
    // Create 3 small glitchy segments
    final segments = <Widget>[];
    final segmentWidth = maxWidth * 0.05;

    // Calculate positions based on the controller value
    // Offset them to create a glitchy feeling
    final basePos1 = (_controller.value * 0.5 + 0.1) * maxWidth;
    final basePos2 = (_controller.value * 0.3 + 0.4) * maxWidth;
    final basePos3 = (_controller.value * 0.7 + 0.2) * maxWidth;

    segments.add(
      Positioned(
        left: basePos1.clamp(0, maxWidth - segmentWidth),
        width: segmentWidth,
        top: height * 0.2,
        height: height * 0.6,
        child: Container(color: widget.progressColor.withOpacity(0.7)),
      ),
    );

    segments.add(
      Positioned(
        left: basePos2.clamp(0, maxWidth - segmentWidth),
        width: segmentWidth,
        bottom: 0,
        height: height * 0.7,
        child: Container(color: widget.progressColor.withOpacity(0.5)),
      ),
    );

    segments.add(
      Positioned(
        left: basePos3.clamp(0, maxWidth - segmentWidth),
        width: segmentWidth,
        top: 0,
        height: height * 0.8,
        child: Container(color: widget.progressColor.withOpacity(0.6)),
      ),
    );

    return segments;
  }
}

/// A brutalist circular progress indicator
class BrutalProgressSpinner extends StatefulWidget {
  final double? value; // null for indeterminate
  final double size;
  final double strokeWidth;
  final Color? backgroundColor;
  final Color? progressColor;
  final Color? borderColor;
  final BrutalProgressVariant variant;
  final bool isGlitched;

  const BrutalProgressSpinner({
    super.key,
    this.value,
    this.size = 48.0,
    this.strokeWidth = 4.0,
    this.backgroundColor,
    this.progressColor,
    this.borderColor,
    this.variant = BrutalProgressVariant.default_,
    this.isGlitched = false,
  }) : assert(
         value == null || (value >= 0 && value <= 1),
         'Value must be between 0.0 and 1.0',
       );

  /// Creates a broken/glitched spinner
  factory BrutalProgressSpinner.broken({
    Key? key,
    double? value,
    double size = 48.0,
    Color? progressColor,
  }) {
    return BrutalProgressSpinner(
      key: key,
      value: value,
      size: size,
      progressColor: progressColor,
      variant: BrutalProgressVariant.broken,
      isGlitched: true,
    );
  }

  /// Creates a pixel style spinner
  factory BrutalProgressSpinner.pixel({
    Key? key,
    double? value,
    double size = 48.0,
    Color? progressColor,
  }) {
    return BrutalProgressSpinner(
      key: key,
      value: value,
      size: size,
      progressColor: progressColor,
      variant: BrutalProgressVariant.pixel,
    );
  }

  @override
  State<BrutalProgressSpinner> createState() => _BrutalProgressSpinnerState();
}

class _BrutalProgressSpinnerState extends State<BrutalProgressSpinner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    if (widget.value == null) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(BrutalProgressSpinner oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update animation state if we switched between determinate/indeterminate
    if (oldWidget.value == null && widget.value != null) {
      _controller.stop();
    } else if (oldWidget.value != null && widget.value == null) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);

    // Determine colors based on variant
    final bgColor = widget.backgroundColor ?? theme.colors.surface;
    final progColor = widget.progressColor ?? theme.colors.primary;
    final borderCol = widget.borderColor ?? theme.colors.border;

    Widget spinner;
    final isIndeterminate = widget.value == null;

    if (widget.variant == BrutalProgressVariant.pixel) {
      // Pixel variant - square spinner
      spinner = SizedBox(
        width: widget.size,
        height: widget.size,
        child:
            isIndeterminate
                ? _PixelatedIndeterminateSpinner(
                  size: widget.size,
                  backgroundColor: bgColor,
                  progressColor: progColor,
                  borderColor: borderCol,
                  controller: _controller,
                )
                : _PixelatedDeterminateSpinner(
                  value: widget.value!,
                  size: widget.size,
                  backgroundColor: bgColor,
                  progressColor: progColor,
                  borderColor: borderCol,
                ),
      );
    } else {
      // Default and broken variants - circular spinner
      spinner = SizedBox(
        width: widget.size,
        height: widget.size,
        child: CustomPaint(
          painter: _SpinnerPainter(
            value: widget.value,
            animationValue: isIndeterminate ? _controller.value : 0,
            backgroundColor: bgColor,
            progressColor: progColor,
            borderColor: borderCol,
            strokeWidth: widget.strokeWidth,
            variant: widget.variant,
          ),
        ),
      );
    }

    // Apply glitch effect if needed
    if (widget.isGlitched) {
      spinner = Stack(
        children: [
          Positioned(
            left: 2,
            top: 0,
            right: -2,
            bottom: 0,
            child: Opacity(
              opacity: 0.7,
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Color(0xFFFF0000),
                  BlendMode.srcATop,
                ),
                child: spinner,
              ),
            ),
          ),
          Positioned(
            left: -2,
            top: 0,
            right: 2,
            bottom: 0,
            child: Opacity(
              opacity: 0.7,
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Color(0xFF00FFFF),
                  BlendMode.srcATop,
                ),
                child: spinner,
              ),
            ),
          ),
          spinner,
        ],
      );
    }

    return spinner;
  }
}

/// Painter for circular spinner
class _SpinnerPainter extends CustomPainter {
  final double? value;
  final double animationValue;
  final Color backgroundColor;
  final Color progressColor;
  final Color borderColor;
  final double strokeWidth;
  final BrutalProgressVariant variant;

  const _SpinnerPainter({
    this.value,
    required this.animationValue,
    required this.backgroundColor,
    required this.progressColor,
    required this.borderColor,
    required this.strokeWidth,
    required this.variant,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - strokeWidth / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Paint styles
    final bgPaint =
        Paint()
          ..color = backgroundColor
          ..style = PaintingStyle.fill;

    final borderPaint =
        Paint()
          ..color = borderColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth;

    final progressPaint =
        Paint()
          ..color = progressColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.square;

    // Draw background circle if not minimal variant
    if (variant != BrutalProgressVariant.minimal) {
      canvas.drawCircle(center, radius, bgPaint);
    }

    // Border
    if (variant != BrutalProgressVariant.minimal) {
      canvas.drawCircle(center, radius, borderPaint);
    }

    // Determine start/sweep angles
    double startAngle, sweepAngle;

    if (value == null) {
      // Indeterminate animation
      startAngle = -math.pi / 2 + animationValue * 2 * math.pi;
      sweepAngle =
          variant == BrutalProgressVariant.broken
              ? math.pi * 0.4 +
                  math.sin(animationValue * math.pi) * math.pi * 0.2
              : math.pi * 0.5;
    } else {
      // Determinate progress
      startAngle = -math.pi / 2;
      sweepAngle = 2 * math.pi * value!;
    }

    // Draw progress arc
    canvas.drawArc(rect, startAngle, sweepAngle, false, progressPaint);

    // For broken variant, add glitchy segments
    if (variant == BrutalProgressVariant.broken) {
      final glitchPaint =
          Paint()
            ..color = progressColor.withOpacity(0.7)
            ..style = PaintingStyle.stroke
            ..strokeWidth = strokeWidth * 0.6;

      // Add 2-3 small glitchy arcs
      final offset1 = animationValue * 2 * math.pi;
      final offset2 = (animationValue + 0.33) * 2 * math.pi;
      final offset3 = (animationValue + 0.66) * 2 * math.pi;

      canvas.drawArc(rect, offset1, math.pi * 0.2, false, glitchPaint);
      canvas.drawArc(rect, offset2, math.pi * 0.15, false, glitchPaint);
      canvas.drawArc(rect, offset3, math.pi * 0.1, false, glitchPaint);
    }
  }

  @override
  bool shouldRepaint(_SpinnerPainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.variant != variant;
  }
}

/// Pixelated determinate spinner
class _PixelatedDeterminateSpinner extends StatelessWidget {
  final double value;
  final double size;
  final Color backgroundColor;
  final Color progressColor;
  final Color borderColor;

  const _PixelatedDeterminateSpinner({
    required this.value,
    required this.size,
    required this.backgroundColor,
    required this.progressColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    const cellCount = 10; // 10x10 grid
    final cellSize = size / cellCount;

    // Calculate how many cells to fill
    final filledCells = (value * (cellCount * 4 - 4)).floor();

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor, width: 2),
      ),
      child: CustomPaint(
        painter: _PixelSpinnerPainter(
          filledCells: filledCells,
          totalCells: cellCount * 4 - 4, // perimeter
          cellSize: cellSize,
          progressColor: progressColor,
        ),
      ),
    );
  }
}

/// Pixelated indeterminate spinner
class _PixelatedIndeterminateSpinner extends StatelessWidget {
  final double size;
  final Color backgroundColor;
  final Color progressColor;
  final Color borderColor;
  final AnimationController controller;

  const _PixelatedIndeterminateSpinner({
    required this.size,
    required this.backgroundColor,
    required this.progressColor,
    required this.borderColor,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    const cellCount = 10; // 10x10 grid
    final cellSize = size / cellCount;
    final totalCells = cellCount * 4 - 4; // perimeter

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        // Animate a sequence of cells
        final sequenceLength = totalCells ~/ 2;
        final startCell = (controller.value * totalCells).floor();

        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: borderColor, width: 2),
          ),
          child: CustomPaint(
            painter: _PixelSpinnerPainter.sequence(
              startCell: startCell,
              sequenceLength: sequenceLength,
              totalCells: totalCells,
              cellSize: cellSize,
              progressColor: progressColor,
            ),
          ),
        );
      },
    );
  }
}

/// Painter for pixelated spinner (used by both determinate and indeterminate)
class _PixelSpinnerPainter extends CustomPainter {
  final int filledCells;
  final int totalCells;
  final int? startCell;
  final int? sequenceLength;
  final double cellSize;
  final Color progressColor;

  const _PixelSpinnerPainter({
    required this.filledCells,
    required this.totalCells,
    required this.cellSize,
    required this.progressColor,
  }) : startCell = null,
       sequenceLength = null;

  const _PixelSpinnerPainter.sequence({
    required this.startCell,
    required this.sequenceLength,
    required this.totalCells,
    required this.cellSize,
    required this.progressColor,
  }) : filledCells = 0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = progressColor;
    final cellsPerSide = (size.width / cellSize).floor();

    // If using sequence mode (indeterminate)
    if (startCell != null && sequenceLength != null) {
      for (int i = 0; i < sequenceLength!; i++) {
        final cellIndex = (startCell! + i) % totalCells;
        _drawCell(canvas, cellIndex, cellsPerSide, paint);
      }
    } else {
      // Determinate mode
      for (int i = 0; i < filledCells; i++) {
        _drawCell(canvas, i, cellsPerSide, paint);
      }
    }
  }

  void _drawCell(Canvas canvas, int index, int cellsPerSide, Paint paint) {
    // Calculate position based on index
    // We're drawing around the perimeter of the square

    final side = cellsPerSide - 1; // Cells per side excluding corners

    late Offset position;

    if (index < side) {
      // Top side (left to right)
      position = Offset(index * cellSize, 0);
    } else if (index < 2 * side) {
      // Right side (top to bottom)
      position = Offset(side * cellSize, (index - side) * cellSize);
    } else if (index < 3 * side) {
      // Bottom side (right to left)
      position = Offset((3 * side - index) * cellSize, side * cellSize);
    } else {
      // Left side (bottom to top)
      position = Offset(0, (4 * side - index) * cellSize);
    }

    canvas.drawRect(
      Rect.fromLTWH(position.dx, position.dy, cellSize, cellSize),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is _PixelSpinnerPainter) {
      return oldDelegate.filledCells != filledCells ||
          oldDelegate.startCell != startCell ||
          oldDelegate.progressColor != progressColor;
    }
    return true;
  }
}

/// An overlay to show a loading state with a spinner and optional message
class BrutalLoading extends StatelessWidget {
  final String? message;
  final double spinnerSize;
  final Color? backgroundColor;
  final Color? progressColor;
  final BrutalProgressVariant variant;
  final bool isGlitched;
  final bool fullScreen;

  const BrutalLoading({
    super.key,
    this.message,
    this.spinnerSize = 48.0,
    this.backgroundColor,
    this.progressColor,
    this.variant = BrutalProgressVariant.default_,
    this.isGlitched = false,
    this.fullScreen = false,
  });

  /// Creates a blocking fullscreen loading overlay
  factory BrutalLoading.fullscreen({
    Key? key,
    String? message,
    Color? backgroundColor,
    Color? progressColor,
    BrutalProgressVariant variant = BrutalProgressVariant.default_,
    bool isGlitched = false,
  }) {
    return BrutalLoading(
      key: key,
      message: message,
      backgroundColor: backgroundColor,
      progressColor: progressColor,
      variant: variant,
      isGlitched: isGlitched,
      fullScreen: true,
      spinnerSize: 64.0,
    );
  }

  /// Creates a broken/glitched loading overlay
  factory BrutalLoading.broken({
    Key? key,
    String? message,
    double spinnerSize = 48.0,
  }) {
    return BrutalLoading(
      key: key,
      message: message,
      spinnerSize: spinnerSize,
      variant: BrutalProgressVariant.broken,
      isGlitched: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);
    final bgColor =
        backgroundColor ??
        (fullScreen
            ? theme.colors.background.withOpacity(0.9)
            : theme.colors.surface.withOpacity(0.8));
    final progColor = progressColor ?? theme.colors.primary;

    Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BrutalProgressSpinner(
          size: spinnerSize,
          progressColor: progColor,
          variant: variant,
          isGlitched: isGlitched,
        ),

        if (message != null) ...[
          SizedBox(height: theme.spacing),
          BrutalText(
            message!,
            isGlitched: isGlitched,
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );

    if (!fullScreen) {
      content = Container(
        padding: EdgeInsets.all(theme.spacing * 1.5),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(
            color: theme.colors.border,
            width: theme.borderWidth,
          ),
        ),
        child: content,
      );
    } else {
      content = Container(
        color: bgColor,
        alignment: Alignment.center,
        child: content,
      );
    }

    if (fullScreen) {
      return content;
    } else {
      return Center(child: content);
    }
  }
}

/// Progress indicator variants
enum BrutalProgressVariant { default_, minimal, broken, pixel }
