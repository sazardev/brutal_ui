import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'dart:math' show Random;

/// Sistema de efectos visuales brutales para Brutal UI
///
/// Esta clase proporciona efectos visuales extremos que rompen
/// las reglas tradicionales del diseño para crear experiencias brutales

class BrutalEffects {
  // =============== EFECTOS DE GLITCH ===============

  /// Efecto de glitch que distorsiona el widget
  static Widget glitch({
    required Widget child,
    double intensity = 1.0,
    bool isAnimated = true,
    Duration animationDuration = const Duration(milliseconds: 150),
  }) {
    return BrutalGlitchEffect(
      child: child,
      intensity: intensity,
      isAnimated: isAnimated,
      animationDuration: animationDuration,
    );
  }

  /// Efecto de glitch de texto con desplazamiento RGB
  static Widget textGlitch({
    required String text,
    required TextStyle style,
    double intensity = 2.0,
    Color redOffset = Colors.red,
    Color blueOffset = Colors.blue,
  }) {
    return BrutalTextGlitchEffect(
      text: text,
      style: style,
      intensity: intensity,
      redOffset: redOffset,
      blueOffset: blueOffset,
    );
  }

  // =============== EFECTOS DE DISTORSIÓN ===============

  /// Efecto de distorsión de ondas
  static Widget waveDistortion({
    required Widget child,
    double amplitude = 10.0,
    double frequency = 0.5,
    bool isAnimated = true,
  }) {
    return BrutalWaveDistortionEffect(
      child: child,
      amplitude: amplitude,
      frequency: frequency,
      isAnimated: isAnimated,
    );
  }

  /// Efecto de rotura/fragmentación
  static Widget shatter({
    required Widget child,
    int fragments = 8,
    double intensity = 1.0,
    bool isAnimated = false,
  }) {
    return BrutalShatterEffect(
      child: child,
      fragments: fragments,
      intensity: intensity,
      isAnimated: isAnimated,
    );
  }

  // =============== EFECTOS DE ILUMINACIÓN ===============

  /// Efecto de neón con brillos
  static Widget neonGlow({
    required Widget child,
    Color glowColor = Colors.cyan,
    double glowRadius = 20.0,
    double intensity = 1.0,
    bool isPulsing = false,
  }) {
    return BrutalNeonGlowEffect(
      child: child,
      glowColor: glowColor,
      glowRadius: glowRadius,
      intensity: intensity,
      isPulsing: isPulsing,
    );
  }

  /// Efecto de electricidad estática
  static Widget staticElectricity({
    required Widget child,
    Color electricColor = Colors.yellow,
    double intensity = 1.0,
    bool isAnimated = true,
  }) {
    return BrutalStaticElectricityEffect(
      child: child,
      electricColor: electricColor,
      intensity: intensity,
      isAnimated: isAnimated,
    );
  }

  // =============== EFECTOS DE TEXTURA ===============

  /// Efecto de ruido/grain
  static Widget noise({
    required Widget child,
    double intensity = 0.3,
    bool isAnimated = false,
  }) {
    return BrutalNoiseEffect(
      child: child,
      intensity: intensity,
      isAnimated: isAnimated,
    );
  }

  /// Efecto de píxeles/8-bit
  static Widget pixelate({
    required Widget child,
    double pixelSize = 4.0,
    bool isRetro = true,
  }) {
    return BrutalPixelateEffect(
      child: child,
      pixelSize: pixelSize,
      isRetro: isRetro,
    );
  }

  // =============== EFECTOS DE MOVIMIENTO ===============

  /// Efecto de vibración agresiva
  static Widget violentShake({
    required Widget child,
    double intensity = 5.0,
    Duration shakeDuration = const Duration(milliseconds: 100),
    bool isContinuous = false,
  }) {
    return BrutalViolentShakeEffect(
      child: child,
      intensity: intensity,
      shakeDuration: shakeDuration,
      isContinuous: isContinuous,
    );
  }

  /// Efecto de rotación caótica
  static Widget chaosRotation({
    required Widget child,
    double maxAngle = 0.1,
    bool isRandom = true,
    Duration duration = const Duration(milliseconds: 200),
  }) {
    return BrutalChaosRotationEffect(
      child: child,
      maxAngle: maxAngle,
      isRandom: isRandom,
      duration: duration,
    );
  }

  // =============== EFECTOS DE COLOR ===============

