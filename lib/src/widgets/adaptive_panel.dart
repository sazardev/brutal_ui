import 'package:flutter/widgets.dart';
import '../theme/brutal_theme.dart';

/// Un panel adaptativo que cambia su layout según el tamaño de pantalla
class BrutalAdaptivePanel extends StatelessWidget {
  final Widget child;
  final BrutalAdaptivePanelConfig? config;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool hasBorder;
  final bool isGlitched;
  final bool isBroken;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final BoxConstraints? constraints;

  const BrutalAdaptivePanel({
    super.key,
    required this.child,
    this.config,
    this.backgroundColor,
    this.borderColor,
    this.hasBorder = true,
    this.isGlitched = false,
    this.isBroken = false,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final effectiveConfig = config ?? BrutalAdaptivePanelConfig.standard();
    final effectiveBackgroundColor = backgroundColor ?? theme.colors.surface;
    final effectiveBorderColor = borderColor ?? theme.colors.border;

    // Determinar el ancho adaptativo del panel
    double? effectiveWidth;
    double? effectiveMaxWidth;

    if (width != null) {
      // Si se proporciona un ancho fijo, usarlo siempre
      effectiveWidth = width;
    } else {
      // De lo contrario, adaptar según el tamaño de pantalla
      if (screenWidth <= effectiveConfig.mobileBreakpoint) {
        effectiveWidth = screenWidth * effectiveConfig.mobileWidthFactor;
        effectiveMaxWidth = effectiveConfig.mobileMaxWidth;
      } else if (screenWidth <= effectiveConfig.tabletBreakpoint) {
        effectiveWidth = screenWidth * effectiveConfig.tabletWidthFactor;
        effectiveMaxWidth = effectiveConfig.tabletMaxWidth;
      } else {
        effectiveWidth = screenWidth * effectiveConfig.desktopWidthFactor;
        effectiveMaxWidth = effectiveConfig.desktopMaxWidth;
      }
    }

    // Aplicar restricciones de tamaño
    final effectiveConstraints =
        constraints ??
        BoxConstraints(
          maxWidth: effectiveMaxWidth ?? double.infinity,
          maxHeight: height ?? double.infinity,
        );

    // Crear el panel base
    Widget panel = Container(
      width: effectiveWidth,
      height: height,
      constraints: effectiveConstraints,
      padding: padding ?? EdgeInsets.all(theme.spacing),
      margin: margin,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        border:
            hasBorder
                ? Border.all(
                  color: effectiveBorderColor,
                  width: theme.borderWidth,
                )
                : null,
      ),
      child: child,
    );

    // Aplicar efecto broken si se solicita
    if (isBroken) {
      panel = Transform.rotate(angle: 0.01, child: panel);
    }

    // Aplicar efecto glitch si se solicita
    if (isGlitched) {
      panel = Stack(
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
                child: panel,
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
                child: panel,
              ),
            ),
          ),
          panel,
        ],
      );
    }

    return panel;
  }

  /// Crea un panel adaptativo centrado
  factory BrutalAdaptivePanel.centered({
    Key? key,
    required Widget child,
    BrutalAdaptivePanelConfig? config,
    Color? backgroundColor,
    Color? borderColor,
    bool hasBorder = true,
    bool isGlitched = false,
    bool isBroken = false,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? width,
    double? height,
  }) {
    return BrutalAdaptivePanel(
      key: key,
      config: config,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      hasBorder: hasBorder,
      isGlitched: isGlitched,
      isBroken: isBroken,
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      child: Center(child: child),
    );
  }

  /// Crea un panel adaptativo con efecto glitcheado y distorsionado
  factory BrutalAdaptivePanel.broken({
    Key? key,
    required Widget child,
    BrutalAdaptivePanelConfig? config,
    Color? backgroundColor,
    Color? borderColor,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    double? width,
    double? height,
  }) {
    return BrutalAdaptivePanel(
      key: key,
      config: config,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      hasBorder: true,
      isGlitched: true,
      isBroken: true,
      padding: padding,
      margin: margin,
      width: width,
      height: height,
      child: child,
    );
  }
}

/// Configuración para el panel adaptativo
class BrutalAdaptivePanelConfig {
  // Breakpoints
  final double mobileBreakpoint;
  final double tabletBreakpoint;

  // Factores de ancho según dispositivo (porcentaje del ancho de pantalla)
  final double mobileWidthFactor;
  final double tabletWidthFactor;
  final double desktopWidthFactor;

  // Anchos máximos según dispositivo
  final double? mobileMaxWidth;
  final double? tabletMaxWidth;
  final double? desktopMaxWidth;

  const BrutalAdaptivePanelConfig({
    this.mobileBreakpoint = 600,
    this.tabletBreakpoint = 960,
    this.mobileWidthFactor = 0.95,
    this.tabletWidthFactor = 0.75,
    this.desktopWidthFactor = 0.6,
    this.mobileMaxWidth,
    this.tabletMaxWidth,
    this.desktopMaxWidth = 1200,
  });

  /// Configuración estándar para paneles responsivos
  factory BrutalAdaptivePanelConfig.standard() {
    return const BrutalAdaptivePanelConfig(
      mobileBreakpoint: 600,
      tabletBreakpoint: 960,
      mobileWidthFactor: 0.95,
      tabletWidthFactor: 0.75,
      desktopWidthFactor: 0.60,
      mobileMaxWidth: double.infinity,
      tabletMaxWidth: double.infinity,
      desktopMaxWidth: 1200,
    );
  }

  /// Configuración más compacta para paneles responsivos
  factory BrutalAdaptivePanelConfig.compact() {
    return const BrutalAdaptivePanelConfig(
      mobileBreakpoint: 480,
      tabletBreakpoint: 768,
      mobileWidthFactor: 0.9,
      tabletWidthFactor: 0.65,
      desktopWidthFactor: 0.5,
      mobileMaxWidth: double.infinity,
      tabletMaxWidth: double.infinity,
      desktopMaxWidth: 800,
    );
  }

  /// Configuración para paneles de diálogo
  factory BrutalAdaptivePanelConfig.dialog() {
    return const BrutalAdaptivePanelConfig(
      mobileBreakpoint: 600,
      tabletBreakpoint: 960,
      mobileWidthFactor: 0.85,
      tabletWidthFactor: 0.5,
      desktopWidthFactor: 0.35,
      mobileMaxWidth: 500,
      tabletMaxWidth: 600,
      desktopMaxWidth: 700,
    );
  }
}
