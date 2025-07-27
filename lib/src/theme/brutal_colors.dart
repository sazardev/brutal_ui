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

  // ============ NUEVOS TEMAS ULTRA BRUTALES ============

  // Tema GLITCH HARDCORE - Efecto Matrix Roto
  static const BrutalColors glitchColors = BrutalColors(
    primary: Color(0xFFFF0000),
    secondary: Color(0xFF00FFFF),
    background: Color(0xFF000000),
    surface: Color(0xFF1A0000),
    text: Color(0xFFFFFFFF),
    textLight: Color(0xFFFF6666),
    border: Color(0xFFFF0000),
    error: Color(0xFFFFFF00),
    accent: Color(0xFF00FFFF),
    success: Color(0xFF00FF00),
  );

  // Tema INDUSTRIAL APOCALIPSIS - Fábrica Abandonada
  static const BrutalColors industrialColors = BrutalColors(
    primary: Color(0xFF4A4A4A),
    secondary: Color(0xFFFF6600),
    background: Color(0xFF1A1A1A),
    surface: Color(0xFF2D2D2D),
    text: Color(0xFFFFFFFF),
    textLight: Color(0xFFAAAAAA),
    border: Color(0xFF4A4A4A),
    error: Color(0xFFFF3300),
    accent: Color(0xFFFF6600),
    success: Color(0xFF66FF66),
  );

  // Tema BLOOD METAL - Guerra Nuclear
  static const BrutalColors bloodColors = BrutalColors(
    primary: Color(0xFF8B0000),
    secondary: Color(0xFF2F4F4F),
    background: Color(0xFF000000),
    surface: Color(0xFF191919),
    text: Color(0xFFDC143C),
    textLight: Color(0xFF800000),
    border: Color(0xFF8B0000),
    error: Color(0xFFFF0000),
    accent: Color(0xFFDC143C),
    success: Color(0xFF228B22),
  );

  // Tema TOXIC WASTE - Residuos Radiactivos
  static const BrutalColors toxicColors = BrutalColors(
    primary: Color(0xFF32CD32),
    secondary: Color(0xFFADFF2F),
    background: Color(0xFF001100),
    surface: Color(0xFF002200),
    text: Color(0xFF32CD32),
    textLight: Color(0xFF228B22),
    border: Color(0xFF32CD32),
    error: Color(0xFFFF4500),
    accent: Color(0xFFADFF2F),
    success: Color(0xFF7FFF00),
  );

  // Tema FIRE APOCALYPSE - Infierno en la Tierra
  static const BrutalColors fireColors = BrutalColors(
    primary: Color(0xFFFF4500),
    secondary: Color(0xFFFFD700),
    background: Color(0xFF330000),
    surface: Color(0xFF4A0000),
    text: Color(0xFFFFFFFF),
    textLight: Color(0xFFFFCC99),
    border: Color(0xFFFF4500),
    error: Color(0xFFFF0000),
    accent: Color(0xFFFFD700),
    success: Color(0xFF00FF00),
  );

  // Tema ICE COLD BRUTAL - Apocalipsis Congelado
  static const BrutalColors iceColors = BrutalColors(
    primary: Color(0xFF00BFFF),
    secondary: Color(0xFF87CEEB),
    background: Color(0xFF000033),
    surface: Color(0xFF001144),
    text: Color(0xFFFFFFFF),
    textLight: Color(0xFFB0E0E6),
    border: Color(0xFF00BFFF),
    error: Color(0xFFFF69B4),
    accent: Color(0xFF87CEEB),
    success: Color(0xFF00FF7F),
  );

  // Tema PURPLE RAGE - Furia Violeta
  static const BrutalColors purpleRageColors = BrutalColors(
    primary: Color(0xFF9932CC),
    secondary: Color(0xFFDA70D6),
    background: Color(0xFF2F002F),
    surface: Color(0xFF4B0082),
    text: Color(0xFFFFFFFF),
    textLight: Color(0xFFDDA0DD),
    border: Color(0xFF9932CC),
    error: Color(0xFFFF1493),
    accent: Color(0xFFDA70D6),
    success: Color(0xFF7FFF00),
  );

  // Tema ACID TRIP - Viaje Ácido
  static const BrutalColors acidColors = BrutalColors(
    primary: Color(0xFFFFFF00),
    secondary: Color(0xFFFF00FF),
    background: Color(0xFF001100),
    surface: Color(0xFF003300),
    text: Color(0xFFFFFF00),
    textLight: Color(0xFFCCCC00),
    border: Color(0xFFFFFF00),
    error: Color(0xFFFF0099),
    accent: Color(0xFFFF00FF),
    success: Color(0xFF99FF00),
  );

  // Tema SYNTHWAVE OVERDRIVE - Retro Futurista Extremo
  static const BrutalColors synthwaveColors = BrutalColors(
    primary: Color(0xFFFF0080),
    secondary: Color(0xFF00FFFF),
    background: Color(0xFF0A0A0F),
    surface: Color(0xFF1A1A2E),
    text: Color(0xFFFF0080),
    textLight: Color(0xFF9900CC),
    border: Color(0xFFFF0080),
    error: Color(0xFFFF3366),
    accent: Color(0xFF00FFFF),
    success: Color(0xFF00FF99),
  );

  // Tema TERMINAL HACKER - Matrix Terminal
  static const BrutalColors terminalColors = BrutalColors(
    primary: Color(0xFF00FF00),
    secondary: Color(0xFF008000),
    background: Color(0xFF000000),
    surface: Color(0xFF001100),
    text: Color(0xFF00FF00),
    textLight: Color(0xFF008800),
    border: Color(0xFF00FF00),
    error: Color(0xFFFF0000),
    accent: Color(0xFF40FF40),
    success: Color(0xFF80FF80),
  );

  // Tema NEON PUNK - Cyberpunk Rosa
  static const BrutalColors neonPunkColors = BrutalColors(
    primary: Color(0xFFFF007F),
    secondary: Color(0xFF7F00FF),
    background: Color(0xFF0F0F0F),
    surface: Color(0xFF1F1F1F),
    text: Color(0xFFFF007F),
    textLight: Color(0xFFBB0055),
    border: Color(0xFFFF007F),
    error: Color(0xFFFF3300),
    accent: Color(0xFF7F00FF),
    success: Color(0xFF00FF7F),
  );

  // Tema BLACKOUT - Total Darkness
  static const BrutalColors blackoutColors = BrutalColors(
    primary: Color(0xFF333333),
    secondary: Color(0xFF666666),
    background: Color(0xFF000000),
    surface: Color(0xFF111111),
    text: Color(0xFF333333),
    textLight: Color(0xFF222222),
    border: Color(0xFF333333),
    error: Color(0xFF440000),
    accent: Color(0xFF666666),
    success: Color(0xFF004400),
  );

  // Tema CHROME BRUTAL - Metal Industrial
  static const BrutalColors chromeColors = BrutalColors(
    primary: Color(0xFFC0C0C0),
    secondary: Color(0xFF808080),
    background: Color(0xFF2F2F2F),
    surface: Color(0xFF404040),
    text: Color(0xFFFFFFFF),
    textLight: Color(0xFFC0C0C0),
    border: Color(0xFFC0C0C0),
    error: Color(0xFFFF4444),
    accent: Color(0xFF808080),
    success: Color(0xFF44FF44),
  );

  // Tema VOLTAGE - Electricidad Pura
  static const BrutalColors voltageColors = BrutalColors(
    primary: Color(0xFFFFFF00),
    secondary: Color(0xFF0080FF),
    background: Color(0xFF000020),
    surface: Color(0xFF000040),
    text: Color(0xFFFFFF00),
    textLight: Color(0xFFCCCC00),
    border: Color(0xFFFFFF00),
    error: Color(0xFFFF0040),
    accent: Color(0xFF0080FF),
    success: Color(0xFF80FF00),
  );

  // Tema RUST APOCALYPSE - Óxido y Destrucción
  static const BrutalColors rustColors = BrutalColors(
    primary: Color(0xFFCD853F),
    secondary: Color(0xFFA0522D),
    background: Color(0xFF2F1B14),
    surface: Color(0xFF5D4037),
    text: Color(0xFFFFE4B5),
    textLight: Color(0xFFD2B48C),
    border: Color(0xFFCD853F),
    error: Color(0xFFB22222),
    accent: Color(0xFFA0522D),
    success: Color(0xFF8FBC8F),
  );

  // ============ NUEVOS TEMAS MEGA BRUTALES ============

  // Tema VOID BLACK - Vacío Absoluto
  static const BrutalColors voidColors = BrutalColors(
    primary: Color(0xFF1A0D2E),
    secondary: Color(0xFF16213E),
    background: Color(0xFF000000),
    surface: Color(0xFF0F0F0F),
    text: Color(0xFF6B5B95),
    textLight: Color(0xFF3E2723),
    border: Color(0xFF1A0D2E),
    error: Color(0xFF5C0011),
    accent: Color(0xFF16213E),
    success: Color(0xFF1B4332),
  );

  // Tema NEON HELL - Infierno Neón
  static const BrutalColors neonHellColors = BrutalColors(
    primary: Color(0xFFFF073A),
    secondary: Color(0xFF39FF14),
    background: Color(0xFF0A0A0A),
    surface: Color(0xFF1A1A1A),
    text: Color(0xFFFF073A),
    textLight: Color(0xFFFF6B6B),
    border: Color(0xFF39FF14),
    error: Color(0xFFFF0040),
    accent: Color(0xFFFF1493),
    success: Color(0xFF39FF14),
  );

  // Tema CYBER GORE - Gore Cibernético
  static const BrutalColors cyberGoreColors = BrutalColors(
    primary: Color(0xFF8B0000),
    secondary: Color(0xFF00CED1),
    background: Color(0xFF1C1C1C),
    surface: Color(0xFF2A0A0A),
    text: Color(0xFFFFFFFF),
    textLight: Color(0xFFB0C4DE),
    border: Color(0xFF8B0000),
    error: Color(0xFFDC143C),
    accent: Color(0xFF00CED1),
    success: Color(0xFF32CD32),
  );

  // Tema MATRIX OVERLOAD - Sobrecarga Matrix
  static const BrutalColors matrixOverloadColors = BrutalColors(
    primary: Color(0xFF00FF41),
    secondary: Color(0xFF008F11),
    background: Color(0xFF000000),
    surface: Color(0xFF003300),
    text: Color(0xFF00FF41),
    textLight: Color(0xFF008F11),
    border: Color(0xFF00FF41),
    error: Color(0xFFFF0033),
    accent: Color(0xFFFFFF00),
    success: Color(0xFF00FF41),
  );

  // Tema DIGITAL DECAY - Decadencia Digital
  static const BrutalColors digitalDecayColors = BrutalColors(
    primary: Color(0xFF4A148C),
    secondary: Color(0xFF7B1FA2),
    background: Color(0xFF0D0D0D),
    surface: Color(0xFF1A1A1A),
    text: Color(0xFFE1BEE7),
    textLight: Color(0xFF9C27B0),
    border: Color(0xFF4A148C),
    error: Color(0xFFFF5722),
    accent: Color(0xFF7B1FA2),
    success: Color(0xFF4CAF50),
  );

  // Tema URBAN WARFARE - Guerra Urbana
  static const BrutalColors urbanWarfareColors = BrutalColors(
    primary: Color(0xFF424242),
    secondary: Color(0xFF757575),
    background: Color(0xFF212121),
    surface: Color(0xFF303030),
    text: Color(0xFFEEEEEE),
    textLight: Color(0xFFBDBDBD),
    border: Color(0xFF424242),
    error: Color(0xFFE53935),
    accent: Color(0xFFFF5722),
    success: Color(0xFF388E3C),
  );

  // Tema TOXIC NEON - Neón Tóxico
  static const BrutalColors toxicNeonColors = BrutalColors(
    primary: Color(0xFFCCFF00),
    secondary: Color(0xFF76FF03),
    background: Color(0xFF0D1B0D),
    surface: Color(0xFF1B5E20),
    text: Color(0xFFCCFF00),
    textLight: Color(0xFF8BC34A),
    border: Color(0xFF76FF03),
    error: Color(0xFFFF1744),
    accent: Color(0xFFEEFF41),
    success: Color(0xFF64DD17),
  );

  // Tema CHROME PUNK - Punk Cromado
  static const BrutalColors chromePunkColors = BrutalColors(
    primary: Color(0xFFE0E0E0),
    secondary: Color(0xFFBDBDBD),
    background: Color(0xFF121212),
    surface: Color(0xFF1E1E1E),
    text: Color(0xFFFFFFFF),
    textLight: Color(0xFF9E9E9E),
    border: Color(0xFFE0E0E0),
    error: Color(0xFFFF1744),
    accent: Color(0xFF03DAC6),
    success: Color(0xFF00E676),
  );

  // Tema BLOOD RAIN - Lluvia de Sangre
  static const BrutalColors bloodRainColors = BrutalColors(
    primary: Color(0xFF7F0000),
    secondary: Color(0xFFB71C1C),
    background: Color(0xFF0D0D0D),
    surface: Color(0xFF1A0000),
    text: Color(0xFFFFCDD2),
    textLight: Color(0xFFEF5350),
    border: Color(0xFF7F0000),
    error: Color(0xFFFF1744),
    accent: Color(0xFFD32F2F),
    success: Color(0xFF388E3C),
  );

  // Tema LASER GRID - Grilla Láser
  static const BrutalColors laserGridColors = BrutalColors(
    primary: Color(0xFF00E5FF),
    secondary: Color(0xFF0091EA),
    background: Color(0xFF000a0f),
    surface: Color(0xFF001e2b),
    text: Color(0xFF00E5FF),
    textLight: Color(0xFF40C4FF),
    border: Color(0xFF00E5FF),
    error: Color(0xFFFF1744),
    accent: Color(0xFF18FFFF),
    success: Color(0xFF00E676),
  );

  // Tema HOLOGRAM - Holograma
  static const BrutalColors hologramColors = BrutalColors(
    primary: Color(0xFF9C27B0),
    secondary: Color(0xFF673AB7),
    background: Color(0xFF000004),
    surface: Color(0xFF0A000E),
    text: Color(0xFFE1BEE7),
    textLight: Color(0xFFCE93D8),
    border: Color(0xFF9C27B0),
    error: Color(0xFFFF1744),
    accent: Color(0xFF7C4DFF),
    success: Color(0xFF00E676),
  );

  // Tema QUANTUM CHAOS - Caos Cuántico
  static const BrutalColors quantumChaosColors = BrutalColors(
    primary: Color(0xFFFF6EC7),
    secondary: Color(0xFF9C27B0),
    background: Color(0xFF0A0A0A),
    surface: Color(0xFF1A0F1A),
    text: Color(0xFFFF6EC7),
    textLight: Color(0xFFE91E63),
    border: Color(0xFF9C27B0),
    error: Color(0xFFFF1744),
    accent: Color(0xFF7C4DFF),
    success: Color(0xFF00E676),
  );

  // Tema PLASMA STORM - Tormenta de Plasma
  static const BrutalColors plasmaStormColors = BrutalColors(
    primary: Color(0xFFFFEB3B),
    secondary: Color(0xFFFF9800),
    background: Color(0xFF0F0F00),
    surface: Color(0xFF1A1A00),
    text: Color(0xFFFFEB3B),
    textLight: Color(0xFFFFC107),
    border: Color(0xFFFF9800),
    error: Color(0xFFFF1744),
    accent: Color(0xFFFFC107),
    success: Color(0xFF8BC34A),
  );

  // Tema NIGHTMARE - Pesadilla
  static const BrutalColors nightmareColors = BrutalColors(
    primary: Color(0xFF263238),
    secondary: Color(0xFF37474F),
    background: Color(0xFF000000),
    surface: Color(0xFF0F0F0F),
    text: Color(0xFF607D8B),
    textLight: Color(0xFF455A64),
    border: Color(0xFF263238),
    error: Color(0xFFB71C1C),
    accent: Color(0xFF37474F),
    success: Color(0xFF1B5E20),
  );

  // Tema SKULL CRUSHER - Triturador de Cráneos
  static const BrutalColors skullCrusherColors = BrutalColors(
    primary: Color(0xFFEEEEEE),
    secondary: Color(0xFF424242),
    background: Color(0xFF000000),
    surface: Color(0xFF1A1A1A),
    text: Color(0xFFEEEEEE),
    textLight: Color(0xFF9E9E9E),
    border: Color(0xFFEEEEEE),
    error: Color(0xFFE53935),
    accent: Color(0xFF616161),
    success: Color(0xFF388E3C),
  );
}
