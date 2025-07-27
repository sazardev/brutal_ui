import 'package:flutter/widgets.dart';
import 'dart:math' as math;
import '../utils/constants.dart';

/// Widget para aplicar efectos visuales brutales extremos a cualquier widget
class BrutalEffects extends StatefulWidget {
  final Widget child;
  final BrutalEffectType effect;
  final double intensity;
  final Duration duration;
  final bool isAnimated;
  final Color? glitchColor1;
  final Color? glitchColor2;

  const BrutalEffects({
    super.key,
    required this.child,
    this.effect = BrutalEffectType.none,
    this.intensity = 1.0,
    this.duration = const Duration(milliseconds: 100),
    this.isAnimated = false,
    this.glitchColor1,
    this.glitchColor2,
  });

  /// Efecto de glitch estático
  factory BrutalEffects.glitch({
    Key? key,
    required Widget child,
    double intensity = 1.0,
    Color? glitchColor1,
    Color? glitchColor2,
  }) {
    return BrutalEffects(
      key: key,
      child: child,
      effect: BrutalEffectType.glitch,
      intensity: intensity,
      glitchColor1: glitchColor1 ?? BrutalConstants.red,
      glitchColor2: glitchColor2 ?? BrutalConstants.cyan,
    );
  }

  /// Efecto de glitch animado
  factory BrutalEffects.glitchAnimated({
    Key? key,
    required Widget child,
    double intensity = 1.0,
    Duration duration = const Duration(milliseconds: 100),
    Color? glitchColor1,
    Color? glitchColor2,
  }) {
    return BrutalEffects(
      key: key,
      child: child,
      effect: BrutalEffectType.glitch,
      intensity: intensity,
      duration: duration,
      isAnimated: true,
      glitchColor1: glitchColor1 ?? BrutalConstants.red,
      glitchColor2: glitchColor2 ?? BrutalConstants.cyan,
    );
  }

  /// Efecto de distorsión
  factory BrutalEffects.distortion({
    Key? key,
    required Widget child,
    double intensity = 1.0,
    bool isAnimated = false,
  }) {
    return BrutalEffects(
      key: key,
      child: child,
      effect: BrutalEffectType.distortion,
      intensity: intensity,
      isAnimated: isAnimated,
    );
  }

  /// Efecto de fragmentación
  factory BrutalEffects.shatter({
    Key? key,
    required Widget child,
    double intensity = 1.0,
    bool isAnimated = false,
  }) {
    return BrutalEffects(
      key: key,
      child: child,
      effect: BrutalEffectType.shatter,
      intensity: intensity,
      isAnimated: isAnimated,
    );
  }

  /// Efecto de interferencia TV
  factory BrutalEffects.tvStatic({
    Key? key,
    required Widget child,
    double intensity = 1.0,
    bool isAnimated = true,
  }) {
    return BrutalEffects(
      key: key,
      child: child,
      effect: BrutalEffectType.tvStatic,
      intensity: intensity,
      isAnimated: isAnimated,
    );
  }

  /// Efecto de corrosión
  factory BrutalEffects.corroded({
    Key? key,
    required Widget child,
    double intensity = 1.0,
  }) {
    return BrutalEffects(
      key: key,
      child: child,
      effect: BrutalEffectType.corroded,
      intensity: intensity,
    );
  }

  @override
  State<BrutalEffects> createState() => _BrutalEffectsState();
}

