import 'package:flutter/widgets.dart';

/// Un constructor responsivo que ayuda a crear interfaces adaptativas
class BrutalResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, BrutalScreenType screenType)
  builder;
  final BrutalResponsiveBreakpoints? breakpoints;

  const BrutalResponsiveBuilder({
    super.key,
    required this.builder,
    this.breakpoints,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final effectiveBreakpoints =
        breakpoints ?? BrutalResponsiveBreakpoints.standard();

    BrutalScreenType screenType;
    if (width <= effectiveBreakpoints.mobile) {
      screenType = BrutalScreenType.mobile;
    } else if (width <= effectiveBreakpoints.tablet) {
      screenType = BrutalScreenType.tablet;
    } else {
      screenType = BrutalScreenType.desktop;
    }

    return builder(context, screenType);
  }
}

/// Builder especializado que proporciona diferentes widgets según el tipo de pantalla
class BrutalScreenBuilder extends StatelessWidget {
  final Widget? mobile;
  final Widget? tablet;
  final Widget desktop;
  final BrutalResponsiveBreakpoints? breakpoints;

  const BrutalScreenBuilder({
    super.key,
    this.mobile,
    this.tablet,
    required this.desktop,
    this.breakpoints,
  });

  @override
  Widget build(BuildContext context) {
    return BrutalResponsiveBuilder(
      breakpoints: breakpoints,
      builder: (context, screenType) {
        switch (screenType) {
          case BrutalScreenType.mobile:
            return mobile ?? tablet ?? desktop;
          case BrutalScreenType.tablet:
            return tablet ?? desktop;
          case BrutalScreenType.desktop:
            return desktop;
        }
      },
    );
  }
}

/// Builder orientado específicamente a layouts
class BrutalLayoutBuilder extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    BrutalScreenType screenType,
    BoxConstraints constraints,
  )
  builder;
  final BrutalResponsiveBreakpoints? breakpoints;

  const BrutalLayoutBuilder({
    super.key,
    required this.builder,
    this.breakpoints,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final effectiveBreakpoints =
            breakpoints ?? BrutalResponsiveBreakpoints.standard();

        BrutalScreenType screenType;
        if (width <= effectiveBreakpoints.mobile) {
          screenType = BrutalScreenType.mobile;
        } else if (width <= effectiveBreakpoints.tablet) {
          screenType = BrutalScreenType.tablet;
        } else {
          screenType = BrutalScreenType.desktop;
        }

        return builder(context, screenType, constraints);
      },
    );
  }
}

/// Helper que proporciona información sobre el tipo de pantalla actual
class BrutalResponsiveDetector {
  /// Determina el tipo de pantalla basado en el ancho actual del contexto
  static BrutalScreenType getScreenType(
    BuildContext context, [
    BrutalResponsiveBreakpoints? breakpoints,
  ]) {
    final width = MediaQuery.of(context).size.width;
    final effectiveBreakpoints =
        breakpoints ?? BrutalResponsiveBreakpoints.standard();

    if (width <= effectiveBreakpoints.mobile) {
      return BrutalScreenType.mobile;
    } else if (width <= effectiveBreakpoints.tablet) {
      return BrutalScreenType.tablet;
    } else {
      return BrutalScreenType.desktop;
    }
  }

  /// Comprueba si la pantalla actual es móvil
  static bool isMobile(
    BuildContext context, [
    BrutalResponsiveBreakpoints? breakpoints,
  ]) {
    return getScreenType(context, breakpoints) == BrutalScreenType.mobile;
  }

  /// Comprueba si la pantalla actual es tablet
  static bool isTablet(
    BuildContext context, [
    BrutalResponsiveBreakpoints? breakpoints,
  ]) {
    return getScreenType(context, breakpoints) == BrutalScreenType.tablet;
  }

  /// Comprueba si la pantalla actual es desktop
  static bool isDesktop(
    BuildContext context, [
    BrutalResponsiveBreakpoints? breakpoints,
  ]) {
    return getScreenType(context, breakpoints) == BrutalScreenType.desktop;
  }
}

/// Extensión para MediaQueryData que añade métodos de detección de tipo de pantalla
extension BrutalMediaQueryExtension on MediaQueryData {
  /// Determina el tipo de pantalla para este MediaQueryData
  BrutalScreenType getScreenType([BrutalResponsiveBreakpoints? breakpoints]) {
    final effectiveBreakpoints =
        breakpoints ?? BrutalResponsiveBreakpoints.standard();

    if (size.width <= effectiveBreakpoints.mobile) {
      return BrutalScreenType.mobile;
    } else if (size.width <= effectiveBreakpoints.tablet) {
      return BrutalScreenType.tablet;
    } else {
      return BrutalScreenType.desktop;
    }
  }

  /// Comprueba si la pantalla actual es móvil
  bool get isMobile => getScreenType() == BrutalScreenType.mobile;

  /// Comprueba si la pantalla actual es tablet
  bool get isTablet => getScreenType() == BrutalScreenType.tablet;

  /// Comprueba si la pantalla actual es desktop
  bool get isDesktop => getScreenType() == BrutalScreenType.desktop;
}

/// Los diferentes tipos de pantalla que se pueden detectar
enum BrutalScreenType { mobile, tablet, desktop }

/// Puntos de quiebre para determinar el tipo de pantalla
class BrutalResponsiveBreakpoints {
  final double mobile;
  final double tablet;
  final double desktop;

  const BrutalResponsiveBreakpoints({
    required this.mobile,
    required this.tablet,
    required this.desktop,
  });

  /// Puntos de quiebre estándar
  factory BrutalResponsiveBreakpoints.standard() {
    return const BrutalResponsiveBreakpoints(
      mobile: 600,
      tablet: 1024,
      desktop: double.infinity,
    );
  }

  /// Puntos de quiebre más compactos
  factory BrutalResponsiveBreakpoints.compact() {
    return const BrutalResponsiveBreakpoints(
      mobile: 480,
      tablet: 768,
      desktop: double.infinity,
    );
  }
}
