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

  // ============ NUEVOS TEMAS ULTRA BRUTALES ============

  // Tema GLITCH HARDCORE - Matrix Destrozado
  static const BrutalTheme glitchTheme = BrutalTheme(
    colors: BrutalColors.glitchColors,
    typography: BrutalTypography.monoTypo,
    borderWidth: 1.0,
    shadow: BrutalShadow.glitch(),
    borderStyle: BrutalBorderStyle.broken,
    intensity: BrutalIntensity.extreme,
    variant: BrutalVariant.glitch,
  );

  // Tema INDUSTRIAL APOCALIPSIS - Fábrica del Futuro
  static const BrutalTheme industrialTheme = BrutalTheme(
    colors: BrutalColors.industrialColors,
    typography: BrutalTypography.industrialTypo,
    borderWidth: 5.0,
    shadow: BrutalShadow.industrial(),
    borderStyle: BrutalBorderStyle.riveted,
    intensity: BrutalIntensity.extreme,
    variant: BrutalVariant.industrial,
  );

  // Tema BLOOD METAL - Guerra Total
  static const BrutalTheme bloodTheme = BrutalTheme(
    colors: BrutalColors.bloodColors,
    typography: BrutalTypography.aggressiveTypo,
    borderWidth: 3.0,
    shadow: BrutalShadow.bloodSplatter(),
    borderStyle: BrutalBorderStyle.torn,
    intensity: BrutalIntensity.extreme,
    variant: BrutalVariant.destruction,
  );

  // Tema TOXIC WASTE - Residuos Nucleares
  static const BrutalTheme toxicTheme = BrutalTheme(
    colors: BrutalColors.toxicColors,
    typography: BrutalTypography.radioactiveTypo,
    borderWidth: 2.0,
    shadow: BrutalShadow.radioactive(),
    borderStyle: BrutalBorderStyle.corroded,
    intensity: BrutalIntensity.extreme,
    variant: BrutalVariant.radioactive,
  );

  // Tema FIRE APOCALYPSE - Infierno
  static const BrutalTheme fireTheme = BrutalTheme(
    colors: BrutalColors.fireColors,
    typography: BrutalTypography.burnedTypo,
    borderWidth: 4.0,
    shadow: BrutalShadow.flaming(),
    borderStyle: BrutalBorderStyle.burned,
    intensity: BrutalIntensity.extreme,
    variant: BrutalVariant.apocalyptic,
  );

  // Tema ICE COLD BRUTAL - Era Glacial
  static const BrutalTheme iceTheme = BrutalTheme(
    colors: BrutalColors.iceColors,
    typography: BrutalTypography.frozenTypo,
    borderWidth: 3.0,
    shadow: BrutalShadow.frozen(),
    borderStyle: BrutalBorderStyle.icicle,
    intensity: BrutalIntensity.bold,
    variant: BrutalVariant.frozen,
  );

  // Tema PURPLE RAGE - Furia Cósmica
  static const BrutalTheme purpleRageTheme = BrutalTheme(
    colors: BrutalColors.purpleRageColors,
    typography: BrutalTypography.cosmicTypo,
    borderWidth: 3.0,
    shadow: BrutalShadow.cosmic(),
    borderStyle: BrutalBorderStyle.jagged,
    intensity: BrutalIntensity.extreme,
    variant: BrutalVariant.cosmic,
  );

  // Tema ACID TRIP - Psicodélico Extremo
  static const BrutalTheme acidTheme = BrutalTheme(
    colors: BrutalColors.acidColors,
    typography: BrutalTypography.psychedelicTypo,
    borderWidth: 2.0,
    shadow: BrutalShadow.psychedelic(),
    borderStyle: BrutalBorderStyle.wavy,
    intensity: BrutalIntensity.extreme,
    variant: BrutalVariant.psychedelic,
  );

  // Tema SYNTHWAVE OVERDRIVE - Retro Futurista Extremo
  static const BrutalTheme synthwaveTheme = BrutalTheme(
    colors: BrutalColors.synthwaveColors,
    typography: BrutalTypography.synthwaveTypo,
    borderWidth: 2.0,
    shadow: BrutalShadow.neonGrid(),
    borderStyle: BrutalBorderStyle.grid,
    intensity: BrutalIntensity.bold,
    variant: BrutalVariant.synthwave,
  );

  // Tema TERMINAL HACKER - Matrix Verde
  static const BrutalTheme terminalTheme = BrutalTheme(
    colors: BrutalColors.terminalColors,
    typography: BrutalTypography.terminalTypo,
    borderWidth: 1.0,
    shadow: BrutalShadow.terminal(),
    borderStyle: BrutalBorderStyle.ascii,
    intensity: BrutalIntensity.bold,
    variant: BrutalVariant.terminal,
  );

  // Tema NEON PUNK - Cyberpunk Rosa
  static const BrutalTheme neonPunkTheme = BrutalTheme(
    colors: BrutalColors.neonPunkColors,
    typography: BrutalTypography.punkTypo,
    borderWidth: 3.0,
    shadow: BrutalShadow.neonPunk(),
    borderStyle: BrutalBorderStyle.spiked,
    intensity: BrutalIntensity.extreme,
    variant: BrutalVariant.punk,
  );

  // Tema BLACKOUT - Oscuridad Total
  static const BrutalTheme blackoutTheme = BrutalTheme(
    colors: BrutalColors.blackoutColors,
    typography: BrutalTypography.shadowTypo,
    borderWidth: 1.0,
    shadow: BrutalShadow.none(),
    borderStyle: BrutalBorderStyle.hidden,
    intensity: BrutalIntensity.subtle,
    variant: BrutalVariant.stealth,
  );

  // Tema CHROME BRUTAL - Metal Industrial
  static const BrutalTheme chromeTheme = BrutalTheme(
    colors: BrutalColors.chromeColors,
    typography: BrutalTypography.metallicTypo,
    borderWidth: 4.0,
    shadow: BrutalShadow.metallic(),
    borderStyle: BrutalBorderStyle.beveled,
    intensity: BrutalIntensity.bold,
    variant: BrutalVariant.metallic,
  );

  // Tema VOLTAGE - Electricidad Pura
  static const BrutalTheme voltageTheme = BrutalTheme(
    colors: BrutalColors.voltageColors,
    typography: BrutalTypography.electricTypo,
    borderWidth: 2.0,
    shadow: BrutalShadow.electric(),
    borderStyle: BrutalBorderStyle.lightning,
    intensity: BrutalIntensity.extreme,
    variant: BrutalVariant.electric,
  );

  // Tema RUST APOCALYPSE - Óxido y Destrucción
  static const BrutalTheme rustTheme = BrutalTheme(
    colors: BrutalColors.rustColors,
    typography: BrutalTypography.rustedTypo,
    borderWidth: 3.0,
    shadow: BrutalShadow.rusted(),
    borderStyle: BrutalBorderStyle.rusted,
    intensity: BrutalIntensity.bold,
    variant: BrutalVariant.rusted,
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

  // ============ NUEVAS SOMBRAS ULTRA BRUTALES ============

  const BrutalShadow.glitch()
    : offset = const Offset(3.0, -2.0),
      blurRadius = 2.0,
      spreadRadius = 0.0,
      opacity = 0.6;

  const BrutalShadow.industrial()
    : offset = const Offset(6.0, 6.0),
      blurRadius = 0.0,
      spreadRadius = 1.0,
      opacity = 0.7;

  const BrutalShadow.bloodSplatter()
    : offset = const Offset(5.0, 3.0),
      blurRadius = 3.0,
      spreadRadius = 2.0,
      opacity = 0.6;

  const BrutalShadow.radioactive()
    : offset = const Offset(0.0, 0.0),
      blurRadius = 12.0,
      spreadRadius = 3.0,
      opacity = 0.5;

  const BrutalShadow.flaming()
    : offset = const Offset(2.0, -4.0),
      blurRadius = 15.0,
      spreadRadius = 5.0,
      opacity = 0.7;

  const BrutalShadow.frozen()
    : offset = const Offset(3.0, 8.0),
      blurRadius = 6.0,
      spreadRadius = 0.0,
      opacity = 0.4;

  const BrutalShadow.cosmic()
    : offset = const Offset(0.0, 0.0),
      blurRadius = 20.0,
      spreadRadius = 8.0,
      opacity = 0.6;

  const BrutalShadow.psychedelic()
    : offset = const Offset(4.0, 4.0),
      blurRadius = 10.0,
      spreadRadius = 3.0,
      opacity = 0.8;

  const BrutalShadow.neonGrid()
    : offset = const Offset(0.0, 0.0),
      blurRadius = 5.0,
      spreadRadius = 1.0,
      opacity = 0.9;

  const BrutalShadow.terminal()
    : offset = const Offset(1.0, 1.0),
      blurRadius = 3.0,
      spreadRadius = 0.0,
      opacity = 0.5;

  const BrutalShadow.neonPunk()
    : offset = const Offset(0.0, 0.0),
      blurRadius = 15.0,
      spreadRadius = 5.0,
      opacity = 0.9;

  const BrutalShadow.metallic()
    : offset = const Offset(8.0, 8.0),
      blurRadius = 0.0,
      spreadRadius = 0.0,
      opacity = 0.3;

  const BrutalShadow.electric()
    : offset = const Offset(0.0, 0.0),
      blurRadius = 25.0,
      spreadRadius = 10.0,
      opacity = 0.8;

  const BrutalShadow.rusted()
    : offset = const Offset(4.0, 4.0),
      blurRadius = 2.0,
      spreadRadius = 1.0,
      opacity = 0.4;

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
  // ============ NUEVOS ESTILOS ULTRA BRUTALES ============
  broken, // Borde roto con efecto glitch
  riveted, // Borde con remaches industriales
  torn, // Borde desgarrado
  corroded, // Borde corroído
  burned, // Borde quemado
  icicle, // Borde con efecto hielo
  jagged, // Borde dentado agresivo
  wavy, // Borde ondulado psicodélico
  grid, // Borde con patrón de grilla
  ascii, // Borde con caracteres ASCII
  spiked, // Borde con pinchos
  hidden, // Borde oculto/invisible
  beveled, // Borde biselado metálico
  lightning, // Borde con efecto rayo
  rusted, // Borde oxidado
  shattered, // Borde fragmentado
  melted, // Borde derretido
  twisted, // Borde retorcido
  explosive, // Borde explosivo
  magnetic, // Borde magnético
}