  /// Efecto de inversión de colores brutal
  static Widget colorInvert({
    required Widget child,
    double intensity = 1.0,
    bool isFlickering = false,
  }) {
    return BrutalColorInvertEffect(
      child: child,
      intensity: intensity,
      isFlickering: isFlickering,
    );
  }

  /// Efecto de separación de canales RGB
  static Widget rgbSplit({
    required Widget child,
    double redOffset = 3.0,
    double blueOffset = -3.0,
    bool isAnimated = false,
  }) {
    return BrutalRGBSplitEffect(
      child: child,
      redOffset: redOffset,
      blueOffset: blueOffset,
      isAnimated: isAnimated,
    );
  }

  // =============== EFECTOS COMBINADOS EXTREMOS ===============

  /// Efecto apocalíptico que combina múltiples efectos
  static Widget apocalypse({required Widget child, double intensity = 1.0}) {
    return BrutalApocalypseEffect(child: child, intensity: intensity);
  }

  /// Efecto de terminal hacker con líneas de escaneo
  static Widget hackerTerminal({
    required Widget child,
    Color scanlineColor = Colors.green,
    double scanlineOpacity = 0.1,
    bool hasFlicker = true,
  }) {
    return BrutalHackerTerminalEffect(
      child: child,
      scanlineColor: scanlineColor,
      scanlineOpacity: scanlineOpacity,
      hasFlicker: hasFlicker,
    );
  }

  /// Efecto de hologram con interferencia
  static Widget hologram({
    required Widget child,
    Color interferenceColor = Colors.blue,
    double interferenceIntensity = 0.3,
    bool isShimmering = true,
  }) {
    return BrutalHologramEffect(
      child: child,
      interferenceColor: interferenceColor,
      interferenceIntensity: interferenceIntensity,
      isShimmering: isShimmering,
    );
  }
}

// =============== IMPLEMENTACIONES DE EFECTOS ===============

class BrutalGlitchEffect extends StatefulWidget {
  final Widget child;
  final double intensity;
  final bool isAnimated;
  final Duration animationDuration;

  const BrutalGlitchEffect({
    super.key,
    required this.child,
    this.intensity = 1.0,
    this.isAnimated = true,
    this.animationDuration = const Duration(milliseconds: 150),
  });

  @override
  State<BrutalGlitchEffect> createState() => _BrutalGlitchEffectState();
}

class _BrutalGlitchEffectState extends State<BrutalGlitchEffect>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<double> _offsets;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _generateRandomOffsets();

    if (widget.isAnimated) {
      _controller.repeat();
    }
  }

  void _generateRandomOffsets() {
    _offsets = List.generate(
      6,
      (index) => (_random.nextDouble() - 0.5) * widget.intensity * 10,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        if (widget.isAnimated && _random.nextDouble() < 0.1) {
          _generateRandomOffsets();
        }

        return Stack(
          children: [
            // Capa roja desplazada
            Transform.translate(
              offset: Offset(_offsets[0], _offsets[1]),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.red.withOpacity(0.8),
                  BlendMode.multiply,
                ),
                child: widget.child,
              ),
            ),
            // Capa azul desplazada
            Transform.translate(
              offset: Offset(_offsets[2], _offsets[3]),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.blue.withOpacity(0.8),
                  BlendMode.multiply,
                ),
                child: widget.child,
              ),
            ),
            // Capa original
            Transform.translate(
              offset: Offset(_offsets[4], _offsets[5]),
              child: widget.child,
            ),
          ],
        );
      },
    );
  }
}

class BrutalTextGlitchEffect extends StatelessWidget {
  final String text;
  final TextStyle style;
  final double intensity;
  final Color redOffset;
  final Color blueOffset;

  const BrutalTextGlitchEffect({
    super.key,
    required this.text,
    required this.style,
    this.intensity = 2.0,
    this.redOffset = Colors.red,
    this.blueOffset = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Texto rojo desplazado
        Transform.translate(
          offset: Offset(-intensity, 0),
          child: Text(text, style: style.copyWith(color: redOffset)),
        ),
        // Texto azul desplazado
        Transform.translate(
          offset: Offset(intensity, 0),
          child: Text(text, style: style.copyWith(color: blueOffset)),
        ),
        // Texto original
        Text(text, style: style),
      ],
    );
  }
}

class BrutalWaveDistortionEffect extends StatefulWidget {
  final Widget child;
  final double amplitude;
  final double frequency;
  final bool isAnimated;

