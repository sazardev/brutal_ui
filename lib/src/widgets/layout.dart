import 'package:flutter/widgets.dart';
import 'dart:math' as math;
import '../theme/brutal_theme.dart';

/// Una versión brutalista de Row con opciones adicionales de diseño
class BrutalRow extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final bool hasBorder;
  final bool isJagged; // Para efecto desalineado
  final bool isGlitched;
  final Color? borderColor;
  final double? borderWidth;
  final EdgeInsetsGeometry? padding;
  final double jaggedIntensity; // Controla cuánto se desalinean los elementos

  const BrutalRow({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.hasBorder = false,
    this.isJagged = false,
    this.isGlitched = false,
    this.borderColor,
    this.borderWidth,
    this.padding,
    this.jaggedIntensity = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);
    final effectiveBorderWidth = borderWidth ?? theme.borderWidth;
    final effectiveBorderColor = borderColor ?? theme.colors.border;

    // Widget base
    Widget rowWidget;

    // Aplicar efecto jagged (desalineado) si corresponde
    if (isJagged && children.isNotEmpty) {
      // Crear una versión con elementos desalineados verticalmente
      List<Widget> jaggedChildren = [];

      for (int i = 0; i < children.length; i++) {
        // Calcular un desplazamiento aleatorio pero consistente basado en el índice
        final jaggedOffset = (i % 3 - 1) * jaggedIntensity;

        jaggedChildren.add(
          Transform.translate(
            offset: Offset(0, jaggedOffset),
            child: children[i],
          ),
        );
      }

      rowWidget = Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        children: jaggedChildren,
      );
    } else {
      // Versión normal sin desalineación
      rowWidget = Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        children: children,
      );
    }

    // Aplicar borde si es necesario
    if (hasBorder) {
      rowWidget = Container(
        padding: padding,
        decoration: BoxDecoration(
          border: Border.all(
            color: effectiveBorderColor,
            width: effectiveBorderWidth,
          ),
        ),
        child: rowWidget,
      );
    } else if (padding != null) {
      // Aplicar padding aunque no haya borde
      rowWidget = Padding(padding: padding!, child: rowWidget);
    }

    // Aplicar efecto glitch si está habilitado
    if (isGlitched) {
      rowWidget = Stack(
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
                child: rowWidget,
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
                child: rowWidget,
              ),
            ),
          ),
          rowWidget,
        ],
      );
    }

    return rowWidget;
  }
}

/// Una versión brutalista de Column con opciones adicionales de diseño
class BrutalColumn extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final bool hasBorder;
  final bool isJagged; // Para efecto desalineado
  final bool isGlitched;
  final Color? borderColor;
  final double? borderWidth;
  final EdgeInsetsGeometry? padding;
  final double jaggedIntensity; // Controla cuánto se desalinean los elementos

  const BrutalColumn({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.hasBorder = false,
    this.isJagged = false,
    this.isGlitched = false,
    this.borderColor,
    this.borderWidth,
    this.padding,
    this.jaggedIntensity = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);
    final effectiveBorderWidth = borderWidth ?? theme.borderWidth;
    final effectiveBorderColor = borderColor ?? theme.colors.border;

    // Widget base
    Widget columnWidget;

    // Aplicar efecto jagged (desalineado) si corresponde
    if (isJagged && children.isNotEmpty) {
      // Crear una versión con elementos desalineados horizontalmente
      List<Widget> jaggedChildren = [];

      for (int i = 0; i < children.length; i++) {
        // Calcular un desplazamiento aleatorio pero consistente basado en el índice
        final jaggedOffset = (i % 3 - 1) * jaggedIntensity;

        jaggedChildren.add(
          Transform.translate(
            offset: Offset(jaggedOffset, 0),
            child: children[i],
          ),
        );
      }

      columnWidget = Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        children: jaggedChildren,
      );
    } else {
      // Versión normal sin desalineación
      columnWidget = Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        children: children,
      );
    }

    // Aplicar borde si es necesario
    if (hasBorder) {
      columnWidget = Container(
        padding: padding,
        decoration: BoxDecoration(
          border: Border.all(
            color: effectiveBorderColor,
            width: effectiveBorderWidth,
          ),
        ),
        child: columnWidget,
      );
    } else if (padding != null) {
      // Aplicar padding aunque no haya borde
      columnWidget = Padding(padding: padding!, child: columnWidget);
    }

    // Aplicar efecto glitch si está habilitado
    if (isGlitched) {
      columnWidget = Stack(
        children: [
          Positioned(
            top: 2,
            child: Opacity(
              opacity: 0.7,
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Color(0xFFFF0000),
                  BlendMode.srcATop,
                ),
                child: columnWidget,
              ),
            ),
          ),
          Positioned(
            top: -2,
            child: Opacity(
              opacity: 0.7,
              child: ColorFiltered(
                colorFilter: const ColorFilter.mode(
                  Color(0xFF00FFFF),
                  BlendMode.srcATop,
                ),
                child: columnWidget,
              ),
            ),
          ),
          columnWidget,
        ],
      );
    }

    return columnWidget;
  }
}