/// Intensidad visual de los elementos brutalistas
enum BrutalIntensity {
  subtle, // Sutilmente brutalista
  regular, // Brutalista estándar
  bold, // Brutalista intenso
  extreme, // Extremadamente brutalista
  // ============ NUEVAS INTENSIDADES EXTREMAS ============
  apocalyptic, // Intensidad apocalíptica
  nuclear, // Intensidad nuclear
  cosmic, // Intensidad cósmica
  volcanic, // Intensidad volcánica
  hurricane, // Intensidad de huracán
}

/// Variantes estilísticas brutalistas
enum BrutalVariant {
  standard, // Brutalista estándar
  minimal, // Minimalista
  neon, // Neón con alto contraste
  pixel, // Estilo pixelado
  typewriter, // Estilo máquina de escribir
  glitch, // Estilo con efecto glitch
  // ============ NUEVAS VARIANTES ULTRA BRUTALES ============
  industrial, // Estilo industrial pesado
  destruction, // Estilo destructivo
  radioactive, // Estilo radioactivo
  apocalyptic, // Estilo apocalíptico
  frozen, // Estilo congelado
  cosmic, // Estilo cósmico
  psychedelic, // Estilo psicodélico
  synthwave, // Estilo synthwave
  terminal, // Estilo terminal
  punk, // Estilo punk agresivo
  stealth, // Estilo sigiloso
  metallic, // Estilo metálico
  electric, // Estilo eléctrico
  rusted, // Estilo oxidado
  biomechanical, // Estilo biomecánico
  digital, // Estilo digital
  analog, // Estilo analógico
  holographic, // Estilo holográfico
  quantum, // Estilo cuántico
  tribal, // Estilo tribal
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
