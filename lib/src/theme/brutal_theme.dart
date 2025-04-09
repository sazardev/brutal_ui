import 'package:flutter/widgets.dart';
import 'brutal_colors.dart';
import 'brutal_typography.dart';

/// El tema principal para Brutal UI con opciones brutalistas adicionales.
class BrutalTheme {
  final BrutalColors colors;
  final BrutalTypography typography;
  final double spacing;
  final double borderWidth;

  // Nuevas propiedades brutalistas
  final BrutalShadow shadow;
  final BrutalBorderStyle borderStyle;
  final BrutalIntensity intensity;
  final BrutalVariant variant;

  const BrutalTheme({
    required this.colors,
    required this.typography,
    this.spacing = 16.0,
    this.borderWidth = 2.0,
    this.shadow = const BrutalShadow.regular(),
    this.borderStyle = BrutalBorderStyle.solid,
    this.intensity = BrutalIntensity.regular,
    this.variant = BrutalVariant.standard,
  });

  // Tema regular por defecto
  static const BrutalTheme defaultTheme = BrutalTheme(
    colors: BrutalColors.defaultColors,
    typography: BrutalTypography.defaultTypo,
  );

  // Tema oscuro brutalista
  static const BrutalTheme darkTheme = BrutalTheme(
    colors: BrutalColors.darkColors,
    typography: BrutalTypography.defaultTypo,
    borderWidth: 3.0,
    shadow: BrutalShadow.intense(),
    intensity: BrutalIntensity.bold,
  );

  // Tema neón brutalista
  static const BrutalTheme neonTheme = BrutalTheme(
    colors: BrutalColors.neonColors,
    typography: BrutalTypography.monoTypo,
    borderWidth: 2.5,
    shadow: BrutalShadow.neon(),
    intensity: BrutalIntensity.bold,
    variant: BrutalVariant.neon,
  );

  // Tema minimalista
  static const BrutalTheme minimalTheme = BrutalTheme(
    colors: BrutalColors.monoColors,
    typography: BrutalTypography.minimalTypo,
    borderWidth: 1.0,
    shadow: BrutalShadow.subtle(),
    intensity: BrutalIntensity.subtle,
    variant: BrutalVariant.minimal,
  );

  // Tema máquina de escribir
  static const BrutalTheme typewriterTheme = BrutalTheme(
    colors: BrutalColors.monoColors,
    typography: BrutalTypography.typewriterTypo,
    borderWidth: 0.0,
    shadow: BrutalShadow.none(),
    intensity: BrutalIntensity.subtle,
    variant: BrutalVariant.typewriter,
  );

  // Nuevo tema retro (8-bit)
  static const BrutalTheme retroTheme = BrutalTheme(
    colors: BrutalColors.retroColors,
    typography: BrutalTypography.retroTypo,
    borderWidth: 3.0,
    shadow: BrutalShadow.regular(),
    borderStyle: BrutalBorderStyle.pixel,
    intensity: BrutalIntensity.bold,
    variant: BrutalVariant.pixel,
  );

  // Nuevo tema vaporwave
  static const BrutalTheme vaporwaveTheme = BrutalTheme(
    colors: BrutalColors.vaporwaveColors,
    typography: BrutalTypography.vaporwaveTypo,
    borderWidth: 2.0,
    shadow: BrutalShadow.neon(),
    borderStyle: BrutalBorderStyle.solid,
    intensity: BrutalIntensity.bold,
    variant: BrutalVariant.neon,
  );

  // Nuevo tema cyberpunk
  static const BrutalTheme cyberpunkTheme = BrutalTheme(
    colors: BrutalColors.cyberpunkColors,
    typography: BrutalTypography.cyberpunkTypo,
    borderWidth: 3.0,
    shadow: BrutalShadow.neon(),
    borderStyle: BrutalBorderStyle.rough,
    intensity: BrutalIntensity.extreme,
    variant: BrutalVariant.glitch,
  );

  // Nuevo tema construcción
  static const BrutalTheme constructionTheme = BrutalTheme(
    colors: BrutalColors.constructionColors,
    typography: BrutalTypography.constructionTypo,
    borderWidth: 4.0,
    shadow: BrutalShadow.intense(),
    borderStyle: BrutalBorderStyle.thickAndThin,
    intensity: BrutalIntensity.extreme,
    variant: BrutalVariant.standard,
  );

