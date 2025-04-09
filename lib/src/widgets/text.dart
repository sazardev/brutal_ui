import 'package:flutter/widgets.dart';
import 'dart:math' as math;
import '../theme/brutal_theme.dart';

/// Un widget de texto estilizado para Brutal UI.
class BrutalText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final BrutalTextStyle brutalStyle;
  final bool isStrikeThrough;
  final bool isGlitched;
  final bool isRotated;
  final BrutalTextVariant variant;

  const BrutalText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.brutalStyle = BrutalTextStyle.body,
    this.isStrikeThrough = false,
    this.isGlitched = false,
    this.isRotated = false,
    this.variant = BrutalTextVariant.default_,
  });

  /// Constructor para texto de título principal
  const BrutalText.heading1(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isStrikeThrough = false,
    this.isGlitched = false,
    this.isRotated = false,
    this.variant = BrutalTextVariant.default_,
  }) : brutalStyle = BrutalTextStyle.heading1;

  /// Constructor para texto de título secundario
  const BrutalText.heading2(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isStrikeThrough = false,
    this.isGlitched = false,
    this.isRotated = false,
    this.variant = BrutalTextVariant.default_,
  }) : brutalStyle = BrutalTextStyle.heading2;

  /// Constructor para texto de título terciario
  const BrutalText.heading3(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isStrikeThrough = false,
    this.isGlitched = false,
    this.isRotated = false,
    this.variant = BrutalTextVariant.default_,
  }) : brutalStyle = BrutalTextStyle.heading3;

  /// Constructor para texto de etiqueta pequeña
  const BrutalText.caption(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isStrikeThrough = false,
    this.isGlitched = false,
    this.isRotated = false,
    this.variant = BrutalTextVariant.default_,
  }) : brutalStyle = BrutalTextStyle.caption;

  /// Constructor para texto monoespacio
  const BrutalText.mono(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isStrikeThrough = false,
    this.isGlitched = false,
    this.isRotated = false,
    this.variant = BrutalTextVariant.default_,
  }) : brutalStyle = BrutalTextStyle.monospace;

  /// Constructor para texto destacado
  const BrutalText.display(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.isStrikeThrough = false,
    this.isGlitched = false,
    this.isRotated = false,
    this.variant = BrutalTextVariant.default_,
  }) : brutalStyle = BrutalTextStyle.display;

  /// Constructor para texto con efecto glitch
  factory BrutalText.glitched(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    BrutalTextStyle brutalStyle = BrutalTextStyle.heading1,
  }) {
    return BrutalText(
      text,
      key: key,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      brutalStyle: brutalStyle,
      isGlitched: true,
      variant: BrutalTextVariant.glitch,
    );
  }

  /// Constructor para texto marcado
  factory BrutalText.marked(
    String text, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    BrutalTextStyle brutalStyle = BrutalTextStyle.body,
  }) {
    return BrutalText(
      text,
      key: key,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      brutalStyle: brutalStyle,
      variant: BrutalTextVariant.marked,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);

    // Selecciona el estilo base de acuerdo al tipo
    TextStyle baseStyle;
    switch (brutalStyle) {
      case BrutalTextStyle.heading1:
        baseStyle = theme.typography.heading1;
      case BrutalTextStyle.heading2:
        baseStyle = theme.typography.heading2;
      case BrutalTextStyle.heading3:
        baseStyle = theme.typography.heading3;
      case BrutalTextStyle.body:
        baseStyle = theme.typography.body;
      case BrutalTextStyle.caption:
        baseStyle = theme.typography.caption;
      case BrutalTextStyle.button:
        baseStyle = theme.typography.button;
      case BrutalTextStyle.monospace:
        baseStyle = theme.typography.monospace;
      case BrutalTextStyle.display:
        baseStyle = theme.typography.display;
    }

    // Aplica el color de texto por defecto
    baseStyle = baseStyle.copyWith(color: theme.colors.text);

    // Aplicar tachado si se solicita
    if (isStrikeThrough) {
      baseStyle = baseStyle.copyWith(
        decoration: TextDecoration.lineThrough,
        decorationColor: baseStyle.color,
        decorationThickness: 2.0,
      );
    }

    // Aplicar variantes específicas
    switch (variant) {
      case BrutalTextVariant.default_:
        // No se aplican modificaciones adicionales
        break;
      case BrutalTextVariant.marked:
        baseStyle = baseStyle.copyWith(
          backgroundColor: theme.colors.primary.withOpacity(0.2),
          fontWeight: FontWeight.bold,
        );
        break;
      case BrutalTextVariant.redacted:
        baseStyle = baseStyle.copyWith(
          backgroundColor: theme.colors.text,
          color: theme.colors.text,
        );
        break;
      case BrutalTextVariant.glitch:
        // El efecto glitch se aplicará mediante un stack más adelante
        break;
      case BrutalTextVariant.loud:
        baseStyle = baseStyle.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: (baseStyle.fontSize ?? 16) * 1.2,
          letterSpacing: 1.0,
        );
        break;
      case BrutalTextVariant.subtle:
        baseStyle = baseStyle.copyWith(
          color: theme.colors.textLight,
          fontWeight: FontWeight.w300,
        );
        break;
    }

    // Combina con el estilo personalizado si existe
    final finalStyle = style != null ? baseStyle.merge(style) : baseStyle;

    // Crear el widget de texto básico
    Widget textWidget = Text(
      text,
      style: finalStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );

    // Aplicar rotación si se solicita
    if (isRotated) {
      // Rotación aleatoria entre -5 y 5 grados para efecto brutalista
      final angle = (math.Random().nextDouble() * 10 - 5) * (math.pi / 180);
      textWidget = Transform.rotate(angle: angle, child: textWidget);
    }

    // Aplicar efecto glitch si se solicita
    if (isGlitched) {
      textWidget = Stack(
        children: [
          Positioned(
            left: 2,
            child: Text(
              text,
              style: finalStyle.copyWith(
                color: const Color(0xFFFF0000).withOpacity(0.7),
              ),
              textAlign: textAlign,
              maxLines: maxLines,
              overflow: overflow,
            ),
          ),
          Positioned(
            left: -2,
            child: Text(
              text,
              style: finalStyle.copyWith(
                color: const Color(0xFF00FFFF).withOpacity(0.7),
              ),
              textAlign: textAlign,
              maxLines: maxLines,
              overflow: overflow,
            ),
          ),
          textWidget,
        ],
      );
    }

    return textWidget;
  }
}

/// Tipos de texto en Brutal UI
enum BrutalTextStyle {
  heading1,
  heading2,
  heading3,
  body,
  caption,
  button,
  monospace,
  display,
}

/// Variantes de estilo para el texto brutalista
enum BrutalTextVariant {
  default_, // Estilo normal
  marked, // Texto resaltado
  redacted, // Texto censurado
  glitch, // Texto con efecto glitch
  loud, // Texto con énfasis
  subtle, // Texto sutil
}