// Añadir después de BrutalColumn

/// Una cuadrícula brutalista para organizar elementos
class BrutalGrid extends StatelessWidget {
  final List<Widget> children;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final bool hasBorder;
  final bool isSkewed; // Aplica una ligera rotación para un efecto brutalista
  final Color? borderColor;
  final double? borderWidth;
  final EdgeInsetsGeometry? padding;

  const BrutalGrid({
    super.key,
    required this.children,
    required this.crossAxisCount,
    this.mainAxisSpacing = 10,
    this.crossAxisSpacing = 10,
    this.hasBorder = false,
    this.isSkewed = false,
    this.borderColor,
    this.borderWidth,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);
    final effectiveBorderWidth = borderWidth ?? theme.borderWidth;
    final effectiveBorderColor = borderColor ?? theme.colors.border;

    // Calcular el ancho y la altura de cada elemento
    final childCrossAxisExtent = 1.0 / crossAxisCount;

    Widget gridWidget = Wrap(
      spacing: crossAxisSpacing,
      runSpacing: mainAxisSpacing,
      children:
          children.asMap().entries.map((entry) {
            final index = entry.key;
            final child = entry.value;

            // Aplicar skew a los elementos si está activado
            if (isSkewed) {
              // Alternar la dirección del skew basado en la posición
              final skewAngle = (index % 2 == 0) ? 0.02 : -0.02;
              return Transform(
                transform: Matrix4.skewX(skewAngle),
                child: SizedBox(
                  width:
                      childCrossAxisExtent *
                      (MediaQuery.of(context).size.width -
                          crossAxisSpacing * (crossAxisCount - 1) -
                          (padding?.horizontal ?? 0)),
                  child: child,
                ),
              );
            }

            // Sin skew
            return SizedBox(
              width:
                  childCrossAxisExtent *
                  (MediaQuery.of(context).size.width -
                      crossAxisSpacing * (crossAxisCount - 1) -
                      (padding?.horizontal ?? 0)),
              child: child,
            );
          }).toList(),
    );

    // Aplicar borde si es necesario
    if (hasBorder) {
      gridWidget = Container(
        padding: padding,
        decoration: BoxDecoration(
          border: Border.all(
            color: effectiveBorderColor,
            width: effectiveBorderWidth,
          ),
        ),
        child: gridWidget,
      );
    } else if (padding != null) {
      // Aplicar padding aunque no haya borde
      gridWidget = Padding(padding: padding!, child: gridWidget);
    }

    return gridWidget;
  }
}

/// Una lista brutalista para mostrar elementos en secuencia
class BrutalList extends StatelessWidget {
  final List<Widget> children;
  final bool hasSeparators;
  final bool hasBorder;
  final bool hasAlternatingColors;
  final Color? borderColor;
  final Color? separatorColor;
  final Color? alternateColor;
  final double? borderWidth;
  final double? separatorWidth;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? itemPadding;
  final Axis direction;
  final ScrollPhysics? physics;

  const BrutalList({
    super.key,
    required this.children,
    this.hasSeparators = false,
    this.hasBorder = false,
    this.hasAlternatingColors = false,
    this.borderColor,
    this.separatorColor,
    this.alternateColor,
    this.borderWidth,
    this.separatorWidth,
    this.padding,
    this.itemPadding,
    this.direction = Axis.vertical,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);
    final effectiveBorderWidth = borderWidth ?? theme.borderWidth;
    final effectiveBorderColor = borderColor ?? theme.colors.border;
    final effectiveSeparatorColor = separatorColor ?? theme.colors.border;
    final effectiveSeparatorWidth = separatorWidth ?? 1.0;
    final effectiveAlternateColor =
        alternateColor ?? theme.colors.surface.withOpacity(0.5);

    // Construir la lista de widgets con separadores si es necesario
    List<Widget> listItems = [];

    for (int i = 0; i < children.length; i++) {
      // Aplicar colores alternos si está habilitado
      Widget child = children[i];

      if (hasAlternatingColors && i % 2 == 1) {
        child = Container(color: effectiveAlternateColor, child: child);
      }

      // Aplicar padding al elemento si está definido
      if (itemPadding != null) {
        child = Padding(padding: itemPadding!, child: child);
      }

      listItems.add(child);

      // Añadir separador excepto para el último elemento
      if (hasSeparators && i < children.length - 1) {
        if (direction == Axis.vertical) {
          listItems.add(
            Container(
              height: effectiveSeparatorWidth,
              color: effectiveSeparatorColor,
            ),
          );
        } else {
          listItems.add(
            Container(
              width: effectiveSeparatorWidth,
              color: effectiveSeparatorColor,
            ),
          );
        }
      }
    }

    // Crear el widget final
    Widget listWidget;

    if (direction == Axis.vertical) {
      listWidget = SingleChildScrollView(
        scrollDirection: direction,
        physics: physics,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: listItems,
        ),
      );
    } else {
      listWidget = SingleChildScrollView(
        scrollDirection: direction,
        physics: physics,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: listItems,
        ),
      );
    }

    // Aplicar borde si es necesario
    if (hasBorder) {
      listWidget = Container(
        padding: padding,
        decoration: BoxDecoration(
          border: Border.all(
            color: effectiveBorderColor,
            width: effectiveBorderWidth,
          ),
        ),
        child: listWidget,
      );
    } else if (padding != null) {
      // Aplicar padding aunque no haya borde
      listWidget = Padding(padding: padding!, child: listWidget);
    }

    return listWidget;
  }
}

