import 'dart:ui';

/// Define los colores básicos para Brutal UI.
class BrutalColors {
  final Color primary;
  final Color secondary;
  final Color background;
  final Color surface;
  final Color text;
  final Color textLight;
  final Color border;
  final Color error;
  final Color accent; // Añadimos color acento
  final Color success; // Color para estados de éxito

  const BrutalColors({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.surface,
    required this.text,
    required this.border,
    required this.error,
    required this.textLight,
    required this.accent,
    required this.success,
  });

  // Colores estándar (blanco y negro)
  static const BrutalColors defaultColors = BrutalColors(
    primary: Color(0xFF000000),
    secondary: Color(0xFF333333),
    background: Color(0xFFFFFFFF),
    surface: Color(0xFFF0F0F0),
    text: Color(0xFF000000),
    textLight: Color(0xFF999999),
    border: Color(0xFF000000),
    error: Color(0xFFAA0000),
    accent: Color(0xFF0044AA),
    success: Color(0xFF006600),
  );

  // Tema oscuro
  static const BrutalColors darkColors = BrutalColors(
    primary: Color(0xFFFFFFFF),
    secondary: Color(0xFFCCCCCC),
    background: Color(0xFF121212),
    surface: Color(0xFF222222),
    text: Color(0xFFFFFFFF),
    textLight: Color(0xFF999999),
    border: Color(0xFFFFFFFF),
    error: Color(0xFFFF5555),
    accent: Color(0xFF55AAFF),
    success: Color(0xFF55AA55),
  );

  // Tema neón
  static const BrutalColors neonColors = BrutalColors(
    primary: Color(0xFF00FF66),
    secondary: Color(0xFFFF00FF),
    background: Color(0xFF000000),
    surface: Color(0xFF111111),
    text: Color(0xFF00FF66),
    textLight: Color(0xFF00AA44),
    border: Color(0xFF00FF66),
    error: Color(0xFFFF0055),
    accent: Color(0xFFFF00FF),
    success: Color(0xFF00FFAA),
  );

  // Tema monocromático
  static const BrutalColors monoColors = BrutalColors(
    primary: Color(0xFF000000),
    secondary: Color(0xFF333333),
    background: Color(0xFFFFFFFF),
    surface: Color(0xFFFFFFFF),
    text: Color(0xFF000000),
    textLight: Color(0xFF666666),
    border: Color(0xFF000000),
    error: Color(0xFF000000),
    accent: Color(0xFF000000),
    success: Color(0xFF000000),
  );
}