class _BrutalEffectsState extends State<BrutalEffects>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

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
    if (widget.effect == BrutalEffectType.none) {
      return widget.child;
    }

    if (widget.isAnimated) {
      return AnimatedBuilder(
        animation: _animation,
        builder: (context, child) => _buildEffect(),
      );
    }

    return _buildEffect();
  }

  Widget _buildEffect() {
    switch (widget.effect) {
      case BrutalEffectType.glitch:
        return _buildGlitchEffect();
      case BrutalEffectType.distortion:
        return _buildDistortionEffect();
      case BrutalEffectType.shatter:
        return _buildShatterEffect();
      case BrutalEffectType.tvStatic:
        return _buildTvStaticEffect();
      case BrutalEffectType.corroded:
        return _buildCorrodedEffect();
      case BrutalEffectType.burned:
        return _buildBurnedEffect();
      case BrutalEffectType.frozen:
        return _buildFrozenEffect();
      case BrutalEffectType.electric:
        return _buildElectricEffect();
      case BrutalEffectType.radioactive:
        return _buildRadioactiveEffect();
      case BrutalEffectType.plasma:
        return _buildPlasmaEffect();
      case BrutalEffectType.none:
        return widget.child;
    }
  }

  Widget _buildGlitchEffect() {
    final random = math.Random();
    final offset1 =
        widget.isAnimated
            ? Offset(random.nextDouble() * widget.intensity * 5, 0)
            : Offset(widget.intensity * 2, 0);
    final offset2 =
        widget.isAnimated
            ? Offset(-random.nextDouble() * widget.intensity * 5, 0)
            : Offset(-widget.intensity * 2, 0);

    return Stack(
      children: [
        // Capa roja
        Transform.translate(
          offset: offset1,
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              widget.glitchColor1?.withOpacity(0.7) ??
                  BrutalConstants.red.withOpacity(0.7),
              BlendMode.multiply,
            ),
            child: widget.child,
          ),
        ),
        // Capa cyan
        Transform.translate(
          offset: offset2,
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              widget.glitchColor2?.withOpacity(0.7) ??
                  BrutalConstants.cyan.withOpacity(0.7),
              BlendMode.multiply,
            ),
            child: widget.child,
          ),
        ),
        // Capa original
        widget.child,
      ],
    );
  }

  Widget _buildDistortionEffect() {
    return Transform(
      transform:
          Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(widget.intensity * 0.1)
            ..rotateY(widget.intensity * 0.05)
            ..scale(1.0 + widget.intensity * 0.1),
      alignment: Alignment.center,
      child: widget.child,
    );
  }

  Widget _buildShatterEffect() {
    return ClipPath(
      clipper: ShatterClipper(intensity: widget.intensity),
      child: widget.child,
    );
  }

  Widget _buildTvStaticEffect() {
    return Stack(
      children: [
        widget.child,
        Positioned.fill(
          child: CustomPaint(
            painter: TvStaticPainter(
              intensity: widget.intensity,
              animationValue: widget.isAnimated ? _animation.value : 0.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCorrodedEffect() {
    return ClipPath(
      clipper: CorrosionClipper(intensity: widget.intensity),
      child: widget.child,
    );
  }

  Widget _buildBurnedEffect() {
    return Stack(
      children: [
        widget.child,
        Positioned.fill(
          child: CustomPaint(
            painter: BurnEffectPainter(intensity: widget.intensity),
          ),
        ),
      ],
    );
  }

  Widget _buildFrozenEffect() {
    return Stack(
      children: [
        widget.child,
        Positioned.fill(
          child: CustomPaint(
            painter: FrozenEffectPainter(intensity: widget.intensity),
          ),
        ),
      ],
    );
  }

  Widget _buildElectricEffect() {
    return Stack(
      children: [
        widget.child,
        Positioned.fill(
          child: CustomPaint(
            painter: ElectricEffectPainter(
              intensity: widget.intensity,
              animationValue: widget.isAnimated ? _animation.value : 0.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRadioactiveEffect() {
    return Stack(
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            const Color(0xFF00FF00).withOpacity(0.3),
            BlendMode.overlay,
          ),
          child: widget.child,
        ),
        Positioned.fill(
          child: CustomPaint(
            painter: RadioactivePainter(
              intensity: widget.intensity,
              animationValue: widget.isAnimated ? _animation.value : 0.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlasmaEffect() {
    return Stack(
      children: [
        widget.child,
        Positioned.fill(
          child: CustomPaint(
            painter: PlasmaEffectPainter(
              intensity: widget.intensity,
              animationValue: widget.isAnimated ? _animation.value : 0.0,
            ),
          ),
        ),
      ],
    );
  }
}

/// Tipos de efectos visuales brutales
enum BrutalEffectType {
  none,
  glitch,
  distortion,
  shatter,
  tvStatic,
  corroded,
  burned,
  frozen,
  electric,
  radioactive,
  plasma,
}

/// Clipper para efecto de fragmentación
class ShatterClipper extends CustomClipper<Path> {
  final double intensity;

  ShatterClipper({required this.intensity});

  @override
  Path getClip(Size size) {
    final path = Path();
    final random = math.Random(42); // Seed fijo para consistencia

    // Crear fragmentos irregulares
    for (int i = 0; i < 10; i++) {
      final startX = random.nextDouble() * size.width;
      final startY = random.nextDouble() * size.height;
      final endX =
          startX + (random.nextDouble() - 0.5) * size.width * intensity * 0.2;
      final endY =
          startY + (random.nextDouble() - 0.5) * size.height * intensity * 0.2;

      path.moveTo(startX, startY);
      path.lineTo(endX, endY);
    }

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

/// Clipper para efecto de corrosión
class CorrosionClipper extends CustomClipper<Path> {
  final double intensity;

  CorrosionClipper({required this.intensity});

  @override
  Path getClip(Size size) {
    final path = Path();
    final random = math.Random(123);

    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Crear agujeros de corrosión
    for (int i = 0; i < (intensity * 20).round(); i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = random.nextDouble() * intensity * 10;

      path.addOval(Rect.fromCircle(center: Offset(x, y), radius: radius));
    }

    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

/// Painter para efecto de TV estática
class TvStaticPainter extends CustomPainter {
  final double intensity;
  final double animationValue;

  TvStaticPainter({required this.intensity, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..blendMode = BlendMode.overlay;
    final random = math.Random((animationValue * 1000).round());

    for (int i = 0; i < (intensity * 500).round(); i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final opacity = random.nextDouble() * intensity;

      paint.color = Color.fromRGBO(255, 255, 255, opacity);
      canvas.drawCircle(Offset(x, y), 1, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

/// Painter para efecto de quemado
class BurnEffectPainter extends CustomPainter {
  final double intensity;

  BurnEffectPainter({required this.intensity});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = const Color(0xFFFF4500).withOpacity(intensity * 0.3)
          ..blendMode = BlendMode.multiply;

    final path = Path();
    final random = math.Random(456);

    for (int i = 0; i < 10; i++) {
      final x = random.nextDouble() * size.width;
      final y = size.height * (0.8 + random.nextDouble() * 0.2);
      final width = random.nextDouble() * size.width * 0.3;
      final height = random.nextDouble() * size.height * 0.2;

      path.addOval(Rect.fromLTWH(x, y, width, height));
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

/// Painter para efecto congelado
class FrozenEffectPainter extends CustomPainter {
  final double intensity;

  FrozenEffectPainter({required this.intensity});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = const Color(0xFF87CEEB).withOpacity(intensity * 0.4)
          ..blendMode = BlendMode.overlay;

    final random = math.Random(789);

    // Cristales de hielo
    for (int i = 0; i < (intensity * 50).round(); i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final length = random.nextDouble() * 20 * intensity;
      final angle = random.nextDouble() * math.pi * 2;

      final endX = x + math.cos(angle) * length;
      final endY = y + math.sin(angle) * length;

      canvas.drawLine(Offset(x, y), Offset(endX, endY), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

/// Painter para efecto eléctrico
class ElectricEffectPainter extends CustomPainter {
  final double intensity;
  final double animationValue;

  ElectricEffectPainter({
    required this.intensity,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = const Color(0xFFFFFF00).withOpacity(intensity * 0.8)
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke;

    final random = math.Random((animationValue * 100).round());

    // Rayos eléctricos
    for (int i = 0; i < (intensity * 5).round(); i++) {
      final path = Path();
      final startX = random.nextDouble() * size.width;
      final startY = random.nextDouble() * size.height;

      path.moveTo(startX, startY);

      for (int j = 0; j < 5; j++) {
        final x = startX + (random.nextDouble() - 0.5) * 100 * intensity;
        final y = startY + j * 20;
        path.lineTo(x, y);
      }

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

/// Painter para efecto radioactivo
class RadioactivePainter extends CustomPainter {
  final double intensity;
  final double animationValue;

  RadioactivePainter({required this.intensity, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = const Color(0xFF32CD32).withOpacity(intensity * 0.5)
          ..blendMode = BlendMode.overlay;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) * 0.4 * intensity;

    // Ondas radioactivas
    for (int i = 0; i < 3; i++) {
      final currentRadius = radius + (animationValue * 50) + (i * 20);
      paint.strokeWidth = 3.0 - i;
      paint.style = PaintingStyle.stroke;
      canvas.drawCircle(center, currentRadius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

/// Painter para efecto plasma
class PlasmaEffectPainter extends CustomPainter {
  final double intensity;
  final double animationValue;

  PlasmaEffectPainter({required this.intensity, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..blendMode = BlendMode.screen;

    for (int i = 0; i < (intensity * 20).round(); i++) {
      final x =
          math.sin(animationValue * math.pi * 2 + i) * size.width * 0.3 +
          size.width * 0.5;
      final y =
          math.cos(animationValue * math.pi * 2 + i * 0.5) * size.height * 0.3 +
          size.height * 0.5;

      final gradient = RadialGradient(
        colors: [
          Color.fromRGBO(255, 0, 255, intensity * 0.8),
          Color.fromRGBO(0, 255, 255, intensity * 0.5),
          BrutalConstants.transparent,
        ],
      );

      paint.shader = gradient.createShader(
        Rect.fromCircle(center: Offset(x, y), radius: 30),
      );

      canvas.drawCircle(Offset(x, y), 30, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
