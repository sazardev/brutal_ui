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

  // Tema retro (estilo de 8-bit)
  static const BrutalColors retroColors = BrutalColors(
    primary: Color(0xFF4A6CD4), // Azul retro
    secondary: Color(0xFFFFD800), // Amarillo brillante
    background: Color(0xFF181B29), // Azul oscuro
    surface: Color(0xFF262A40), // Azul medio
    text: Color(0xFFFFFFFF), // Blanco
    textLight: Color(0xFF8E93B4), // Azul claro
    border: Color(0xFF4A6CD4), // Azul retro
    error: Color(0xFFD62246), // Rojo retro
    accent: Color(0xFFFF6B97), // Rosa retro
    success: Color(0xFF6ECB63), // Verde retro
  );

  // Tema vaporwave
  static const BrutalColors vaporwaveColors = BrutalColors(
    primary: Color(0xFFFF6AD5), // Rosa brillante
    secondary: Color(0xFF26D9E3), // Turquesa
    background: Color(0xFF03012F), // Azul oscuro
    surface: Color(0xFF170B43), // Morado oscuro
    text: Color(0xFFFFFFFF), // Blanco
    textLight: Color(0xFFCDBAFA), // Morado claro
    border: Color(0xFFFF6AD5), // Rosa brillante
    error: Color(0xFFEE4B2B), // Rojo brillante
    accent: Color(0xFF8957FD), // Morado
    success: Color(0xFF26D9E3), // Turquesa
  );

  // Tema cyberpunk
  static const BrutalColors cyberpunkColors = BrutalColors(
    primary: Color(0xFFFFF600), // Amarillo brillante
    secondary: Color(0xFF00E6CF), // Turquesa brillante
    background: Color(0xFF0D0221), // Negro azulado
    surface: Color(0xFF1A1627), // Morado oscuro
    text: Color(0xFFFFF600), // Amarillo brillante
    textLight: Color(0xFF9F73FB), // Morado claro
    border: Color(0xFF00E6CF), // Turquesa brillante
    error: Color(0xFFFF003C), // Rojo neón
    accent: Color(0xFFFF00A0), // Rosa neón
    success: Color(0xFF3DF56C), // Verde neón
  );

  // Tema construcción (estilo de obra)
  static const BrutalColors constructionColors = BrutalColors(
    primary: Color(0xFFFFD100), // Amarillo construcción
    secondary: Color(0xFF242424), // Casi negro
    background: Color(0xFFE8E8E8), // Gris claro
    surface: Color(0xFFFFFFFF), // Blanco
    text: Color(0xFF000000), // Negro
    textLight: Color(0xFF6B6B6B), // Gris
    border: Color(0xFF000000), // Negro
    error: Color(0xFFEB0000), // Rojo
    accent: Color(0xFFFFD100), // Amarillo construcción
    success: Color(0xFF00852F), // Verde oscuro
  );
}
