import 'package:flutter/widgets.dart';
import 'dart:math' as math;

/// Un layout brutalista extremo que rompe las reglas del diseño tradicional
class BrutalChaosLayout extends StatelessWidget {
  final List<Widget> children;
  final BrutalChaosType chaosType;
  final double intensity;
  final bool allowOverlap;
  final bool randomRotation;
  final bool randomScale;
  final EdgeInsetsGeometry? padding;
  final int? seed; // Para resultados consistentes

  const BrutalChaosLayout({
    super.key,
    required this.children,
    this.chaosType = BrutalChaosType.scattered,
    this.intensity = 1.0,
    this.allowOverlap = true,
    this.randomRotation = false,
    this.randomScale = false,
    this.padding,
    this.seed,
  });

  /// Layout completamente caótico
  factory BrutalChaosLayout.chaos({
    Key? key,
    required List<Widget> children,
    double intensity = 1.0,
    int? seed,
  }) {
    return BrutalChaosLayout(
      key: key,
      children: children,
      chaosType: BrutalChaosType.chaos,
      intensity: intensity,
      allowOverlap: true,
      randomRotation: true,
      randomScale: true,
      seed: seed,
    );
  }

  /// Layout disperso pero controlado
  factory BrutalChaosLayout.scattered({
    Key? key,
    required List<Widget> children,
    double intensity = 1.0,
    EdgeInsetsGeometry? padding,
    int? seed,
  }) {
    return BrutalChaosLayout(
      key: key,
      children: children,
      chaosType: BrutalChaosType.scattered,
      intensity: intensity,
      allowOverlap: false,
      randomRotation: false,
      randomScale: false,
      padding: padding,
      seed: seed,
    );
  }

  /// Layout en espiral destructiva
  factory BrutalChaosLayout.spiral({
    Key? key,
    required List<Widget> children,
    double intensity = 1.0,
    bool randomRotation = true,
    int? seed,
  }) {
    return BrutalChaosLayout(
      key: key,
      children: children,
      chaosType: BrutalChaosType.spiral,
      intensity: intensity,
      allowOverlap: true,
      randomRotation: randomRotation,
      randomScale: false,
      seed: seed,
    );
  }

  /// Layout explosivo desde el centro
  factory BrutalChaosLayout.explosion({
    Key? key,
    required List<Widget> children,
    double intensity = 1.0,
    bool randomScale = true,
    int? seed,
  }) {
    return BrutalChaosLayout(
      key: key,
      children: children,
      chaosType: BrutalChaosType.explosion,
      intensity: intensity,
      allowOverlap: true,
      randomRotation: true,
      randomScale: randomScale,
      seed: seed,
    );
  }

