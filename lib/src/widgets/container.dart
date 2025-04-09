import 'package:flutter/widgets.dart';
import '../theme/brutal_theme.dart';

/// Un contenedor con el estilo de Brutal UI mejorado.
class BrutalContainer extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;
  final bool hasShadow;
  final double? borderWidth;
  final BrutalBorderStyle? borderStyle;
  final BrutalContainerVariant variant;
  final double? rotation; // Rotación para efecto brutalista
  final bool isGlitched; // Efecto glitch

  const BrutalContainer({
    super.key,
    this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.width,
    this.height,
    this.alignment,
    this.hasShadow = false,
    this.borderWidth,
    this.borderStyle,
    this.variant = BrutalContainerVariant.regular,
    this.rotation,
    this.isGlitched = false,
  });

  // Fábrica para un contenedor señalizado (destacado)
  factory BrutalContainer.callout({
    Key? key,
    Widget? child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    Color? borderColor,
    double? width,
    double? height,
    AlignmentGeometry? alignment,
    double? borderWidth,
  }) {
    return BrutalContainer(
      key: key,
      padding: padding,
      margin: margin,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      width: width,
      height: height,
      alignment: alignment,
      hasShadow: true,
      borderWidth: borderWidth,
      variant: BrutalContainerVariant.callout,
      child: child,
    );
  }

  // Fábrica para contenedor flotante
  factory BrutalContainer.floating({
    Key? key,
    Widget? child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    Color? borderColor,
    double? width,
    double? height,
    AlignmentGeometry? alignment,
    double? borderWidth,
  }) {
    return BrutalContainer(
      key: key,
      padding: padding,
      margin: margin,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      width: width,
      height: height,
      alignment: alignment,
      hasShadow: true,
      borderWidth: borderWidth,
      variant: BrutalContainerVariant.floating,
      child: child,
    );
  }

  // Fábrica para contenedor "roto"
  factory BrutalContainer.broken({
    Key? key,
    Widget? child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    Color? borderColor,
    double? width,
    double? height,
    AlignmentGeometry? alignment,
    double? borderWidth,
  }) {
    return BrutalContainer(
      key: key,
      padding: padding,
      margin: margin,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      width: width,
      height: height,
      alignment: alignment,
      hasShadow: true,
      borderWidth: borderWidth,
      variant: BrutalContainerVariant.broken,
      rotation: -1.5,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);
    final effectiveBorderWidth = borderWidth ?? theme.borderWidth;
    final effectiveBorderStyle = borderStyle ?? theme.borderStyle;

    // Determinar sombras según la variante
    BoxShadow? shadow;
    if (hasShadow) {
      final color = borderColor ?? theme.colors.border;
      switch (variant) {
        case BrutalContainerVariant.regular:
          shadow = theme.shadow.toBoxShadow(color);
          break;
        case BrutalContainerVariant.callout:
          shadow = BrutalShadow(
            offset: const Offset(3.0, 3.0),
            opacity: 0.4,
          ).toBoxShadow(color);
          break;
        case BrutalContainerVariant.floating:
          shadow = BrutalShadow(
            offset: const Offset(6.0, 6.0),
            blurRadius: 2.0,
            opacity: 0.4,
          ).toBoxShadow(color);
          break;
        case BrutalContainerVariant.broken:
          shadow = BrutalShadow(
            offset: const Offset(2.0, 3.0),
            blurRadius: 0.5,
            opacity: 0.5,
          ).toBoxShadow(color);
          break;
        case BrutalContainerVariant.neon:
          shadow = BrutalShadow(
            offset: Offset.zero,
            blurRadius: 8.0,
            spreadRadius: 2.0,
            opacity: 0.7,
          ).toBoxShadow(borderColor ?? theme.colors.primary);
          break;
      }
    }

    // Decidir el borde según el estilo
    Border? border;
    switch (effectiveBorderStyle) {
      case BrutalBorderStyle.none:
        border = null;
        break;
      case BrutalBorderStyle.solid:
        border = Border.all(
          color: borderColor ?? theme.colors.border,
          width: effectiveBorderWidth,
        );
        break;
      case BrutalBorderStyle.dashed:
        // En un caso real, aquí usarías un DashedBoxBorder o un CustomPainter
        border = Border.all(
          color: borderColor ?? theme.colors.border,
          width: effectiveBorderWidth,
        );
        break;
      default:
        border = Border.all(
          color: borderColor ?? theme.colors.border,
          width: effectiveBorderWidth,
        );
    }

    Widget container = Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding ?? EdgeInsets.all(theme.spacing),
      alignment: alignment,
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colors.surface,
        border: border,
        boxShadow: shadow != null ? [shadow] : null,
      ),
      child: child,
    );

    // Aplicar rotación si está especificada
    if (rotation != null) {
      container = Transform.rotate(
        angle: rotation! * 0.02, // Convertir a radianes pero mantener sutil
        child: container,
      );
    }

    // Aplicar efecto glitch
    if (isGlitched) {
      container = Stack(
        children: [
          Positioned(
            left: 2,
            child: Opacity(
              opacity: 0.7,
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Color(0xFFFF0000),
                  BlendMode.srcATop,
                ),
                child: container,
              ),
            ),
          ),
          Positioned(
            left: -2,
            child: Opacity(
              opacity: 0.7,
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Color(0xFF00FFFF),
                  BlendMode.srcATop,
                ),
                child: container,
              ),
            ),
          ),
          container,
        ],
      );
    }

    return container;
  }
}

/// Variantes de contenedor brutalista
enum BrutalContainerVariant {
  regular, // Contenedor estándar
  callout, // Contenedor destacado
  floating, // Contenedor con sombra flotante
  broken, // Contenedor desplazado o rotado
  neon, // Contenedor con efecto neón
}