  const BrutalWaveDistortionEffect({
    super.key,
    required this.child,
    this.amplitude = 10.0,
    this.frequency = 0.5,
    this.isAnimated = true,
  });

  @override
  State<BrutalWaveDistortionEffect> createState() =>
      _BrutalWaveDistortionEffectState();
}

class _BrutalWaveDistortionEffectState extends State<BrutalWaveDistortionEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    if (widget.isAnimated) {
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform:
              Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(
                  math.sin(_controller.value * 2 * math.pi * widget.frequency) *
                      widget.amplitude *
                      0.01,
                ),
          child: widget.child,
        );
      },
    );
  }
}

class BrutalShatterEffect extends StatelessWidget {
  final Widget child;
  final int fragments;
  final double intensity;
  final bool isAnimated;

  const BrutalShatterEffect({
    super.key,
    required this.child,
    this.fragments = 8,
    this.intensity = 1.0,
    this.isAnimated = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BrutalShatterClipper(fragments: fragments, intensity: intensity),
      child: child,
    );
  }
}

class BrutalShatterClipper extends CustomClipper<Path> {
  final int fragments;
  final double intensity;

  BrutalShatterClipper({required this.fragments, required this.intensity});

  @override
  Path getClip(Size size) {
    final path = Path();
    final random = Random(42); // Seed fijo para consistencia

    // Crear fragmentos irregulares
    for (int i = 0; i < fragments; i++) {
      final startX = (size.width / fragments) * i;
      final endX = (size.width / fragments) * (i + 1);

      path.moveTo(startX, 0);
      path.lineTo(endX + (random.nextDouble() - 0.5) * intensity * 10, 0);
      path.lineTo(
        endX + (random.nextDouble() - 0.5) * intensity * 10,
        size.height,
      );
      path.lineTo(
        startX + (random.nextDouble() - 0.5) * intensity * 10,
        size.height,
      );
      path.close();
    }

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class BrutalNeonGlowEffect extends StatefulWidget {
  final Widget child;
  final Color glowColor;
  final double glowRadius;
  final double intensity;
  final bool isPulsing;

  const BrutalNeonGlowEffect({
    super.key,
    required this.child,
    this.glowColor = Colors.cyan,
    this.glowRadius = 20.0,
    this.intensity = 1.0,
    this.isPulsing = false,
  });

  @override
  State<BrutalNeonGlowEffect> createState() => _BrutalNeonGlowEffectState();
}

class _BrutalNeonGlowEffectState extends State<BrutalNeonGlowEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    if (widget.isPulsing) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final glowIntensity =
            widget.isPulsing
                ? (0.5 + _controller.value * 0.5) * widget.intensity
                : widget.intensity;

        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: widget.glowColor.withOpacity(0.3 * glowIntensity),
                blurRadius: widget.glowRadius * glowIntensity,
                spreadRadius: widget.glowRadius * 0.3 * glowIntensity,
              ),
              BoxShadow(
                color: widget.glowColor.withOpacity(0.6 * glowIntensity),
                blurRadius: widget.glowRadius * 0.5 * glowIntensity,
                spreadRadius: widget.glowRadius * 0.1 * glowIntensity,
              ),
            ],
          ),
          child: widget.child,
        );
      },
    );
  }
}

// Continúa con más implementaciones...
class BrutalStaticElectricityEffect extends StatefulWidget {
  final Widget child;
  final Color electricColor;
  final double intensity;
  final bool isAnimated;

  const BrutalStaticElectricityEffect({
    super.key,
    required this.child,
    this.electricColor = Colors.yellow,
    this.intensity = 1.0,
    this.isAnimated = true,
  });

  @override
  State<BrutalStaticElectricityEffect> createState() =>
      _BrutalStaticElectricityEffectState();
}

class _BrutalStaticElectricityEffectState
    extends State<BrutalStaticElectricityEffect>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  List<Offset> _electricPoints = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 50),
      vsync: this,
    );
    _generateElectricPoints();

    if (widget.isAnimated) {
      _controller.repeat();
    }
  }

  void _generateElectricPoints() {
    _electricPoints = List.generate(
      10,
      (index) => Offset(_random.nextDouble() * 200, _random.nextDouble() * 200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        if (_random.nextDouble() < 0.3) {
          _generateElectricPoints();
        }

        return Stack(
          children: [
            widget.child,
            if (widget.isAnimated)
              CustomPaint(
                painter: ElectricityPainter(
                  points: _electricPoints,
                  color: widget.electricColor,
                  intensity: widget.intensity,
                ),
                size: Size.infinite,
              ),
          ],
        );
      },
    );
  }
}