  /// Layout en grilla rota
  factory BrutalChaosLayout.brokenGrid({
    Key? key,
    required List<Widget> children,
    double intensity = 1.0,
    EdgeInsetsGeometry? padding,
    int? seed,
  }) {
    return BrutalChaosLayout(
      key: key,
      children: children,
      chaosType: BrutalChaosType.brokenGrid,
      intensity: intensity,
      allowOverlap: false,
      randomRotation: true,
      randomScale: false,
      padding: padding,
      seed: seed,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: padding,
          child: _buildChaosLayout(constraints),
        );
      },
    );
  }

  Widget _buildChaosLayout(BoxConstraints constraints) {
    final random = math.Random(seed ?? 42);

    switch (chaosType) {
      case BrutalChaosType.chaos:
        return _buildPureChaos(constraints, random);
      case BrutalChaosType.scattered:
        return _buildScattered(constraints, random);
      case BrutalChaosType.spiral:
        return _buildSpiral(constraints, random);
      case BrutalChaosType.explosion:
        return _buildExplosion(constraints, random);
      case BrutalChaosType.brokenGrid:
        return _buildBrokenGrid(constraints, random);
      case BrutalChaosType.magnetic:
        return _buildMagnetic(constraints, random);
      case BrutalChaosType.gravity:
        return _buildGravity(constraints, random);
      case BrutalChaosType.tornado:
        return _buildTornado(constraints, random);
    }
  }

  Widget _buildPureChaos(BoxConstraints constraints, math.Random random) {
    final positionedChildren = <Widget>[];

    for (int i = 0; i < children.length; i++) {
      final child = children[i];
      final x = random.nextDouble() * constraints.maxWidth;
      final y = random.nextDouble() * constraints.maxHeight;
      final rotation =
          randomRotation
              ? (random.nextDouble() - 0.5) * math.pi * intensity
              : 0.0;
      final scale = randomScale ? 0.5 + random.nextDouble() * intensity : 1.0;

      positionedChildren.add(
        Positioned(
          left: x.toDouble(),
          top: y.toDouble(),
          child: Transform.rotate(
            angle: rotation,
            child: Transform.scale(scale: scale, child: child),
          ),
        ),
      );
    }

    return Stack(children: positionedChildren);
  }

  Widget _buildScattered(BoxConstraints constraints, math.Random random) {
    final positionedChildren = <Widget>[];
    final usedPositions = <Rect>[];

    for (int i = 0; i < children.length; i++) {
      final child = children[i];
      Offset position;
      Rect childRect;
      int attempts = 0;

      // Intentar encontrar posición sin solapamiento
      do {
        final x = random.nextDouble() * (constraints.maxWidth - 100);
        final y = random.nextDouble() * (constraints.maxHeight - 100);
        position = Offset(x, y);
        childRect = Rect.fromLTWH(x, y, 100, 100); // Estimación del tamaño
        attempts++;
      } while (allowOverlap == false &&
          attempts < 50 &&
          usedPositions.any((rect) => rect.overlaps(childRect)));

      usedPositions.add(childRect);

      final offset = Offset(
        (random.nextDouble() - 0.5) * 50 * intensity,
        (random.nextDouble() - 0.5) * 50 * intensity,
      );

      positionedChildren.add(
        Positioned(
          left: position.dx + offset.dx,
          top: position.dy + offset.dy,
          child: child,
        ),
      );
    }

    return Stack(children: positionedChildren);
  }

  Widget _buildSpiral(BoxConstraints constraints, math.Random random) {
    final positionedChildren = <Widget>[];
    final centerX = constraints.maxWidth / 2;
    final centerY = constraints.maxHeight / 2;
    final maxRadius = math.min(centerX, centerY) * 0.8;

    for (int i = 0; i < children.length; i++) {
      final child = children[i];
      final angle = (i / children.length) * math.pi * 4 * intensity;
      final radius = (i / children.length) * maxRadius;

      final x = centerX + math.cos(angle) * radius;
      final y = centerY + math.sin(angle) * radius;

      final rotation =
          randomRotation
              ? angle + (random.nextDouble() - 0.5) * math.pi
              : angle;

      positionedChildren.add(
        Positioned(
          left: x,
          top: y,
          child: Transform.rotate(angle: rotation, child: child),
        ),
      );
    }

    return Stack(children: positionedChildren);
  }

  Widget _buildExplosion(BoxConstraints constraints, math.Random random) {
    final positionedChildren = <Widget>[];
    final centerX = constraints.maxWidth / 2;
    final centerY = constraints.maxHeight / 2;

    for (int i = 0; i < children.length; i++) {
      final child = children[i];
      final angle = random.nextDouble() * math.pi * 2;
      final distance = random.nextDouble() * intensity * 200;

      final x = centerX + math.cos(angle) * distance;
      final y = centerY + math.sin(angle) * distance;

      final rotation =
          randomRotation ? (random.nextDouble() - 0.5) * math.pi : 0.0;
      final scale =
          randomScale ? 0.3 + random.nextDouble() * intensity * 0.7 : 1.0;

      positionedChildren.add(
        Positioned(
          left: x.clamp(0, constraints.maxWidth - 50),
          top: y.clamp(0, constraints.maxHeight - 50),
          child: Transform.rotate(
            angle: rotation,
            child: Transform.scale(scale: scale, child: child),
          ),
        ),
      );
    }

    return Stack(children: positionedChildren);
  }

  Widget _buildBrokenGrid(BoxConstraints constraints, math.Random random) {
    final positionedChildren = <Widget>[];
    final cols = math.sqrt(children.length).ceil();
    final cellWidth = constraints.maxWidth / cols;
    final cellHeight = constraints.maxHeight / cols;

    for (int i = 0; i < children.length; i++) {
      final child = children[i];
      final row = i ~/ cols;
      final col = i % cols;

      final baseX = col * cellWidth;
      final baseY = row * cellHeight;

      // Añadir desviación brutal
      final offsetX = (random.nextDouble() - 0.5) * cellWidth * intensity;
      final offsetY = (random.nextDouble() - 0.5) * cellHeight * intensity;

      final x = (baseX + offsetX).clamp(0, constraints.maxWidth - 50);
      final y = (baseY + offsetY).clamp(0, constraints.maxHeight - 50);

      final rotation =
          randomRotation ? (random.nextDouble() - 0.5) * math.pi * 0.3 : 0.0;

      positionedChildren.add(
        Positioned(
          left: x.toDouble(),
          top: y.toDouble(),
          child: Transform.rotate(angle: rotation, child: child),
        ),
      );
    }

    return Stack(children: positionedChildren);
  }

  Widget _buildMagnetic(BoxConstraints constraints, math.Random random) {
    final positionedChildren = <Widget>[];
    final attractorX = constraints.maxWidth * 0.3;
    final attractorY = constraints.maxHeight * 0.3;

    for (int i = 0; i < children.length; i++) {
      final child = children[i];
      final angle = (i / children.length) * math.pi * 2;
      final baseDistance = 50 + i * 30;

      // Fuerza magnética hacia el atractor
      final forceX =
          (attractorX - baseDistance * math.cos(angle)) * intensity * 0.5;
      final forceY =
          (attractorY - baseDistance * math.sin(angle)) * intensity * 0.5;

      final x = baseDistance * math.cos(angle) + forceX;
      final y = baseDistance * math.sin(angle) + forceY;

      positionedChildren.add(
        Positioned(
          left: x.clamp(0, constraints.maxWidth - 50),
          top: y.clamp(0, constraints.maxHeight - 50),
          child: child,
        ),
      );
    }

    return Stack(children: positionedChildren);
  }

  Widget _buildGravity(BoxConstraints constraints, math.Random random) {
    final positionedChildren = <Widget>[];
    final bottomY = constraints.maxHeight - 50;

    for (int i = 0; i < children.length; i++) {
      final child = children[i];
      final x = random.nextDouble() * (constraints.maxWidth - 50);

      // Simular caída con diferentes "masas"
      final mass = 0.5 + random.nextDouble() * 0.5;
      final fallDistance = intensity * mass * 100;
      final y = (bottomY - fallDistance).clamp(0, bottomY).toDouble();

      final rotation = (random.nextDouble() - 0.5) * math.pi * 0.2;

      positionedChildren.add(
        Positioned(
          left: x.toDouble(),
          top: y,
          child: Transform.rotate(angle: rotation, child: child),
        ),
      );
    }

    return Stack(children: positionedChildren);
  }

  Widget _buildTornado(BoxConstraints constraints, math.Random random) {
    final positionedChildren = <Widget>[];
    final centerX = constraints.maxWidth / 2;
    final centerY = constraints.maxHeight / 2;

    for (int i = 0; i < children.length; i++) {
      final child = children[i];
      final progress = i / children.length;
      final angle = progress * math.pi * 6 * intensity;
      final radius = progress * math.min(centerX, centerY) * 0.8;
      final height = progress * constraints.maxHeight;

      final x = centerX + math.cos(angle) * radius;
      final y =
          centerY - height * 0.5 + (1 - progress) * constraints.maxHeight * 0.3;

      final rotation = angle + progress * math.pi * 2;
      final scale = 1.0 - progress * 0.5;

      positionedChildren.add(
        Positioned(
          left: x.clamp(0, constraints.maxWidth - 50),
          top: y.clamp(0, constraints.maxHeight - 50),
          child: Transform.rotate(
            angle: rotation,
            child: Transform.scale(scale: scale, child: child),
          ),
        ),
      );
    }

    return Stack(children: positionedChildren);
  }
}

