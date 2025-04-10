import 'package:flutter/widgets.dart';
import 'dart:math' as math;
import '../theme/brutal_theme.dart';
import 'text.dart';

/// A brutalist linear progress indicator
class BrutalProgressBar extends StatefulWidget {
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

  /// Creates a pixel art style progress bar
  factory BrutalProgressBar.pixel({
    Key? key,
    double? value,
    double height = 16.0,
    Color? progressColor,
    String? label,
    bool showPercentage = false,
  }) {
    return BrutalProgressBar(
      key: key,
      value: value,
      height: height,
      progressColor: progressColor,
      variant: BrutalProgressVariant.pixel,
      label: label,
      showPercentage: showPercentage,
    );
  }

  @override
  State<BrutalProgressBar> createState() => _BrutalProgressBarState();
}

class _BrutalProgressBarState extends State<BrutalProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _valueAnimation;
  late Animation<double> _glitchOffsetAnimation;
  late Animation<double> _glitchIntensityAnimation;
  double _previousValue = 0.0;

  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // Animaciones para el valor de progreso
    _valueAnimation = Tween<double>(
      begin: 0.0,
      end: widget.value ?? 0.0,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
    );

    // Animaciones para efectos glitch
    _glitchOffsetAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 2), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 2, end: -1), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: -1, end: 0), weight: 1),
    ]).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.7, 1.0)),
    );

    _glitchIntensityAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 0.7, end: 0.9), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 0.9, end: 0.6), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 0.6, end: 0.7), weight: 1),
    ]).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.5, 1.0)),
    );

    if (widget.value != null) {
      _controller.forward();
    } else {
      // Si es indeterminado, hacemos que el controlador se repita
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(BrutalProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value != oldWidget.value && widget.value != null) {
      // Actualizar la animación cuando cambia el valor
      _previousValue = _valueAnimation.value;
      _valueAnimation = Tween<double>(
        begin: _previousValue,
        end: widget.value!,
      ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
      );

      _controller.reset();
      _controller.forward();
    }

    // Manejar cambio entre determinado/indeterminado
    if (oldWidget.value != null && widget.value == null) {
      _controller.reset();
      _controller.repeat();
    } else if (oldWidget.value == null && widget.value != null) {
      _controller.stop();
      _controller.reset();
      _valueAnimation = Tween<double>(begin: 0.0, end: widget.value!).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
      );
      _controller.forward();
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
    final effectiveBorderWidth = widget.borderWidth ?? theme.borderWidth;

    // Determine colors based on variant
    final bgColor = widget.backgroundColor ?? theme.colors.surface;
    final progColor = widget.progressColor ?? theme.colors.primary;
    final borderCol = widget.borderColor ?? theme.colors.border;

    // For indeterminate animation
    final isIndeterminate = widget.value == null;

    // Build the progress bar
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        Widget progressWidget;

        if (isIndeterminate) {
          // For indeterminate progress
          progressWidget = _IndeterminateProgress(
            height: widget.height,
            backgroundColor: bgColor,
            progressColor: progColor,
            borderColor: borderCol,
            borderWidth: effectiveBorderWidth,
            variant: widget.variant,
            animationValue: _controller.value,
          );
        } else {
          // For determinate progress
          progressWidget = Container(
            height: widget.height,
            decoration: BoxDecoration(
              color: bgColor,
              border:
                  widget.variant != BrutalProgressVariant.minimal
                      ? Border.all(
                        color: borderCol,
                        width: effectiveBorderWidth,
                      )
                      : null,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final maxWidth = constraints.maxWidth;
                final progressWidth =
                    maxWidth * _valueAnimation.value.clamp(0.0, 1.0);

                return Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      width: progressWidth,
                      child: Container(
                        color: progColor,
                        child:
                            widget.variant == BrutalProgressVariant.pixel
                                ? _buildPixelPattern(
                                  widget.height,
                                  bgColor,
                                  progColor,
                                )
                                : null,
                      ),
                    ),

                    // For broken variant, add dynamic displacement effects
                    if (widget.variant == BrutalProgressVariant.broken) ...[
                      Positioned(
                        left: progressWidth - 5,
                        top: 0,
                        bottom: 0,
                        width: 10,
                        child: Container(
                          color: progColor.withOpacity(0.7),
                          margin: EdgeInsets.symmetric(
                            vertical: 2 * math.sin(_controller.value * math.pi),
                          ),
                        ),
                      ),

                      // Adicional glitch effect para variante broken
                      if (widget.isGlitched)
                        Positioned(
                          left:
                              progressWidth * 0.7 +
                              _random.nextDouble() * 10 -
                              5,
                          top: 0,
                          bottom: 0,
                          width: 5,
                          child: Container(
                            color: progColor.withOpacity(0.5),
                            margin: EdgeInsets.symmetric(
                              vertical:
                                  _random.nextDouble() * widget.height * 0.4,
                            ),
                          ),
                        ),
                    ],

                    // Show percentage with animation
                    if (widget.showPercentage)
                      Positioned.fill(
                        child: Center(
                          child: BrutalText(
                            '${(_valueAnimation.value * 100).toInt()}%',
                            brutalStyle: BrutalTextStyle.caption,
                            style: TextStyle(
                              color:
                                  _valueAnimation.value > 0.5
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

        // Apply glitch effect if needed with dynamic intensity
        if (widget.isGlitched) {
          progressWidget = Stack(
            children: [
              // Red channel con offset dinámico
              Positioned(
                left:
                    widget.variant == BrutalProgressVariant.broken
                        ? 2 +
                            _glitchOffsetAnimation
                                .value // offset dinámico para broken
                        : 2, // offset estático para otros
                top: 0,
                right: 0,
                bottom: 0,
                child: Opacity(
                  opacity:
                      widget.variant == BrutalProgressVariant.broken
                          ? _glitchIntensityAnimation.value
                          : 0.7,
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      Color(0xFFFF0000),
                      BlendMode.srcATop,
                    ),
                    child: progressWidget,
                  ),
                ),
              ),

              // Blue channel con offset dinámico
              Positioned(
                left:
                    widget.variant == BrutalProgressVariant.broken
                        ? -2 -
                            _glitchOffsetAnimation
                                .value // offset dinámico para broken
                        : -2, // offset estático para otros
                top: 0,
                right: 0,
                bottom: 0,
                child: Opacity(
                  opacity:
                      widget.variant == BrutalProgressVariant.broken
                          ? _glitchIntensityAnimation.value
                          : 0.7,
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF00FFFF),
                      BlendMode.srcATop,
                    ),
                    child: progressWidget,
                  ),
                ),
              ),

              // Capa principal
              progressWidget,
            ],
          );
        }

        // Add label if provided
        if (widget.label != null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              BrutalText(
                widget.label!,
                brutalStyle: BrutalTextStyle.caption,
                style: const TextStyle(fontWeight: FontWeight.bold),
                isGlitched:
                    widget.isGlitched &&
                    widget.variant == BrutalProgressVariant.broken,
              ),
              const SizedBox(height: 4),
              progressWidget,
            ],
          );
        }

        return progressWidget;
      },
    );
  }

  // Helper to build a pixel pattern for the pixel variant
  Widget _buildPixelPattern(double height, Color bgColor, Color progColor) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double pixelSize = math.min(height / 4, 4);
        final pixelCountY = (height / pixelSize).floor();
        final pixelCountX = (constraints.maxWidth / pixelSize).ceil();

        // Crear un patrón de pixeles animado
        final baseOffset = (_controller.value * 10).floor() % 2;

        return Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  // Capa base de color
                  Container(color: progColor),

                  // Patrón de píxeles
                  for (int x = 0; x < pixelCountX; x++)
                    for (int y = 0; y < pixelCountY; y++)
                      if ((x + y + baseOffset) % 2 == 0)
                        Positioned(
                          left: x * pixelSize,
                          top: y * pixelSize,
                          width: pixelSize,
                          height: pixelSize,
                          child: Container(color: bgColor.withOpacity(0.5)),
                        ),
                ],
              ),
            ),
            // Borde dentado animado
            Container(
              width: pixelSize,
              child: Column(
                children: List.generate(pixelCountY, (index) {
                  return Container(
                    height: pixelSize,
                    color: (index + baseOffset) % 2 == 0 ? progColor : bgColor,
                  );
                }),
              ),
            ),
          ],
        );
      },
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
  final double animationValue;

  const _IndeterminateProgress({
    required this.height,
    required this.backgroundColor,
    required this.progressColor,
    required this.borderColor,
    required this.borderWidth,
    required this.variant,
    required this.animationValue,
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
  late Animation<double> _valueAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _glitchAnimation;
  double _previousValue = 0.0;
  final _random = math.Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Animación de progreso para transiciones suaves
    _valueAnimation = Tween<double>(
      begin: 0.0,
      end: widget.value ?? 0.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    // Animación de rotación para spinners indeterminados
    _rotationAnimation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOutCubic),
      ),
    );

    // Animación para efectos glitch
    _glitchAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 0.0, end: 1.0), weight: 20),
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 0.3), weight: 2),
      TweenSequenceItem(tween: Tween<double>(begin: 0.3, end: 0.7), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 0.7, end: 0.0), weight: 10),
    ]).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.5, 1.0)),
    );

    if (widget.value == null) {
      _controller.repeat();
    } else {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(BrutalProgressSpinner oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Actualizar animación cuando cambia el valor
    if (widget.value != oldWidget.value) {
      if (widget.value != null && oldWidget.value != null) {
        _previousValue = _valueAnimation.value;
        _valueAnimation = Tween<double>(
          begin: _previousValue,
          end: widget.value!,
        ).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
        );

        _controller.reset();
        _controller.forward();
      }
      // Manejar cambio entre determinado/indeterminado
      else if (oldWidget.value == null && widget.value != null) {
        _controller.stop();
        _controller.reset();
        _valueAnimation = Tween<double>(begin: 0.0, end: widget.value!).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
        );
        _controller.forward();
      } else if (oldWidget.value != null && widget.value == null) {
        _controller.reset();
        _controller.repeat();
      }
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

    final isIndeterminate = widget.value == null;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        Widget spinner;

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
                      value: _valueAnimation.value,
                      size: widget.size,
                      backgroundColor: bgColor,
                      progressColor: progColor,
                      borderColor: borderCol,
                    ),
          );
        } else {
          // Default y broken variants - circular spinner
          spinner = SizedBox(
            width: widget.size,
            height: widget.size,
            child:
                isIndeterminate
                    ? Transform.rotate(
                      angle: _rotationAnimation.value,
                      child: CustomPaint(
                        painter: _SpinnerPainter(
                          value: null,
                          animationValue: _controller.value,
                          backgroundColor: bgColor,
                          progressColor: progColor,
                          borderColor: borderCol,
                          strokeWidth: widget.strokeWidth,
                          variant: widget.variant,
                          glitchIntensity:
                              widget.isGlitched ? _glitchAnimation.value : 0.0,
                        ),
                      ),
                    )
                    : CustomPaint(
                      painter: _SpinnerPainter(
                        value: _valueAnimation.value,
                        animationValue: 0,
                        backgroundColor: bgColor,
                        progressColor: progColor,
                        borderColor: borderCol,
                        strokeWidth: widget.strokeWidth,
                        variant: widget.variant,
                        glitchIntensity:
                            widget.isGlitched ? _glitchAnimation.value : 0.0,
                      ),
                    ),
          );
        }

        // Apply glitch effect if needed
        if (widget.isGlitched) {
          final glitchOffset =
              widget.variant == BrutalProgressVariant.broken
                  ? 2.0 + _glitchAnimation.value * 1.5
                  : 2.0;

          final redOpacity =
              widget.variant == BrutalProgressVariant.broken
                  ? 0.6 + _glitchAnimation.value * 0.3
                  : 0.7;

          final blueOpacity =
              widget.variant == BrutalProgressVariant.broken
                  ? 0.7 - _glitchAnimation.value * 0.2
                  : 0.7;

          // Calcular una rotación aleatoria para el efecto glitch
          final randomAngle =
              widget.variant == BrutalProgressVariant.broken
                  ? (_random.nextDouble() * 0.03 - 0.015) *
                      _glitchAnimation.value
                  : 0.0;

          spinner = Stack(
            children: [
              // Red channel
              Positioned(
                left: glitchOffset,
                top: 0,
                right: 0,
                bottom: 0,
                child: Opacity(
                  opacity: redOpacity,
                  child: Transform.rotate(
                    angle: randomAngle,
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Color(0xFFFF0000),
                        BlendMode.srcATop,
                      ),
                      child: spinner,
                    ),
                  ),
                ),
              ),

              // Blue channel
              Positioned(
                left: -glitchOffset,
                top: 0,
                right: 0,
                bottom: 0,
                child: Opacity(
                  opacity: blueOpacity,
                  child: Transform.rotate(
                    angle: -randomAngle,
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF00FFFF),
                        BlendMode.srcATop,
                      ),
                      child: spinner,
                    ),
                  ),
                ),
              ),

              // Main layer
              spinner,
            ],
          );
        }

        return spinner;
      },
    );
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
  final double glitchIntensity;
  final _random = math.Random();

  _SpinnerPainter({
    this.value,
    required this.animationValue,
    required this.backgroundColor,
    required this.progressColor,
    required this.borderColor,
    required this.strokeWidth,
    required this.variant,
    this.glitchIntensity = 0.0,
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

    if (variant == BrutalProgressVariant.broken) {
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(math.sin(animationValue * math.pi) * 0.05);
      canvas.translate(-center.dx, -center.dy);

      if (value == null) {
        canvas.drawCircle(
          center +
              Offset(
                math.sin(animationValue * math.pi * 4) * strokeWidth * 0.2,
                math.cos(animationValue * math.pi * 3) * strokeWidth * 0.2,
              ),
          radius,
          bgPaint,
        );
      } else {
        canvas.drawCircle(center, radius, bgPaint);
      }

      canvas.restore();
    } else {
      if (variant != BrutalProgressVariant.minimal) {
        canvas.drawCircle(center, radius, bgPaint);
      }
    }

    // Border
    if (variant != BrutalProgressVariant.minimal) {
      if (variant == BrutalProgressVariant.broken) {
        final dashCount = 20;
        final dashPaint =
            Paint()
              ..color = borderColor
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth;

        for (int i = 0; i < dashCount; i++) {
          final startAngle = i * math.pi * 2 / dashCount;
          final endAngle = startAngle + math.pi / dashCount;
          final randomOffset =
              glitchIntensity > 0
                  ? _random.nextDouble() * glitchIntensity * 0.02
                  : 0.0;

          canvas.drawArc(
            rect,
            startAngle + randomOffset,
            (endAngle - startAngle),
            false,
            dashPaint,
          );
        }
      } else {
        canvas.drawCircle(center, radius, borderPaint);
      }
    }

    // Determine start/sweep angles
    double startAngle, sweepAngle;

    if (value == null) {
      // Indeterminate animation
      startAngle = -math.pi / 2 + animationValue * 2 * math.pi;

      // La amplitud del arco varía según la variante
      if (variant == BrutalProgressVariant.broken) {
        // Arco fluctuante para broken
        sweepAngle =
            math.pi * 0.4 + math.sin(animationValue * math.pi) * math.pi * 0.2;

        // Añadir pequeños arcos aleatorios para un efecto glitchy
        final glitchPaint =
            Paint()
              ..color = progressColor.withOpacity(0.7)
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth * 0.6;

        // Pequeños arcos glitcheados que se mueven a diferentes velocidades
        final offset1 = animationValue * 2 * math.pi;
        final offset2 = (animationValue + 0.33) * 2 * math.pi;
        final offset3 = (animationValue + 0.66) * 2 * math.pi;

        canvas.drawArc(rect, offset1, math.pi * 0.2, false, glitchPaint);
        canvas.drawArc(rect, offset2, math.pi * 0.15, false, glitchPaint);
        canvas.drawArc(rect, offset3, math.pi * 0.1, false, glitchPaint);

        // Efecto de destello aleatorio para broken
        if (glitchIntensity > 0.7) {
          canvas.drawArc(
            rect,
            _random.nextDouble() * math.pi * 2,
            _random.nextDouble() * math.pi * 0.3,
            false,
            Paint()
              ..color = progressColor.withOpacity(0.9)
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth * 1.2,
          );
        }
      } else {
        // Arco uniforme para variantes normales
        sweepAngle = math.pi * 0.5;
      }
    } else {
      // Determinate progress
      startAngle = -math.pi / 2;
      sweepAngle = 2 * math.pi * value!;

      // Para la variante pixel, dibuja segmentos discretos en lugar de arco continuo
      if (variant == BrutalProgressVariant.pixel) {
        final segments = 36; // Divido en segmentos para efecto pixelado
        final segmentAngle = 2 * math.pi / segments;
        final segmentsToFill = (value! * segments).floor();

        for (int i = 0; i < segmentsToFill; i++) {
          final segmentStart = -math.pi / 2 + i * segmentAngle;
          canvas.drawArc(
            rect,
            segmentStart,
            segmentAngle * 0.8, // dejar un pequeño espacio entre segmentos
            false,
            progressPaint,
          );
        }

        // Salimos aquí porque ya dibujamos los segmentos
        return;
      }
    }

    // Draw progress arc para otros casos
    if (variant == BrutalProgressVariant.broken && value != null) {
      // Para determinado broken, añadir pequeños saltos al arco
      final segments = 12;
      final segmentAngle = sweepAngle / segments;

      for (int i = 0; i < segments; i++) {
        final offset = glitchIntensity > 0.5 && i % 3 == 0 ? 0.03 : 0.0;
        canvas.drawArc(
          rect,
          startAngle + i * segmentAngle,
          segmentAngle * 0.9, // dejar pequeño espacio
          false,
          Paint()
            ..color = progressColor
            ..style = PaintingStyle.stroke
            ..strokeWidth = strokeWidth * (1.0 + offset),
        );
      }
    } else {
      // Dibujo normal del arco para otras variantes
      canvas.drawArc(rect, startAngle, sweepAngle, false, progressPaint);
    }

    // Efecto adicional para la variante default en indeterminado
    if (variant == BrutalProgressVariant.default_ && value == null) {
      // Pequeña "cola" que sigue al arco principal
      final tailPaint =
          Paint()
            ..color = progressColor.withOpacity(0.3)
            ..style = PaintingStyle.stroke
            ..strokeWidth = strokeWidth * 0.5;

      canvas.drawArc(
        rect,
        startAngle - math.pi * 0.1,
        math.pi * 0.1,
        false,
        tailPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_SpinnerPainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.animationValue != animationValue ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.variant != variant ||
        oldDelegate.glitchIntensity != glitchIntensity;
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
          backgroundColor: backgroundColor,
          borderColor: borderColor,
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
        final sequenceLength =
            (totalCells ~/ 2) +
            (math.sin(controller.value * math.pi * 2).abs() * 4).floor();
        final startCell = (controller.value * totalCells).floor();

        // Alternar entre diferentes patrones para dar un efecto brutal
        final patternType = ((controller.value * 4) % 3).floor();

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
              backgroundColor: backgroundColor,
              borderColor: borderColor,
              patternType: patternType,
              animationValue: controller.value,
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
  final Color backgroundColor;
  final Color borderColor;
  final int? patternType;
  final double? animationValue;
  final _random = math.Random();

  _PixelSpinnerPainter({
    required this.filledCells,
    required this.totalCells,
    required this.cellSize,
    required this.progressColor,
    required this.backgroundColor,
    required this.borderColor,
  }) : startCell = null,
       sequenceLength = null,
       patternType = null,
       animationValue = null;

  _PixelSpinnerPainter.sequence({
    required this.startCell,
    required this.sequenceLength,
    required this.totalCells,
    required this.cellSize,
    required this.progressColor,
    required this.backgroundColor,
    required this.borderColor,
    this.patternType = 0,
    this.animationValue = 0.0,
  }) : filledCells = 0;

  @override
  void paint(Canvas canvas, Size size) {
    final cellsPerSide = (size.width / cellSize).floor();

    // Draw cells based on mode (determinate or indeterminate)
    if (startCell != null && sequenceLength != null) {
      _drawIndeterminateCells(canvas, size, cellsPerSide);
    } else {
      _drawDeterminateCells(canvas, size, cellsPerSide);
    }

    // Add special brutal effects for indeterminate mode
    if (startCell != null && animationValue != null) {
      _addBrutalEffects(canvas, size);
    }
  }

  void _drawIndeterminateCells(Canvas canvas, Size size, int cellsPerSide) {
    final side = cellsPerSide - 1; // Cells per side excluding corners

    final baseColors = [
      progressColor,
      progressColor.withOpacity(0.8),
      progressColor.withOpacity(0.6),
    ];

    // Draw main sequence
    for (int i = 0; i < sequenceLength!; i++) {
      final cellIndex = (startCell! + i) % totalCells;
      final intensity = 1.0 - (i / sequenceLength!);

      // Posición del pixel
      final position = _getCellPosition(cellIndex, side);

      // Determinar el color según el patrón seleccionado
      final colorIndex =
          patternType == 0
              ? i % 3
              : patternType == 1
              ? (cellIndex ~/ 2) % 3
              : ((i + cellIndex) % 3);

      final paint =
          Paint()..color = baseColors[colorIndex].withOpacity(intensity);

      // Dibujar el pixel
      _drawPixelWithEffect(canvas, position, paint, i);
    }

    // Pequeño rastro de "estela" como efecto extra
    final tailLength = 5;
    for (int i = 1; i <= tailLength; i++) {
      final cellIndex = (startCell! - i + totalCells) % totalCells;
      final position = _getCellPosition(cellIndex, side);

      final paint = Paint()..color = progressColor.withOpacity(0.3 / i);

      _drawSimplePixel(canvas, position, paint);
    }
  }

  void _drawDeterminateCells(Canvas canvas, Size size, int cellsPerSide) {
    final side = cellsPerSide - 1;

    // Dibuja los pixeles completados
    for (int i = 0; i < filledCells; i++) {
      final position = _getCellPosition(i, side);

      // Crea un patrón pixelado con variación de colores para un efecto brutal
      final isAlternate = i % 3 == 0;
      final paint =
          Paint()
            ..color =
                isAlternate ? progressColor : progressColor.withOpacity(0.8);

      _drawSimplePixel(canvas, position, paint);
    }

    // Muestra el siguiente pixel que se completará con un efecto pulsante
    if (filledCells < totalCells) {
      final nextCellIndex = filledCells;
      final position = _getCellPosition(nextCellIndex, side);

      // Esto debería pulsar, pero no tenemos un controlador de animación disponible
      // Simularemos un efecto simple
      final paint =
          Paint()
            ..color = progressColor.withOpacity(0.5)
            ..style = PaintingStyle.stroke
            ..strokeWidth = cellSize * 0.3;

      canvas.drawRect(
        Rect.fromLTWH(position.dx, position.dy, cellSize, cellSize),
        paint,
      );
    }
  }

  Offset _getCellPosition(int index, int side) {
    if (index < side) {
      // Top side (left to right)
      return Offset(index * cellSize, 0);
    } else if (index < 2 * side) {
      // Right side (top to bottom)
      return Offset(side * cellSize, (index - side) * cellSize);
    } else if (index < 3 * side) {
      // Bottom side (right to left)
      return Offset((3 * side - index) * cellSize, side * cellSize);
    } else {
      // Left side (bottom to top)
      return Offset(0, (4 * side - index) * cellSize);
    }
  }

  void _drawSimplePixel(Canvas canvas, Offset position, Paint paint) {
    canvas.drawRect(
      Rect.fromLTWH(position.dx, position.dy, cellSize, cellSize),
      paint,
    );
  }

  void _drawPixelWithEffect(
    Canvas canvas,
    Offset position,
    Paint paint,
    int index,
  ) {
    // Diferentes efectos para los píxeles según patrón
    if (patternType == 1 && index % 2 == 0) {
      // Dibujar píxeles con efecto diagonal
      final path =
          Path()
            ..moveTo(position.dx, position.dy)
            ..lineTo(position.dx + cellSize, position.dy)
            ..lineTo(position.dx + cellSize, position.dy + cellSize)
            ..lineTo(position.dx, position.dy + cellSize)
            ..close();

      canvas.drawPath(path, paint);
    } else if (patternType == 2 && index % 4 == 0) {
      // Dibujar píxeles con efecto cruz
      final padding = cellSize * 0.2;

      // Línea horizontal
      canvas.drawRect(
        Rect.fromLTWH(
          position.dx,
          position.dy + (cellSize - padding) / 2,
          cellSize,
          padding,
        ),
        paint,
      );

      // Línea vertical
      canvas.drawRect(
        Rect.fromLTWH(
          position.dx + (cellSize - padding) / 2,
          position.dy,
          padding,
          cellSize,
        ),
        paint,
      );
    } else {
      // Píxel normal
      canvas.drawRect(
        Rect.fromLTWH(position.dx, position.dy, cellSize, cellSize),
        paint,
      );
    }
  }

  // Efectos brutales adicionales para la versión indeterminada
  void _addBrutalEffects(Canvas canvas, Size size) {
    if (animationValue == null) return;

    // Efecto de destello ocasional
    if (_random.nextDouble() < 0.03) {
      final flashPaint = Paint()..color = progressColor.withOpacity(0.3);

      // Destello aleatorio de líneas
      final lines = _random.nextInt(4) + 1;
      for (int i = 0; i < lines; i++) {
        final x1 = _random.nextDouble() * size.width;
        final y1 = _random.nextDouble() * size.height;
        final x2 = _random.nextDouble() * size.width;
        final y2 = _random.nextDouble() * size.height;

        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), flashPaint);
      }
    }

    // Efecto de latido en el borde ocasional
    if (math.sin(animationValue! * math.pi * 4).abs() > 0.9) {
      final strokeWidth =
          1.5 + math.sin(animationValue! * math.pi * 8).abs() * 1.5;

      final pulsePaint =
          Paint()
            ..color = progressColor.withOpacity(0.6)
            ..style = PaintingStyle.stroke
            ..strokeWidth = strokeWidth;

      canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), pulsePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is _PixelSpinnerPainter) {
      return oldDelegate.filledCells != filledCells ||
          oldDelegate.startCell != startCell ||
          oldDelegate.progressColor != progressColor ||
          oldDelegate.patternType != patternType ||
          oldDelegate.animationValue != animationValue;
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
