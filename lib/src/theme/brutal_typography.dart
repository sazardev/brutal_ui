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
}