/// Tipos de layout caótico
enum BrutalChaosType {
  chaos, // Completamente caótico
  scattered, // Disperso pero controlado
  spiral, // En espiral
  explosion, // Explosivo desde el centro
  brokenGrid, // Grilla rota
  magnetic, // Atracción magnética
  gravity, // Efecto gravitacional
  tornado, // Efecto tornado
}

/// Layout que simula elementos flotando en el espacio
class BrutalFloatingLayout extends StatefulWidget {
  final List<Widget> children;
  final Duration animationDuration;
  final double intensity;
  final bool enablePhysics;

  const BrutalFloatingLayout({
    super.key,
    required this.children,
    this.animationDuration = const Duration(seconds: 10),
    this.intensity = 1.0,
    this.enablePhysics = true,
  });

  @override
  State<BrutalFloatingLayout> createState() => _BrutalFloatingLayoutState();
}

class _BrutalFloatingLayoutState extends State<BrutalFloatingLayout>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<Offset>> _animations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controllers = [];
    _animations = [];

    for (int i = 0; i < widget.children.length; i++) {
      final controller = AnimationController(
        duration: widget.animationDuration,
        vsync: this,
      );

      final random = math.Random(i);
      final animation = Tween<Offset>(
        begin: Offset(random.nextDouble() * 2 - 1, random.nextDouble() * 2 - 1),
        end: Offset(random.nextDouble() * 2 - 1, random.nextDouble() * 2 - 1),
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));

      _controllers.add(controller);
      _animations.add(animation);

      controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: List.generate(widget.children.length, (index) {
            return AnimatedBuilder(
              animation: _animations[index],
              builder: (context, child) {
                final offset = _animations[index].value * widget.intensity * 50;
                return Positioned(
                  left: constraints.maxWidth / 2 + offset.dx,
                  top: constraints.maxHeight / 2 + offset.dy,
                  child: widget.children[index],
                );
              },
            );
          }),
        );
      },
    );
  }
}

