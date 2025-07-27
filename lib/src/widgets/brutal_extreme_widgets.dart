import 'package:flutter/material.dart';
import '../theme/brutal_theme.dart';
import '../effects/brutal_effects.dart';
import 'dart:math' show Random;

/// Sistema de widgets brutales extremos para interfaces agresivas
///
/// Esta colección incluye widgets únicos que NO EXISTEN en ningún
/// otro framework, diseñados específicamente para crear experiencias brutales

// =============== BRUTAL DESTRUCTION WIDGETS ===============

/// Widget que simula una pantalla rota/fragmentada
class BrutalBrokenScreen extends StatelessWidget {
  final Widget child;
  final int crackCount;
  final double crackIntensity;
  final Color crackColor;
  final bool isAnimated;

  const BrutalBrokenScreen({
    super.key,
    required this.child,
    this.crackCount = 12,
    this.crackIntensity = 1.0,
    this.crackColor = Colors.black,
    this.isAnimated = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: CustomPaint(
            painter: BrokenScreenPainter(
              crackCount: crackCount,
              intensity: crackIntensity,
              crackColor: crackColor,
            ),
          ),
        ),
      ],
    );
  }
}

class BrokenScreenPainter extends CustomPainter {
  final int crackCount;
  final double intensity;
  final Color crackColor;

  BrokenScreenPainter({
    required this.crackCount,
    required this.intensity,
    required this.crackColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = crackColor
          ..strokeWidth = 2.0 * intensity
          ..style = PaintingStyle.stroke;

    final random = Random(42);

    for (int i = 0; i < crackCount; i++) {
      final startX = random.nextDouble() * size.width;
      final startY = random.nextDouble() * size.height;

      final path = Path();
      path.moveTo(startX, startY);

      // Crear líneas de crack irregulares
      for (int j = 0; j < 5; j++) {
        final nextX = startX + (random.nextDouble() - 0.5) * size.width * 0.3;
        final nextY = startY + (random.nextDouble() - 0.5) * size.height * 0.3;
        path.lineTo(nextX, nextY);
      }

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============== BRUTAL CHAOS WIDGETS ===============

/// Widget que organiza elementos en un layout completamente caótico
class BrutalChaosLayout extends StatelessWidget {
  final List<Widget> children;
  final double chaosIntensity;
  final bool allowOverlap;
  final bool isAnimated;

  const BrutalChaosLayout({
    super.key,
    required this.children,
    this.chaosIntensity = 1.0,
    this.allowOverlap = true,
    this.isAnimated = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final random = Random(42);

        return Stack(
          children:
              children.asMap().entries.map((entry) {
                final child = entry.value;

                final left =
                    random.nextDouble() * constraints.maxWidth * chaosIntensity;
                final top =
                    random.nextDouble() *
                    constraints.maxHeight *
                    chaosIntensity;
                final rotation =
                    (random.nextDouble() - 0.5) * 0.5 * chaosIntensity;

                Widget positioned = Positioned(
                  left: left,
                  top: top,
                  child: Transform.rotate(angle: rotation, child: child),
                );

                if (isAnimated) {
                  positioned = BrutalEffects.chaosRotation(
                    maxAngle: 0.2 * chaosIntensity,
                    child: positioned,
                  );
                }

                return positioned;
              }).toList(),
        );
      },
    );
  }
}

// =============== BRUTAL AGGRESSIVE WIDGETS ===============

/// Botón que "ataca" al usuario con efectos agresivos
class BrutalAssaultButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double aggressionLevel;
  final bool isPulsing;
  final bool hasGlitch;
  final bool isViolent;

  const BrutalAssaultButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.aggressionLevel = 1.0,
    this.isPulsing = true,
    this.hasGlitch = true,
    this.isViolent = true,
  });

  @override
  State<BrutalAssaultButton> createState() => _BrutalAssaultButtonState();
}