  static BrutalTheme of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<BrutalThemeProvider>();
    return provider?.theme ?? BrutalTheme.defaultTheme;
  }
}

/// Estilos de sombra para componentes brutalistas
class BrutalShadow {
  final Offset offset;
  final double blurRadius;
  final double spreadRadius;
  final double opacity;

  const BrutalShadow({
    required this.offset,
    this.blurRadius = 0.0,
    this.spreadRadius = 0.0,
    this.opacity = 0.3,
  });

  const BrutalShadow.none()
    : offset = Offset.zero,
      blurRadius = 0.0,
      spreadRadius = 0.0,
      opacity = 0.0;

  const BrutalShadow.subtle()
    : offset = const Offset(1.0, 1.0),
      blurRadius = 0.0,
      spreadRadius = 0.0,
      opacity = 0.2;

  const BrutalShadow.regular()
    : offset = const Offset(2.0, 2.0),
      blurRadius = 0.0,
      spreadRadius = 0.0,
      opacity = 0.3;

  const BrutalShadow.intense()
    : offset = const Offset(4.0, 4.0),
      blurRadius = 0.0,
      spreadRadius = 0.0,
      opacity = 0.5;

  const BrutalShadow.neon()
    : offset = const Offset(0.0, 0.0),
      blurRadius = 8.0,
      spreadRadius = 1.0,
      opacity = 0.8;

  BoxShadow toBoxShadow(Color color) {
    return BoxShadow(
      color: color.withOpacity(opacity),
      offset: offset,
      blurRadius: blurRadius,
      spreadRadius: spreadRadius,
    );
  }
}

/// Estilos de borde brutalistas
enum BrutalBorderStyle {
  none, // Sin borde
  solid, // Borde sólido regular
  dashed, // Borde discontinuo
  rough, // Borde irregular (simula dibujado a mano)
  double, // Borde doble
  thickAndThin, // Borde con grosor variable
  pixel, // Borde pixelado (estilo 8-bit)
}

/// Intensidad visual de los elementos brutalistas
enum BrutalIntensity {
  subtle, // Sutilmente brutalista
  regular, // Brutalista estándar
  bold, // Brutalista intenso
  extreme, // Extremadamente brutalista
}

/// Variantes estilísticas brutalistas
enum BrutalVariant {
  standard, // Brutalista estándar
  minimal, // Minimalista
  neon, // Neón con alto contraste
  pixel, // Estilo pixelado
  typewriter, // Estilo máquina de escribir
  glitch, // Estilo con efecto glitch
}

/// Provider para el tema de Brutal UI
class BrutalThemeProvider extends InheritedWidget {
  final BrutalTheme theme;

  const BrutalThemeProvider({
    super.key,
    required this.theme,
    required super.child,
  });

  @override
  bool updateShouldNotify(BrutalThemeProvider oldWidget) {
    return theme != oldWidget.theme;
  }
}

/// Widget raíz para aplicaciones Brutal UI
class BrutalApp extends StatelessWidget {
  final Widget child;
  final BrutalTheme theme;
  final String title;
  final Color color;

  const BrutalApp({
    super.key,
    required this.child,
    this.theme = BrutalTheme.defaultTheme,
    this.title = 'Brutal UI App',
    this.color = const Color(0xFF000000),
  });

  @override
  Widget build(BuildContext context) {
    return BrutalThemeProvider(
      theme: theme,
      // Usamos WidgetsApp que proporciona un Overlay sin depender de Material o Cupertino
      child: WidgetsApp(
        title: title,
        color: color,
        debugShowCheckedModeBanner: false,
        builder: (context, child) => child ?? const SizedBox(),
        // Proveemos nuestro propio controlador de navegación simplificado
        pageRouteBuilder: <T>(RouteSettings settings, WidgetBuilder builder) {
          return PageRouteBuilder<T>(
            settings: settings,
            pageBuilder: (context, _, __) => builder(context),
          );
        },
        home: child,
      ),
    );
  }
}