/// Layout que crea efectos de partículas con widgets
class BrutalParticleLayout extends StatefulWidget {
  final List<Widget> children;
  final Duration animationDuration;
  final BrutalParticleEffect effect;
  final double intensity;

  const BrutalParticleLayout({
    super.key,
    required this.children,
    this.animationDuration = const Duration(seconds: 5),
    this.effect = BrutalParticleEffect.explosion,
    this.intensity = 1.0,
  });

  @override
  State<BrutalParticleLayout> createState() => _BrutalParticleLayoutState();
}

class _BrutalParticleLayoutState extends State<BrutalParticleLayout>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Offset> _initialPositions;
  late List<Offset> _finalPositions;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _generatePositions();
    _controller.forward();
  }

  void _generatePositions() {
    final random = math.Random();
    _initialPositions = [];
    _finalPositions = [];

    for (int i = 0; i < widget.children.length; i++) {
      switch (widget.effect) {
        case BrutalParticleEffect.explosion:
          _initialPositions.add(const Offset(0.5, 0.5));
          final angle = random.nextDouble() * math.pi * 2;
          final distance = random.nextDouble() * widget.intensity;
          _finalPositions.add(
            Offset(
              0.5 + math.cos(angle) * distance,
              0.5 + math.sin(angle) * distance,
            ),
          );
          break;
        case BrutalParticleEffect.implosion:
          final angle = random.nextDouble() * math.pi * 2;
          final distance = random.nextDouble() * widget.intensity;
          _initialPositions.add(
            Offset(
              0.5 + math.cos(angle) * distance,
              0.5 + math.sin(angle) * distance,
            ),
          );
          _finalPositions.add(const Offset(0.5, 0.5));
          break;
        case BrutalParticleEffect.vortex:
          final radius = 0.3 + random.nextDouble() * 0.2;
          final angle = (i / widget.children.length) * math.pi * 2;
          _initialPositions.add(
            Offset(
              0.5 + math.cos(angle) * radius,
              0.5 + math.sin(angle) * radius,
            ),
          );
          _finalPositions.add(
            Offset(
              0.5 + math.cos(angle + math.pi * 4) * radius * 0.1,
              0.5 + math.sin(angle + math.pi * 4) * radius * 0.1,
            ),
          );
          break;
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
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              children: List.generate(widget.children.length, (index) {
                final initialPos = _initialPositions[index];
                final finalPos = _finalPositions[index];
                final currentPos =
                    Offset.lerp(initialPos, finalPos, _controller.value)!;

                return Positioned(
                  left: currentPos.dx * constraints.maxWidth,
                  top: currentPos.dy * constraints.maxHeight,
                  child: Transform.rotate(
                    angle: _controller.value * math.pi * 2,
                    child: Transform.scale(
                      scale: 1.0 - _controller.value * 0.3,
                      child: widget.children[index],
                    ),
                  ),
                );
              }),
            );
          },
        );
      },
    );
  }
}

/// Tipos de efectos de partículas
enum BrutalParticleEffect { explosion, implosion, vortex }