class _BrutalAssaultButtonState extends State<BrutalAssaultButton>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _shakeController;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: Duration(milliseconds: (800 / widget.aggressionLevel).round()),
      vsync: this,
    );
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 50),
      vsync: this,
    );

    if (widget.isPulsing) {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);

    Widget button = AnimatedBuilder(
      animation: Listenable.merge([_pulseController, _shakeController]),
      builder: (context, child) {
        final scale =
            widget.isPulsing
                ? 1.0 + (_pulseController.value * 0.1 * widget.aggressionLevel)
                : 1.0;

        Widget result = Transform.scale(
          scale: scale,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: theme.spacing * 2,
              vertical: theme.spacing,
            ),
            decoration: BoxDecoration(
              color: widget.backgroundColor ?? theme.colors.primary,
              border: Border.all(
                color: theme.colors.border,
                width: theme.borderWidth * widget.aggressionLevel,
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.colors.primary.withOpacity(0.5),
                  blurRadius: 10 * widget.aggressionLevel,
                  spreadRadius: 2 * widget.aggressionLevel,
                ),
              ],
            ),
            child: Text(
              widget.text,
              style: theme.typography.button.copyWith(
                color: widget.textColor ?? theme.colors.background,
                fontWeight: FontWeight.w900,
                fontSize:
                    theme.typography.button.fontSize! *
                    (1 + widget.aggressionLevel * 0.2),
              ),
            ),
          ),
        );

        if (widget.isViolent && _isHovered) {
          result = BrutalEffects.violentShake(
            intensity: 5 * widget.aggressionLevel,
            isContinuous: true,
            child: result,
          );
        }

        if (widget.hasGlitch) {
          result = BrutalEffects.glitch(
            intensity: widget.aggressionLevel,
            child: result,
          );
        }

        return result;
      },
    );

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          if (widget.isViolent) {
            _shakeController.forward().then((_) => _shakeController.reset());
          }
          widget.onPressed?.call();
        },
        child: button,
      ),
    );
  }
}

// =============== BRUTAL DATA DISPLAY WIDGETS ===============

/// Visualizador de datos estilo terminal hacker
class BrutalHackerTerminal extends StatefulWidget {
  final List<String> data;
  final Duration typewriterSpeed;
  final Color terminalColor;
  final bool hasGlitch;
  final bool hasScroll;
  final String prompt;

  const BrutalHackerTerminal({
    super.key,
    required this.data,
    this.typewriterSpeed = const Duration(milliseconds: 50),
    this.terminalColor = Colors.green,
    this.hasGlitch = true,
    this.hasScroll = true,
    this.prompt = '> ',
  });

  @override
  State<BrutalHackerTerminal> createState() => _BrutalHackerTerminalState();
}

