import 'package:flutter/widgets.dart';

/// Define la tipografía para Brutal UI.
class BrutalTypography {
  final TextStyle heading1;
  final TextStyle heading2;
  final TextStyle heading3;
  final TextStyle body;
  final TextStyle caption;
  final TextStyle button;
  final TextStyle monospace; // Añadimos estilo monoespaciado
  final TextStyle display; // Estilo para textos muy grandes y llamativos

  const BrutalTypography({
    required this.heading1,
    required this.heading2,
    required this.heading3,
    required this.body,
    required this.caption,
    required this.button,
    required this.monospace,
    required this.display,
  });

  // Tipografía brutalista clásica
  static const BrutalTypography defaultTypo = BrutalTypography(
    heading1: TextStyle(
      fontFamily: 'Arial',
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      height: 1.2,
      letterSpacing: -0.5,
    ),
    heading2: TextStyle(
      fontFamily: 'Arial',
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      height: 1.3,
    ),
    heading3: TextStyle(
      fontFamily: 'Arial',
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      height: 1.4,
    ),
    body: TextStyle(
      fontFamily: 'Arial',
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      height: 1.5,
    ),
    caption: TextStyle(
      fontFamily: 'Arial',
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      height: 1.4,
    ),
    button: TextStyle(
      fontFamily: 'Arial',
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      height: 1.0,
    ),
    monospace: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 16.0,
      height: 1.5,
    ),
    display: TextStyle(
      fontFamily: 'Arial',
      fontSize: 48.0,
      fontWeight: FontWeight.bold,
      height: 1.1,
      letterSpacing: -1.0,
    ),
  );

  // Tipografía monoespaciada para temas técnicos
  static const BrutalTypography monoTypo = BrutalTypography(
    heading1: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      height: 1.2,
    ),
    heading2: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      height: 1.3,
    ),
    heading3: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      height: 1.4,
    ),
    body: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      height: 1.5,
    ),
    caption: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      height: 1.4,
    ),
    button: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      height: 1.0,
    ),
    monospace: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 16.0,
      height: 1.5,
    ),
    display: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 48.0,
      fontWeight: FontWeight.bold,
      height: 1.1,
    ),
  );

  // Tipografía minimalista
  static const BrutalTypography minimalTypo = BrutalTypography(
    heading1: TextStyle(
      fontFamily: 'Helvetica',
      fontSize: 28.0,
      fontWeight: FontWeight.normal,
      height: 1.2,
      letterSpacing: 0.5,
    ),
    heading2: TextStyle(
      fontFamily: 'Helvetica',
      fontSize: 22.0,
      fontWeight: FontWeight.normal,
      height: 1.3,
      letterSpacing: 0.25,
    ),
    heading3: TextStyle(
      fontFamily: 'Helvetica',
      fontSize: 18.0,
      fontWeight: FontWeight.normal,
      height: 1.4,
    ),
    body: TextStyle(
      fontFamily: 'Helvetica',
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      height: 1.5,
    ),
    caption: TextStyle(
      fontFamily: 'Helvetica',
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      height: 1.4,
    ),
    button: TextStyle(
      fontFamily: 'Helvetica',
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      height: 1.0,
      letterSpacing: 0.5,
    ),
    monospace: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 16.0,
      height: 1.5,
    ),
    display: TextStyle(
      fontFamily: 'Helvetica',
      fontSize: 42.0,
      fontWeight: FontWeight.normal,
      height: 1.1,
      letterSpacing: 1.0,
    ),
  );

  // Tipografía máquina de escribir
  static const BrutalTypography typewriterTypo = BrutalTypography(
    heading1: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 28.0,
      fontWeight: FontWeight.normal,
      height: 1.3,
    ),
    heading2: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 24.0,
      fontWeight: FontWeight.normal,
      height: 1.3,
      decoration: TextDecoration.underline,
    ),
    heading3: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 20.0,
      fontWeight: FontWeight.normal,
      height: 1.4,
    ),
    body: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      height: 1.6,
    ),
    caption: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      height: 1.4,
      fontStyle: FontStyle.italic,
    ),
    button: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      height: 1.0,
    ),
    monospace: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 16.0,
      height: 1.5,
    ),
    display: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 36.0,
      fontWeight: FontWeight.bold,
      height: 1.2,
      decoration: TextDecoration.underline,
    ),
  );

  // Tipografía retro (estilo de 8-bit)
  static const BrutalTypography retroTypo = BrutalTypography(
    heading1: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      height: 1.0,
      letterSpacing: 1.0,
    ),
    heading2: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 26.0,
      fontWeight: FontWeight.bold,
      height: 1.0,
      letterSpacing: 0.5,
    ),
    heading3: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      height: 1.0,
    ),
    body: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      height: 1.2,
      letterSpacing: 0.5,
    ),
    caption: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      height: 1.0,
    ),
    button: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      height: 1.0,
    ),
    monospace: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      height: 1.0,
    ),
    display: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 40.0,
      fontWeight: FontWeight.bold,
      height: 1.0,
      letterSpacing: 2.0,
    ),
  );

  // Tipografía vaporwave
  static const BrutalTypography vaporwaveTypo = BrutalTypography(
    heading1: TextStyle(
      fontFamily: 'Arial',
      fontSize: 36.0,
      fontWeight: FontWeight.bold,
      height: 1.0,
      letterSpacing: 3.0,
    ),
    heading2: TextStyle(
      fontFamily: 'Arial',
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
      height: 1.0,
      letterSpacing: 2.0,
    ),
    heading3: TextStyle(
      fontFamily: 'Arial',
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
      height: 1.0,
      letterSpacing: 1.5,
    ),
    body: TextStyle(
      fontFamily: 'Arial',
      fontSize: 18.0,
      fontWeight: FontWeight.normal,
      height: 1.2,
      letterSpacing: 0.8,
    ),
    caption: TextStyle(
      fontFamily: 'Arial',
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      height: 1.0,
      letterSpacing: 1.0,
      fontStyle: FontStyle.italic,
    ),
    button: TextStyle(
      fontFamily: 'Arial',
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      height: 1.0,
      letterSpacing: 2.0,
    ),
    monospace: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      height: 1.0,
      letterSpacing: 1.0,
    ),
    display: TextStyle(
      fontFamily: 'Arial',
      fontSize: 50.0,
      fontWeight: FontWeight.bold,
      height: 1.0,
      letterSpacing: 5.0,
    ),
  );

  // Tipografía cyberpunk
  static const BrutalTypography cyberpunkTypo = BrutalTypography(
    heading1: TextStyle(
      fontFamily: 'Arial',
      fontSize: 34.0,
      fontWeight: FontWeight.w900,
      height: 0.9,
      letterSpacing: -0.5,
    ),
    heading2: TextStyle(
      fontFamily: 'Arial',
      fontSize: 26.0,
      fontWeight: FontWeight.w800,
      height: 0.9,
      letterSpacing: -0.3,
    ),
    heading3: TextStyle(
      fontFamily: 'Arial',
      fontSize: 20.0,
      fontWeight: FontWeight.w700,
      height: 1.0,
    ),
    body: TextStyle(
      fontFamily: 'Arial',
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      height: 1.3,
    ),
    caption: TextStyle(
      fontFamily: 'Arial',
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      height: 1.0,
    ),
    button: TextStyle(
      fontFamily: 'Arial',
      fontSize: 16.0,
      fontWeight: FontWeight.w900,
      height: 1.0,
      letterSpacing: 1.0,
    ),
    monospace: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      height: 1.2,
    ),
    display: TextStyle(
      fontFamily: 'Arial',
      fontSize: 48.0,
      fontWeight: FontWeight.w900,
      height: 0.9,
      letterSpacing: -1.0,
    ),
  );

  // Tipografía construcción
  static const BrutalTypography constructionTypo = BrutalTypography(
    heading1: TextStyle(
      fontFamily: 'Impact',
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      height: 1.1,
      letterSpacing: 0.0,
    ),
    heading2: TextStyle(
      fontFamily: 'Impact',
      fontSize: 26.0,
      fontWeight: FontWeight.bold,
      height: 1.1,
      letterSpacing: 0.0,
    ),
    heading3: TextStyle(
      fontFamily: 'Impact',
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      height: 1.1,
    ),
    body: TextStyle(
      fontFamily: 'Arial',
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      height: 1.4,
    ),
    caption: TextStyle(
      fontFamily: 'Arial',
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      height: 1.2,
    ),
    button: TextStyle(
      fontFamily: 'Impact',
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      height: 1.0,
    ),
    monospace: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 16.0,
      height: 1.4,
    ),
    display: TextStyle(
      fontFamily: 'Impact',
      fontSize: 44.0,
      fontWeight: FontWeight.bold,
      height: 1.0,
      letterSpacing: -0.5,
    ),
  );

  // ============ NUEVAS TIPOGRAFÍAS ULTRA BRUTALES ============

  // Tipografía INDUSTRIAL - Para temas pesados
  static const BrutalTypography industrialTypo = BrutalTypography(
    heading1: TextStyle(
      fontFamily: 'Impact',
      fontSize: 38.0,
      fontWeight: FontWeight.w900,
      height: 0.8,
      letterSpacing: -1.0,
    ),
    heading2: TextStyle(
      fontFamily: 'Impact',
      fontSize: 30.0,
      fontWeight: FontWeight.w900,
      height: 0.9,
      letterSpacing: -0.5,
    ),
    heading3: TextStyle(
      fontFamily: 'Impact',
      fontSize: 24.0,
      fontWeight: FontWeight.w800,
      height: 0.9,
    ),
    body: TextStyle(
      fontFamily: 'Arial',
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      height: 1.2,
    ),
    caption: TextStyle(
      fontFamily: 'Arial',
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      height: 1.1,
    ),
    button: TextStyle(
      fontFamily: 'Impact',
      fontSize: 18.0,
      fontWeight: FontWeight.w900,
      height: 1.0,
      letterSpacing: 1.0,
    ),
    monospace: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      height: 1.0,
    ),
    display: TextStyle(
      fontFamily: 'Impact',
      fontSize: 60.0,
      fontWeight: FontWeight.w900,
      height: 0.8,
      letterSpacing: -2.0,
    ),
  );

  // Tipografía AGRESIVA - Para temas de guerra
  static const BrutalTypography aggressiveTypo = BrutalTypography(
    heading1: TextStyle(
      fontFamily: 'Impact',
      fontSize: 40.0,
      fontWeight: FontWeight.w900,
      height: 0.7,
      letterSpacing: -2.0,
    ),
    heading2: TextStyle(
      fontFamily: 'Impact',
      fontSize: 32.0,
      fontWeight: FontWeight.w900,
      height: 0.8,
      letterSpacing: -1.5,
    ),
    heading3: TextStyle(
      fontFamily: 'Impact',
      fontSize: 26.0,
      fontWeight: FontWeight.w800,
      height: 0.8,
      letterSpacing: -1.0,
    ),
    body: TextStyle(
      fontFamily: 'Arial',
      fontSize: 16.0,
      fontWeight: FontWeight.w700,
      height: 1.1,
    ),
    caption: TextStyle(
      fontFamily: 'Arial',
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      height: 1.0,
    ),
    button: TextStyle(
      fontFamily: 'Impact',
      fontSize: 18.0,
      fontWeight: FontWeight.w900,
      height: 0.9,
      letterSpacing: 2.0,
    ),
    monospace: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      height: 0.9,
    ),
    display: TextStyle(
      fontFamily: 'Impact',
      fontSize: 70.0,
      fontWeight: FontWeight.w900,
      height: 0.7,
      letterSpacing: -3.0,
    ),
  );

  // Tipografía RADIOACTIVA - Para temas tóxicos
  static const BrutalTypography radioactiveTypo = BrutalTypography(
    heading1: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 36.0,
      fontWeight: FontWeight.bold,
      height: 1.0,
      letterSpacing: 2.0,
    ),
    heading2: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
      height: 1.0,
      letterSpacing: 1.5,
    ),
    heading3: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
      height: 1.0,
      letterSpacing: 1.0,
    ),
    body: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      height: 1.1,
      letterSpacing: 0.5,
    ),
    caption: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      height: 1.0,
      letterSpacing: 0.5,
    ),
    button: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      height: 1.0,
      letterSpacing: 3.0,
    ),
    monospace: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      height: 1.0,
      letterSpacing: 1.0,
    ),
    display: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 50.0,
      fontWeight: FontWeight.bold,
      height: 1.0,
      letterSpacing: 4.0,
    ),
  );

  // Tipografía QUEMADA - Para temas de fuego
  static const BrutalTypography burnedTypo = BrutalTypography(
    heading1: TextStyle(
      fontFamily: 'Impact',
      fontSize: 42.0,
      fontWeight: FontWeight.w900,
      height: 0.9,
      letterSpacing: -1.0,
    ),
    heading2: TextStyle(
      fontFamily: 'Impact',
      fontSize: 34.0,
      fontWeight: FontWeight.w900,
      height: 0.9,
      letterSpacing: -0.5,
    ),
    heading3: TextStyle(
      fontFamily: 'Impact',
      fontSize: 26.0,
      fontWeight: FontWeight.w800,
      height: 0.9,
    ),
    body: TextStyle(
      fontFamily: 'Arial',
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      height: 1.3,
    ),
    caption: TextStyle(
      fontFamily: 'Arial',
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      height: 1.2,
    ),
    button: TextStyle(
      fontFamily: 'Impact',
      fontSize: 18.0,
      fontWeight: FontWeight.w900,
      height: 1.0,
      letterSpacing: 1.5,
    ),
    monospace: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      height: 1.2,
    ),
    display: TextStyle(
      fontFamily: 'Impact',
      fontSize: 65.0,
      fontWeight: FontWeight.w900,
      height: 0.8,
      letterSpacing: -2.5,
    ),
  );

  // Tipografía CONGELADA - Para temas de hielo
  static const BrutalTypography frozenTypo = BrutalTypography(
    heading1: TextStyle(
      fontFamily: 'Arial',
      fontSize: 34.0,
      fontWeight: FontWeight.w300,
      height: 1.4,
      letterSpacing: 3.0,
    ),
    heading2: TextStyle(
      fontFamily: 'Arial',
      fontSize: 26.0,
      fontWeight: FontWeight.w300,
      height: 1.4,
      letterSpacing: 2.5,
    ),
    heading3: TextStyle(
      fontFamily: 'Arial',
      fontSize: 20.0,
      fontWeight: FontWeight.w400,
      height: 1.4,
      letterSpacing: 2.0,
    ),
    body: TextStyle(
      fontFamily: 'Arial',
      fontSize: 16.0,
      fontWeight: FontWeight.w300,
      height: 1.6,
      letterSpacing: 1.0,
    ),
    caption: TextStyle(
      fontFamily: 'Arial',
      fontSize: 14.0,
      fontWeight: FontWeight.w300,
      height: 1.5,
      letterSpacing: 1.0,
    ),
    button: TextStyle(
      fontFamily: 'Arial',
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      height: 1.2,
      letterSpacing: 2.0,
    ),
    monospace: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 16.0,
      fontWeight: FontWeight.w300,
      height: 1.6,
      letterSpacing: 1.5,
    ),
    display: TextStyle(
      fontFamily: 'Arial',
      fontSize: 52.0,
      fontWeight: FontWeight.w100,
      height: 1.3,
      letterSpacing: 6.0,
    ),
  );

  // Tipografía CÓSMICA - Para temas espaciales
  static const BrutalTypography cosmicTypo = BrutalTypography(
    heading1: TextStyle(
      fontFamily: 'Arial',
      fontSize: 38.0,
      fontWeight: FontWeight.w200,
      height: 1.1,
      letterSpacing: 5.0,
    ),
    heading2: TextStyle(
      fontFamily: 'Arial',
      fontSize: 30.0,
      fontWeight: FontWeight.w300,
      height: 1.2,
      letterSpacing: 4.0,
    ),
    heading3: TextStyle(
      fontFamily: 'Arial',
      fontSize: 24.0,
      fontWeight: FontWeight.w400,
      height: 1.2,
      letterSpacing: 3.0,
    ),
    body: TextStyle(
      fontFamily: 'Arial',
      fontSize: 16.0,
      fontWeight: FontWeight.w300,
      height: 1.5,
      letterSpacing: 1.5,
    ),
    caption: TextStyle(
      fontFamily: 'Arial',
      fontSize: 14.0,
      fontWeight: FontWeight.w300,
      height: 1.4,
      letterSpacing: 1.0,
    ),
    button: TextStyle(
      fontFamily: 'Arial',
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      height: 1.0,
      letterSpacing: 3.0,
    ),
    monospace: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 16.0,
      fontWeight: FontWeight.w300,
      height: 1.5,
      letterSpacing: 2.0,
    ),
    display: TextStyle(
      fontFamily: 'Arial',
      fontSize: 60.0,
      fontWeight: FontWeight.w100,
      height: 1.0,
      letterSpacing: 8.0,
    ),
  );

  // Tipografía PSICODÉLICA - Para temas trippy
  static const BrutalTypography psychedelicTypo = BrutalTypography(
    heading1: TextStyle(
      fontFamily: 'Arial',
      fontSize: 44.0,
      fontWeight: FontWeight.bold,
      height: 0.8,
      letterSpacing: 4.0,
    ),
    heading2: TextStyle(
      fontFamily: 'Arial',
      fontSize: 36.0,
      fontWeight: FontWeight.bold,
      height: 0.9,
      letterSpacing: 3.0,
    ),
    heading3: TextStyle(
      fontFamily: 'Arial',
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
      height: 0.9,
      letterSpacing: 2.0,
    ),
    body: TextStyle(
      fontFamily: 'Arial',
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      height: 1.0,
      letterSpacing: 1.0,
    ),
    caption: TextStyle(
      fontFamily: 'Arial',
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      height: 1.0,
      letterSpacing: 1.5,
    ),
    button: TextStyle(
      fontFamily: 'Arial',
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      height: 1.0,
      letterSpacing: 4.0,
    ),
    monospace: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      height: 1.0,
      letterSpacing: 2.0,
    ),
    display: TextStyle(
      fontFamily: 'Arial',
      fontSize: 72.0,
      fontWeight: FontWeight.w900,
      height: 0.7,
      letterSpacing: 6.0,
    ),
  );

  // Tipografía SYNTHWAVE - Para temas retro futuristas
  static const BrutalTypography synthwaveTypo = BrutalTypography(
    heading1: TextStyle(
      fontFamily: 'Arial',
      fontSize: 40.0,
      fontWeight: FontWeight.w800,
      height: 0.9,
      letterSpacing: 2.0,
    ),
    heading2: TextStyle(
      fontFamily: 'Arial',
      fontSize: 32.0,
      fontWeight: FontWeight.w700,
      height: 0.9,
      letterSpacing: 1.5,
    ),
    heading3: TextStyle(
      fontFamily: 'Arial',
      fontSize: 26.0,
      fontWeight: FontWeight.w600,
      height: 1.0,
      letterSpacing: 1.0,
    ),
    body: TextStyle(
      fontFamily: 'Arial',
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      height: 1.3,
      letterSpacing: 0.5,
    ),
    caption: TextStyle(
      fontFamily: 'Arial',
      fontSize: 14.0,
      fontWeight: FontWeight.w300,
      height: 1.2,
      letterSpacing: 1.0,
    ),
    button: TextStyle(
      fontFamily: 'Arial',
      fontSize: 16.0,
      fontWeight: FontWeight.w700,
      height: 1.0,
      letterSpacing: 2.5,
    ),
    monospace: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      height: 1.3,
      letterSpacing: 1.0,
    ),
    display: TextStyle(
      fontFamily: 'Arial',
      fontSize: 58.0,
      fontWeight: FontWeight.w900,
      height: 0.8,
      letterSpacing: 4.0,
    ),
  );

  // Tipografía TERMINAL - Para temas hacker
  static const BrutalTypography terminalTypo = BrutalTypography(
    heading1: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      height: 1.0,
      letterSpacing: 0.0,
    ),
    heading2: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 26.0,
      fontWeight: FontWeight.bold,
      height: 1.0,
      letterSpacing: 0.0,
    ),
    heading3: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      height: 1.0,
      letterSpacing: 0.0,
    ),
    body: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      height: 1.2,
      letterSpacing: 0.0,
    ),
    caption: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      height: 1.1,
      letterSpacing: 0.0,
    ),
    button: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      height: 1.0,
      letterSpacing: 0.0,
    ),
    monospace: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      height: 1.2,
      letterSpacing: 0.0,
    ),
    display: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 48.0,
      fontWeight: FontWeight.bold,
      height: 1.0,
      letterSpacing: 0.0,
    ),
  );

  // Tipografía PUNK - Para temas agresivos
  static const BrutalTypography punkTypo = BrutalTypography(
    heading1: TextStyle(
      fontFamily: 'Impact',
      fontSize: 46.0,
      fontWeight: FontWeight.w900,
      height: 0.7,
      letterSpacing: -2.0,
    ),
    heading2: TextStyle(
      fontFamily: 'Impact',
      fontSize: 38.0,
      fontWeight: FontWeight.w900,
      height: 0.7,
      letterSpacing: -1.5,
    ),
    heading3: TextStyle(
      fontFamily: 'Impact',
      fontSize: 30.0,
      fontWeight: FontWeight.w800,
      height: 0.8,
      letterSpacing: -1.0,
    ),
    body: TextStyle(
      fontFamily: 'Arial',
      fontSize: 16.0,
      fontWeight: FontWeight.w700,
      height: 1.0,
      letterSpacing: 0.0,
    ),
    caption: TextStyle(
      fontFamily: 'Arial',
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      height: 1.0,
      letterSpacing: 0.0,
    ),
    button: TextStyle(
      fontFamily: 'Impact',
      fontSize: 18.0,
      fontWeight: FontWeight.w900,
      height: 0.8,
      letterSpacing: 1.0,
    ),
    monospace: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      height: 1.0,
      letterSpacing: 0.0,
    ),
    display: TextStyle(
      fontFamily: 'Impact',
      fontSize: 80.0,
      fontWeight: FontWeight.w900,
      height: 0.6,
      letterSpacing: -4.0,
    ),
  );

  // Tipografía SOMBRA - Para temas oscuros
  static const BrutalTypography shadowTypo = BrutalTypography(
    heading1: TextStyle(
      fontFamily: 'Arial',
      fontSize: 28.0,
      fontWeight: FontWeight.w200,
      height: 1.6,
      letterSpacing: 2.0,
    ),
    heading2: TextStyle(
      fontFamily: 'Arial',
      fontSize: 22.0,
      fontWeight: FontWeight.w200,
      height: 1.6,
      letterSpacing: 1.5,
    ),
    heading3: TextStyle(
      fontFamily: 'Arial',
      fontSize: 18.0,
      fontWeight: FontWeight.w300,
      height: 1.6,
      letterSpacing: 1.0,
    ),
    body: TextStyle(
      fontFamily: 'Arial',
      fontSize: 14.0,
      fontWeight: FontWeight.w200,
      height: 1.8,
      letterSpacing: 0.5,
    ),
    caption: TextStyle(
      fontFamily: 'Arial',
      fontSize: 12.0,
      fontWeight: FontWeight.w200,
      height: 1.7,
      letterSpacing: 0.5,
    ),
    button: TextStyle(
      fontFamily: 'Arial',
      fontSize: 14.0,
      fontWeight: FontWeight.w300,
      height: 1.4,
      letterSpacing: 1.0,
    ),
    monospace: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 14.0,
      fontWeight: FontWeight.w200,
      height: 1.8,
      letterSpacing: 0.5,
    ),
    display: TextStyle(
      fontFamily: 'Arial',
      fontSize: 36.0,
      fontWeight: FontWeight.w100,
      height: 1.5,
      letterSpacing: 4.0,
    ),
  );

  // Tipografía METÁLICA - Para temas industriales
  static const BrutalTypography metallicTypo = BrutalTypography(
    heading1: TextStyle(
      fontFamily: 'Impact',
      fontSize: 36.0,
      fontWeight: FontWeight.w900,
      height: 1.0,
      letterSpacing: 0.0,
    ),
    heading2: TextStyle(
      fontFamily: 'Impact',
      fontSize: 28.0,
      fontWeight: FontWeight.w900,
      height: 1.0,
      letterSpacing: 0.0,
    ),
    heading3: TextStyle(
      fontFamily: 'Impact',
      fontSize: 22.0,
      fontWeight: FontWeight.w800,
      height: 1.0,
      letterSpacing: 0.0,
    ),
    body: TextStyle(
      fontFamily: 'Arial',
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      height: 1.3,
      letterSpacing: 0.0,
    ),
    caption: TextStyle(
      fontFamily: 'Arial',
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      height: 1.2,
      letterSpacing: 0.0,
    ),
    button: TextStyle(
      fontFamily: 'Impact',
      fontSize: 16.0,
      fontWeight: FontWeight.w900,
      height: 1.0,
      letterSpacing: 1.0,
    ),
    monospace: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      height: 1.3,
      letterSpacing: 0.0,
    ),
    display: TextStyle(
      fontFamily: 'Impact',
      fontSize: 56.0,
      fontWeight: FontWeight.w900,
      height: 0.9,
      letterSpacing: -1.0,
    ),
  );

  // Tipografía ELÉCTRICA - Para temas de voltaje
  static const BrutalTypography electricTypo = BrutalTypography(
    heading1: TextStyle(
      fontFamily: 'Arial',
      fontSize: 42.0,
      fontWeight: FontWeight.w900,
      height: 0.8,
      letterSpacing: 3.0,
    ),
    heading2: TextStyle(
      fontFamily: 'Arial',
      fontSize: 34.0,
      fontWeight: FontWeight.w800,
      height: 0.8,
      letterSpacing: 2.0,
    ),
    heading3: TextStyle(
      fontFamily: 'Arial',
      fontSize: 26.0,
      fontWeight: FontWeight.w700,
      height: 0.9,
      letterSpacing: 1.5,
    ),
    body: TextStyle(
      fontFamily: 'Arial',
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      height: 1.2,
      letterSpacing: 0.5,
    ),
    caption: TextStyle(
      fontFamily: 'Arial',
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      height: 1.1,
      letterSpacing: 0.5,
    ),
    button: TextStyle(
      fontFamily: 'Arial',
      fontSize: 18.0,
      fontWeight: FontWeight.w900,
      height: 1.0,
      letterSpacing: 2.5,
    ),
    monospace: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      height: 1.2,
      letterSpacing: 1.0,
    ),
    display: TextStyle(
      fontFamily: 'Arial',
      fontSize: 68.0,
      fontWeight: FontWeight.w900,
      height: 0.7,
      letterSpacing: 5.0,
    ),
  );

  // Tipografía OXIDADA - Para temas post-apocalípticos
  static const BrutalTypography rustedTypo = BrutalTypography(
    heading1: TextStyle(
      fontFamily: 'Arial',
      fontSize: 34.0,
      fontWeight: FontWeight.w600,
      height: 1.2,
      letterSpacing: 1.0,
    ),
    heading2: TextStyle(
      fontFamily: 'Arial',
      fontSize: 26.0,
      fontWeight: FontWeight.w600,
      height: 1.3,
      letterSpacing: 0.5,
    ),
    heading3: TextStyle(
      fontFamily: 'Arial',
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      height: 1.3,
      letterSpacing: 0.0,
    ),
    body: TextStyle(
      fontFamily: 'Arial',
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      height: 1.5,
      letterSpacing: 0.0,
    ),
    caption: TextStyle(
      fontFamily: 'Arial',
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      height: 1.4,
      letterSpacing: 0.0,
    ),
    button: TextStyle(
      fontFamily: 'Arial',
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      height: 1.2,
      letterSpacing: 0.5,
    ),
    monospace: TextStyle(
      fontFamily: 'Courier New',
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      height: 1.5,
      letterSpacing: 0.0,
    ),
    display: TextStyle(
      fontFamily: 'Arial',
      fontSize: 48.0,
      fontWeight: FontWeight.w700,
      height: 1.1,
      letterSpacing: 2.0,
    ),
  );
}