// Añadir después de BrutalList

/// Una versión brutalista de Stack con opciones adicionales
class BrutalStack extends StatelessWidget {
  final List<Widget> children;
  final AlignmentGeometry alignment;
  final bool hasBorder;
  final bool isGlitched;
  final bool isRotated;
  final Color? borderColor;
  final double? borderWidth;
  final EdgeInsetsGeometry? padding;

  const BrutalStack({
    super.key,
    required this.children,
    this.alignment = Alignment.topLeft,
    this.hasBorder = false,
    this.isGlitched = false,
    this.isRotated = false,
    this.borderColor,
    this.borderWidth,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);
    final effectiveBorderWidth = borderWidth ?? theme.borderWidth;
    final effectiveBorderColor = borderColor ?? theme.colors.border;

    Widget stackWidget = Stack(alignment: alignment, children: children);

    // Aplicar borde si es necesario
    if (hasBorder) {
      stackWidget = Container(
        padding: padding,
        decoration: BoxDecoration(
          border: Border.all(
            color: effectiveBorderColor,
            width: effectiveBorderWidth,
          ),
        ),
        child: stackWidget,
      );
    } else if (padding != null) {
      // Aplicar padding aunque no haya borde
      stackWidget = Padding(padding: padding!, child: stackWidget);
    }

    // Aplicar rotación si está habilitado
    if (isRotated) {
      // Rotación sutil y aleatoria
      final angle = (math.Random().nextDouble() * 6 - 3) * (math.pi / 180);
      stackWidget = Transform.rotate(angle: angle, child: stackWidget);
    }

    // Aplicar efecto glitch si está habilitado
    if (isGlitched) {
      stackWidget = Stack(
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
                child: stackWidget,
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
                child: stackWidget,
              ),
            ),
          ),
          stackWidget,
        ],
      );
    }

    return stackWidget;
  }
}

/// Un contenedor flexible brutalista similar a Wrap
class BrutalWrapper extends StatelessWidget {
  final List<Widget> children;
  final Axis direction;
  final WrapAlignment alignment;
  final double spacing;
  final double runSpacing;
  final bool hasBorder;
  final bool isJagged; // Para desalineamiento brutalista
  final Color? borderColor;
  final double? borderWidth;
  final EdgeInsetsGeometry? padding;

  const BrutalWrapper({
    super.key,
    required this.children,
    this.direction = Axis.horizontal,
    this.alignment = WrapAlignment.start,
    this.spacing = 8.0,
    this.runSpacing = 8.0,
    this.hasBorder = false,
    this.isJagged = false,
    this.borderColor,
    this.borderWidth,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = BrutalTheme.of(context);
    final effectiveBorderWidth = borderWidth ?? theme.borderWidth;
    final effectiveBorderColor = borderColor ?? theme.colors.border;

    // Widget base
    Widget wrapWidget;

    // Aplicar efecto jagged (desalineado) si corresponde
    if (isJagged && children.isNotEmpty) {
      // Crear una versión con elementos desalineados
      List<Widget> jaggedChildren = [];

      for (int i = 0; i < children.length; i++) {
        // Desplazamiento para efecto brutalista
        final offsetY = (i % 3 - 1) * 2.0;

        jaggedChildren.add(
          Transform.translate(offset: Offset(0, offsetY), child: children[i]),
        );
      }

      wrapWidget = Wrap(
        direction: direction,
        alignment: alignment,
        spacing: spacing,
        runSpacing: runSpacing,
        children: jaggedChildren,
      );
    } else {
      // Versión normal sin desalineación
      wrapWidget = Wrap(
        direction: direction,
        alignment: alignment,
        spacing: spacing,
        runSpacing: runSpacing,
        children: children,
      );
    }

    // Aplicar borde si es necesario
    if (hasBorder) {
      wrapWidget = Container(
        padding: padding,
        decoration: BoxDecoration(
          border: Border.all(
            color: effectiveBorderColor,
            width: effectiveBorderWidth,
          ),
        ),
        child: wrapWidget,
      );
    } else if (padding != null) {
      // Aplicar padding aunque no haya borde
      wrapWidget = Padding(padding: padding!, child: wrapWidget);
    }

    return wrapWidget;
  }
}