class _BrutalHackerTerminalState extends State<BrutalHackerTerminal>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<String> _displayedLines = [];
  int _currentLineIndex = 0;
  String _currentLine = '';
  int _currentCharIndex = 0;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.typewriterSpeed,
      vsync: this,
    );
    _scrollController = ScrollController();

    _startTyping();
  }

  void _startTyping() {
    if (_currentLineIndex < widget.data.length) {
      _controller.addListener(_typeCharacter);
      _controller.forward();
    }
  }

  void _typeCharacter() {
    if (_currentCharIndex < widget.data[_currentLineIndex].length) {
      setState(() {
        _currentLine = widget.data[_currentLineIndex].substring(
          0,
          _currentCharIndex + 1,
        );
        _currentCharIndex++;
      });
    } else {
      _controller.removeListener(_typeCharacter);
      _controller.reset();

      setState(() {
        _displayedLines.add(_currentLine);
        _currentLine = '';
        _currentCharIndex = 0;
        _currentLineIndex++;
      });

      if (widget.hasScroll) {
        Future.delayed(Duration.zero, () {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
            );
          }
        });
      }

      if (_currentLineIndex < widget.data.length) {
        Future.delayed(const Duration(milliseconds: 100), _startTyping);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);

    Widget terminal = Container(
      padding: EdgeInsets.all(theme.spacing),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: widget.terminalColor, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _displayedLines.length + 1,
              itemBuilder: (context, index) {
                if (index < _displayedLines.length) {
                  return Text(
                    '${widget.prompt}${_displayedLines[index]}',
                    style: TextStyle(
                      fontFamily: 'Courier New',
                      color: widget.terminalColor,
                      fontSize: 14,
                    ),
                  );
                } else {
                  return Row(
                    children: [
                      Text(
                        widget.prompt,
                        style: TextStyle(
                          fontFamily: 'Courier New',
                          color: widget.terminalColor,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        _currentLine,
                        style: TextStyle(
                          fontFamily: 'Courier New',
                          color: widget.terminalColor,
                          fontSize: 14,
                        ),
                      ),
                      // Cursor parpadeante
                      AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Opacity(
                            opacity:
                                (_controller.value * 2) % 1 > 0.5 ? 1.0 : 0.0,
                            child: Text(
                              '█',
                              style: TextStyle(
                                fontFamily: 'Courier New',
                                color: widget.terminalColor,
                                fontSize: 14,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );

    if (widget.hasGlitch) {
      terminal = BrutalEffects.hackerTerminal(
        scanlineColor: widget.terminalColor,
        child: terminal,
      );
    }

    return terminal;
  }
}

// =============== BRUTAL DESTRUCTION METERS ===============

/// Medidor de destrucción/caos visual
class BrutalDestructionMeter extends StatefulWidget {
  final double value; // 0.0 a 1.0
  final String label;
  final Color destructionColor;
  final bool isAnimated;
  final bool hasExplosions;

  const BrutalDestructionMeter({
    super.key,
    required this.value,
    this.label = 'DESTRUCTION',
    this.destructionColor = Colors.red,
    this.isAnimated = true,
    this.hasExplosions = true,
  });

  @override
  State<BrutalDestructionMeter> createState() => _BrutalDestructionMeterState();
}

class _BrutalDestructionMeterState extends State<BrutalDestructionMeter>
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
    final theme = BrutalTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: theme.typography.caption.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
        SizedBox(height: theme.spacing * 0.5),
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Stack(
              children: [
                // Barra de fondo
                Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    border: Border.all(color: theme.colors.border, width: 2),
                  ),
                ),
                // Barra de destrucción
                Container(
                  height: 20,
                  width:
                      (MediaQuery.of(context).size.width - 32) * widget.value,
                  decoration: BoxDecoration(
                    color: widget.destructionColor,
                    border: Border.all(color: theme.colors.border, width: 2),
                  ),
                  child:
                      widget.hasExplosions && widget.value > 0.7
                          ? CustomPaint(
                            painter: ExplosionPainter(
                              progress: _controller.value,
                              color: Colors.yellow,
                            ),
                          )
                          : null,
                ),
                // Efectos adicionales según el nivel
                if (widget.value > 0.5)
                  Positioned.fill(
                    child: BrutalEffects.violentShake(
                      intensity: (widget.value - 0.5) * 10,
                      isContinuous: true,
                      child: Container(),
                    ),
                  ),
              ],
            );
          },
        ),
        SizedBox(height: theme.spacing * 0.5),
        Text(
          '${(widget.value * 100).toStringAsFixed(0)}% DESTROYED',
          style: theme.typography.caption.copyWith(
            color: widget.destructionColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class ExplosionPainter extends CustomPainter {
  final double progress;
  final Color color;

  ExplosionPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color.withOpacity(0.8)
          ..style = PaintingStyle.fill;

    final random = Random(42);

    for (int i = 0; i < 5; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = (random.nextDouble() * 3 + 1) * progress;

      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// =============== BRUTAL WARNING SYSTEM ===============

/// Sistema de advertencias brutales que demandan atención
class BrutalWarningSystem extends StatefulWidget {
  final String warningText;
  final BrutalWarningLevel level;
  final bool isDismissible;
  final VoidCallback? onDismiss;
  final Duration flashDuration;

  const BrutalWarningSystem({
    super.key,
    required this.warningText,
    this.level = BrutalWarningLevel.critical,
    this.isDismissible = true,
    this.onDismiss,
    this.flashDuration = const Duration(milliseconds: 500),
  });

  @override
  State<BrutalWarningSystem> createState() => _BrutalWarningSystemState();
}

class _BrutalWarningSystemState extends State<BrutalWarningSystem>
    with TickerProviderStateMixin {
  late AnimationController _flashController;
  late AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _flashController = AnimationController(
      duration: widget.flashDuration,
      vsync: this,
    );
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _flashController.repeat(reverse: true);
    _shakeController.repeat();
  }

  @override
  void dispose() {
    _flashController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);
    final warningColors = _getWarningColors();

    return AnimatedBuilder(
      animation: Listenable.merge([_flashController, _shakeController]),
      builder: (context, child) {
        final flashOpacity = 0.8 + (_flashController.value * 0.2);

        Widget warning = Container(
          padding: EdgeInsets.all(theme.spacing),
          decoration: BoxDecoration(
            color: warningColors.background.withOpacity(flashOpacity),
            border: Border.all(color: warningColors.border, width: 4),
            boxShadow: [
              BoxShadow(
                color: warningColors.border.withOpacity(0.5),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(_getWarningIcon(), color: warningColors.text, size: 32),
              SizedBox(width: theme.spacing),
              Expanded(
                child: Text(
                  widget.warningText,
                  style: theme.typography.heading3.copyWith(
                    color: warningColors.text,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              if (widget.isDismissible)
                GestureDetector(
                  onTap: widget.onDismiss,
                  child: Icon(Icons.close, color: warningColors.text, size: 24),
                ),
            ],
          ),
        );

        // Añadir efectos según el nivel
        if (widget.level == BrutalWarningLevel.apocalyptic) {
          warning = BrutalEffects.violentShake(
            intensity: 8,
            isContinuous: true,
            child: BrutalEffects.glitch(intensity: 2, child: warning),
          );
        } else if (widget.level == BrutalWarningLevel.critical) {
          warning = BrutalEffects.violentShake(
            intensity: 4,
            isContinuous: true,
            child: warning,
          );
        }

        return warning;
      },
    );
  }

  _WarningColors _getWarningColors() {
    switch (widget.level) {
      case BrutalWarningLevel.info:
        return _WarningColors(
          background: Colors.blue[900]!,
          border: Colors.blue,
          text: Colors.white,
        );
      case BrutalWarningLevel.warning:
        return _WarningColors(
          background: Colors.orange[900]!,
          border: Colors.orange,
          text: Colors.white,
        );
      case BrutalWarningLevel.danger:
        return _WarningColors(
          background: Colors.red[900]!,
          border: Colors.red,
          text: Colors.white,
        );
      case BrutalWarningLevel.critical:
        return _WarningColors(
          background: Colors.red[900]!,
          border: Colors.red,
          text: Colors.yellow,
        );
      case BrutalWarningLevel.apocalyptic:
        return _WarningColors(
          background: Colors.black,
          border: Colors.red,
          text: Colors.red,
        );
    }
  }

  IconData _getWarningIcon() {
    switch (widget.level) {
      case BrutalWarningLevel.info:
        return Icons.info;
      case BrutalWarningLevel.warning:
        return Icons.warning;
      case BrutalWarningLevel.danger:
        return Icons.dangerous;
      case BrutalWarningLevel.critical:
        return Icons.crisis_alert;
      case BrutalWarningLevel.apocalyptic:
        return Icons.flash_on;
    }
  }
}

enum BrutalWarningLevel { info, warning, danger, critical, apocalyptic }

class _WarningColors {
  final Color background;
  final Color border;
  final Color text;

  _WarningColors({
    required this.background,
    required this.border,
    required this.text,
  });
}

// =============== BRUTAL MATRIX RAIN ===============

/// Efecto de lluvia de Matrix/código cayendo
class BrutalMatrixRain extends StatefulWidget {
  final double intensity;
  final Color rainColor;
  final double speed;
  final List<String> characters;

  const BrutalMatrixRain({
    super.key,
    this.intensity = 1.0,
    this.rainColor = Colors.green,
    this.speed = 1.0,
    this.characters = const ['0', '1', 'A', 'B', 'C', 'X', 'Y', 'Z'],
  });

  @override
  State<BrutalMatrixRain> createState() => _BrutalMatrixRainState();
}

class _BrutalMatrixRainState extends State<BrutalMatrixRain>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<MatrixColumn> _columns = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: (2000 / widget.speed).round()),
      vsync: this,
    );

    _controller.repeat();
    _generateColumns();
  }

  void _generateColumns() {
    final columnCount = (20 * widget.intensity).round();
    _columns = List.generate(
      columnCount,
      (index) => MatrixColumn(
        x: index * 20.0,
        speed: 0.5 + (Random().nextDouble() * 1.5),
        characters: widget.characters,
      ),
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
        return CustomPaint(
          painter: MatrixRainPainter(
            progress: _controller.value,
            columns: _columns,
            color: widget.rainColor,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class MatrixColumn {
  final double x;
  final double speed;
  final List<String> characters;
  double y = 0;

  MatrixColumn({
    required this.x,
    required this.speed,
    required this.characters,
  });
}

class MatrixRainPainter extends CustomPainter {
  final double progress;
  final List<MatrixColumn> columns;
  final Color color;

  MatrixRainPainter({
    required this.progress,
    required this.columns,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    final random = Random(42);

    for (final column in columns) {
      column.y = (column.y + column.speed * 5) % (size.height + 100);

      for (int i = 0; i < 10; i++) {
        final charY = column.y - (i * 20);
        if (charY < -20 || charY > size.height) continue;

        final opacity = (1.0 - (i / 10)).clamp(0.0, 1.0);
        paint.color = color.withOpacity(opacity);

        final textPainter = TextPainter(
          text: TextSpan(
            text: column.characters[random.nextInt(column.characters.length)],
            style: TextStyle(
              color: paint.color,
              fontSize: 16,
              fontFamily: 'Courier New',
            ),
          ),
          textDirection: TextDirection.ltr,
        );

        textPainter.layout();
        textPainter.paint(canvas, Offset(column.x, charY));
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