class ElectricityPainter extends CustomPainter {
  final List<Offset> points;
  final Color color;
  final double intensity;

  ElectricityPainter({
    required this.points,
    required this.color,
    required this.intensity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color.withOpacity(0.7 * intensity)
          ..strokeWidth = 1.0 * intensity
          ..style = PaintingStyle.stroke;

    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Implementaciones adicionales...
class BrutalNoiseEffect extends StatelessWidget {
  final Widget child;
  final double intensity;
  final bool isAnimated;

  const BrutalNoiseEffect({
    super.key,
    required this.child,
    this.intensity = 0.3,
    this.isAnimated = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: CustomPaint(painter: NoisePainter(intensity: intensity)),
        ),
      ],
    );
  }
}

class NoisePainter extends CustomPainter {
  final double intensity;

  NoisePainter({required this.intensity});

  @override
  void paint(Canvas canvas, Size size) {
    final random = Random(42);
    final paint =
        Paint()
          ..color = Colors.white.withOpacity(intensity)
          ..strokeWidth = 1.0;

    for (
      int i = 0;
      i < (size.width * size.height * intensity * 0.01).round();
      i++
    ) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      canvas.drawCircle(Offset(x, y), 0.5, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BrutalPixelateEffect extends StatelessWidget {
  final Widget child;
  final double pixelSize;
  final bool isRetro;

  const BrutalPixelateEffect({
    super.key,
    required this.child,
    this.pixelSize = 4.0,
    this.isRetro = true,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ui.ImageFilter.matrix(Matrix4.identity().storage),
        child: Transform.scale(
          scale: 1.0 / pixelSize,
          child: Transform.scale(scale: pixelSize, child: child),
        ),
      ),
    );
  }
}

class BrutalViolentShakeEffect extends StatefulWidget {
  final Widget child;
  final double intensity;
  final Duration shakeDuration;
  final bool isContinuous;

  const BrutalViolentShakeEffect({
    super.key,
    required this.child,
    this.intensity = 5.0,
    this.shakeDuration = const Duration(milliseconds: 100),
    this.isContinuous = false,
  });

  @override
  State<BrutalViolentShakeEffect> createState() =>
      _BrutalViolentShakeEffectState();
}

class _BrutalViolentShakeEffectState extends State<BrutalViolentShakeEffect>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.shakeDuration,
      vsync: this,
    );

    if (widget.isContinuous) {
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final shakeX = (_random.nextDouble() - 0.5) * widget.intensity * 2;
        final shakeY = (_random.nextDouble() - 0.5) * widget.intensity * 2;

        return Transform.translate(
          offset: Offset(shakeX, shakeY),
          child: widget.child,
        );
      },
    );
  }
}

class BrutalChaosRotationEffect extends StatefulWidget {
  final Widget child;
  final double maxAngle;
  final bool isRandom;
  final Duration duration;

  const BrutalChaosRotationEffect({
    super.key,
    required this.child,
    this.maxAngle = 0.1,
    this.isRandom = true,
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  State<BrutalChaosRotationEffect> createState() =>
      _BrutalChaosRotationEffectState();
}

class _BrutalChaosRotationEffectState extends State<BrutalChaosRotationEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final angle =
            widget.isRandom
                ? (_random.nextDouble() - 0.5) * widget.maxAngle
                : math.sin(_controller.value * 2 * math.pi) * widget.maxAngle;

        return Transform.rotate(angle: angle, child: widget.child);
      },
    );
  }
}

class BrutalColorInvertEffect extends StatefulWidget {
  final Widget child;
  final double intensity;
  final bool isFlickering;

  const BrutalColorInvertEffect({
    super.key,
    required this.child,
    this.intensity = 1.0,
    this.isFlickering = false,
  });

  @override
  State<BrutalColorInvertEffect> createState() =>
      _BrutalColorInvertEffectState();
}

class _BrutalColorInvertEffectState extends State<BrutalColorInvertEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    if (widget.isFlickering) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final invertIntensity =
            widget.isFlickering
                ? _controller.value * widget.intensity
                : widget.intensity;

        return ColorFiltered(
          colorFilter: ColorFilter.matrix([
            -invertIntensity,
            0,
            0,
            0,
            255 * invertIntensity,
            0,
            -invertIntensity,
            0,
            0,
            255 * invertIntensity,
            0,
            0,
            -invertIntensity,
            0,
            255 * invertIntensity,
            0,
            0,
            0,
            1,
            0,
          ]),
          child: widget.child,
        );
      },
    );
  }
}

class BrutalRGBSplitEffect extends StatelessWidget {
  final Widget child;
  final double redOffset;
  final double blueOffset;
  final bool isAnimated;

  const BrutalRGBSplitEffect({
    super.key,
    required this.child,
    this.redOffset = 3.0,
    this.blueOffset = -3.0,
    this.isAnimated = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Canal rojo
        Transform.translate(
          offset: Offset(redOffset, 0),
          child: ColorFiltered(
            colorFilter: const ColorFilter.matrix([
              1,
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              1,
              0,
            ]),
            child: child,
          ),
        ),
        // Canal azul
        Transform.translate(
          offset: Offset(blueOffset, 0),
          child: ColorFiltered(
            colorFilter: const ColorFilter.matrix([
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              1,
              0,
              0,
              0,
              0,
              0,
              1,
              0,
            ]),
            child: child,
          ),
        ),
        // Canal verde (normal)
        ColorFiltered(
          colorFilter: const ColorFilter.matrix([
            0,
            0,
            0,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            1,
            0,
          ]),
          child: child,
        ),
      ],
    );
  }
}

// Efectos complejos combinados
class BrutalApocalypseEffect extends StatelessWidget {
  final Widget child;
  final double intensity;

  const BrutalApocalypseEffect({
    super.key,
    required this.child,
    this.intensity = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return BrutalEffects.glitch(
      intensity: intensity,
      child: BrutalEffects.rgbSplit(
        redOffset: 2 * intensity,
        blueOffset: -2 * intensity,
        child: BrutalEffects.violentShake(
          intensity: 3 * intensity,
          isContinuous: true,
          child: BrutalEffects.noise(intensity: 0.2 * intensity, child: child),
        ),
      ),
    );
  }
}

class BrutalHackerTerminalEffect extends StatelessWidget {
  final Widget child;
  final Color scanlineColor;
  final double scanlineOpacity;
  final bool hasFlicker;

  const BrutalHackerTerminalEffect({
    super.key,
    required this.child,
    this.scanlineColor = Colors.green,
    this.scanlineOpacity = 0.1,
    this.hasFlicker = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget result = child;

    if (hasFlicker) {
      result = BrutalEffects.colorInvert(
        intensity: 0.1,
        isFlickering: true,
        child: result,
      );
    }

    return Stack(
      children: [
        result,
        Positioned.fill(
          child: CustomPaint(
            painter: ScanlinePainter(
              color: scanlineColor,
              opacity: scanlineOpacity,
            ),
          ),
        ),
      ],
    );
  }
}

class ScanlinePainter extends CustomPainter {
  final Color color;
  final double opacity;

  ScanlinePainter({required this.color, required this.opacity});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color.withOpacity(opacity)
          ..strokeWidth = 2;

    for (double y = 0; y < size.height; y += 4) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BrutalHologramEffect extends StatefulWidget {
  final Widget child;
  final Color interferenceColor;
  final double interferenceIntensity;
  final bool isShimmering;

  const BrutalHologramEffect({
    super.key,
    required this.child,
    this.interferenceColor = Colors.blue,
    this.interferenceIntensity = 0.3,
    this.isShimmering = true,
  });

  @override
  State<BrutalHologramEffect> createState() => _BrutalHologramEffectState();
}

class _BrutalHologramEffectState extends State<BrutalHologramEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    if (widget.isShimmering) {
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            // Efecto base del niño
            Opacity(opacity: 0.8, child: widget.child),
            // Interferencia holográfica
            Positioned.fill(
              child: CustomPaint(
                painter: HologramInterferencePainter(
                  progress: _controller.value,
                  color: widget.interferenceColor,
                  intensity: widget.interferenceIntensity,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class HologramInterferencePainter extends CustomPainter {
  final double progress;
  final Color color;
  final double intensity;

  HologramInterferencePainter({
    required this.progress,
    required this.color,
    required this.intensity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color.withOpacity(intensity)
          ..strokeWidth = 1;

    // Líneas de interferencia móviles
    final lineSpacing = 8.0;
    final offset = progress * lineSpacing;

    for (double y = -offset; y < size.height + lineSpacing; y += lineSpacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
